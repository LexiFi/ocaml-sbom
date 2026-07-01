(* Quick overlay functional test *)

let doc_json =
  {|{
  "format": "ocaml-sbom/1.0",
  "namespace": "12345678-1234-1234-1234-123456789abc",
  "root_components": [ "pkg:opam/myproject@1.0.0" ],
  "components": [
    {
      "key": "pkg:opam/myproject@1.0.0",
      "name": "myproject",
      "version": "1.0.0",
      "kind": { "Opam_package": "Unknown" },
      "authors": [],
      "maintainers": [],
      "licensing": { "declared": "Unknown", "concluded": "Unknown" },
      "tags": [],
      "source_distribution": { "url": "", "checksums": [] }
    },
    {
      "key": "pkg:opam/depA@2.0.0",
      "name": "depA",
      "version": "2.0.0",
      "kind": { "Opam_package": "Unknown" },
      "authors": [],
      "maintainers": [],
      "licensing": { "declared": "Unknown", "concluded": "Unknown" },
      "tags": [],
      "source_distribution": { "url": "", "checksums": [] }
    },
    {
      "key": "pkg:opam/depB@2.0.0",
      "name": "depB",
      "version": "2.0.0",
      "kind": { "Opam_package": "Unknown" },
      "authors": [],
      "maintainers": [],
      "licensing": { "declared": "Unknown", "concluded": "Unknown" },
      "tags": [],
      "source_distribution": { "url": "", "checksums": [] }
    }
  ],
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
}
|}

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
    { "Remove_component": { "name": "depA", "recursive": false } }
  ]
}
|}

let test_overlay =
  Testo.create "overlay" (fun () ->
      let doc = Sbom_types.Ocaml_sbom.Document.of_json doc_json in
      let overlay =
        Sbom_types.Ocaml_sbom_overlay.Document_overlay.of_json overlay_json
      in
      let patched = Sbom_gen.Overlay.apply doc overlay in
      assert (List.length patched.Sbom_types.Ocaml_sbom.components = 2);
      assert (List.length patched.Sbom_types.Ocaml_sbom.dep_edges = 0);
      let myproject = List.hd patched.Sbom_types.Ocaml_sbom.components in
      match myproject.Sbom_types.Ocaml_sbom.licensing.declared with
      | Sbom_types.Ocaml_sbom.Known _ -> ()
      | _ -> failwith "expected Known license after Set_properties")

let tests = [ test_overlay ]
