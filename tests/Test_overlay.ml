(* Overlay tests *)

open Printf
module S = Sbom_types.Ocaml_sbom

let version_of_purl purl =
  match String.split_on_char '@' purl with
  | [ _; v ] -> v
  | _ -> failwith (sprintf "version_of_purl: unexpected PURL format: %S" purl)

let component_json key name =
  sprintf
    {|{
      "key": "%s",
      "name": "%s",
      "version": "%s",
      "kind": { "Opam_package": "Unknown" },
      "authors": [],
      "maintainers": [],
      "licensing": { "declared": "Unknown", "concluded": "Unknown" },
      "tags": [],
      "source_distribution": { "url": "", "checksums": [] }
    }|}
    key name (version_of_purl key)

(* myproject (root) -> depA -> depB *)
let doc_json =
  sprintf
    {|{
  "format": "ocaml-sbom/1.0",
  "namespace": "12345678-1234-1234-1234-123456789abc",
  "root_components": [ "pkg:opam/myproject@1.0.0" ],
  "components": [ %s, %s, %s ],
  "dep_edges": [
    {
      "src": "pkg:opam/myproject@1.0.0",
      "dst": "pkg:opam/depA@2.0.0",
      "scope": "Runtime"
    },
    {
      "src": "pkg:opam/depA@2.0.0",
      "dst": "pkg:opam/depB@2.0.0",
      "scope": "Runtime"
     }
  ]
}|}
    (component_json "pkg:opam/myproject@1.0.0" "myproject")
    (component_json "pkg:opam/depA@2.0.0" "depA")
    (component_json "pkg:opam/depB@2.0.0" "depB")

let parse ?overlay doc =
  let doc = S.Document.of_json doc in
  match overlay with
  | None -> doc
  | Some overlay ->
      let overlay =
        Sbom_types.Ocaml_sbom_overlay.Document_overlay.of_json overlay
      in
      Sbom_gen.Overlay.apply doc overlay
        ~overlay_path:(Fpath.v (sprintf "<in %s>" __FILE__))

(* Removing depA should cascade: depB loses its only dependent and is also
   removed, leaving only the root component. The license patch on myproject
   is also checked. *)
let test_remove_component =
  Testo.create "remove component and orphan dependencies" (fun () ->
      let overlay_json =
        {|{
  "format": "ocaml-sbom-overlay/1.0",
  "actions": [
    {
      "Set_component_properties": {
        "name": "myproject",
        "spdx_license": "MIT OR Apache-2.0"
      }
    },
    { "Remove_component": { "name": "depA" } }
  ]
}|}
      in
      let patched = parse doc_json ~overlay:overlay_json in
      Testo.(check int) ~msg:"components" 1 (List.length patched.S.components);
      Testo.(check int) ~msg:"edges" 0 (List.length patched.S.dep_edges);
      Testo.(check int)
        ~msg:"root components" 1
        (List.length patched.S.root_components);
      let myproject = List.hd patched.S.components in
      match myproject.S.licensing.declared with
      | S.Known _ -> ()
      | _ -> Testo.fail "expected Known license after Set_component_properties")

(* Adding a component via Add_component should register it as a root
   component in addition to placing it in the component list. *)
let test_add_component =
  Testo.create "add component becomes root" (fun () ->
      let overlay_json =
        sprintf
          {|{
  "format": "ocaml-sbom-overlay/1.0",
  "actions": [
    { "Add_component": %s }
  ]
}|}
          (component_json "pkg:opam/extra@3.0.0" "extra")
      in
      let patched = parse doc_json ~overlay:overlay_json in
      Testo.(check int) ~msg:"components" 4 (List.length patched.S.components);
      Testo.(check int)
        ~msg:"root components" 2
        (List.length patched.S.root_components);
      let root_keys =
        List.map
          (fun (p : Sbom_types.Purl.t) -> (p :> string))
          patched.S.root_components
      in
      if not (List.mem "pkg:opam/extra@3.0.0" root_keys) then
        Testo.fail "added component not found in root_components")

(* A cycle between depA and depB should be caught by Validate.sbom.
   We call the validator directly rather than through Overlay.apply because
   the overlay path is irrelevant here. *)
let test_cycle_validation =
  Testo.create "cycle detected by validation" (fun () ->
      let doc_json =
        sprintf
          {|{
  "format": "ocaml-sbom/1.0",
  "namespace": "12345678-1234-1234-1234-123456789abc",
  "root_components": [ "pkg:opam/myproject@1.0.0" ],
  "components": [ %s, %s, %s ],
  "dep_edges": [
    {
      "src": "pkg:opam/myproject@1.0.0",
      "dst": "pkg:opam/depA@1.0.0",
      "scope": "Runtime"
    },
    {
      "src": "pkg:opam/depA@1.0.0",
      "dst": "pkg:opam/depB@1.0.0",
      "scope": "Runtime"
    },
    {
      "src": "pkg:opam/depB@1.0.0",
      "dst": "pkg:opam/depA@1.0.0",
      "scope": "Runtime"
    }
  ]
}|}
          (component_json "pkg:opam/myproject@1.0.0" "myproject")
          (component_json "pkg:opam/depA@1.0.0" "depA")
          (component_json "pkg:opam/depB@1.0.0" "depB")
      in
      let doc = S.Document.of_json doc_json in
      match Sbom_types.Validate.sbom doc with
      | Ok () -> Testo.fail "expected validation to detect cycle"
      | Error msg ->
          Testo.(check text)
            "dependency cycle: pkg:opam/depA@1.0.0 -> pkg:opam/depB@1.0.0 -> \
             pkg:opam/depA@1.0.0"
            msg)

let tests =
  [ test_remove_component; test_add_component; test_cycle_validation ]
  |> Testo.categorize "overlay"
