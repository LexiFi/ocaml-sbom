(*
   Generate an SBOM in the internal format.
*)

open Printf
open Sbom_util.Path.Ops
module S = Sbom_types.Ocaml_sbom

let common_format_version = "1.0"
let ocaml_sbom_format = "ocaml-sbom/" ^ common_format_version

let list_scopes (scopes : Sbom_deps.Dep.scopes) : S.dep_scope list =
  let res = ref [] in
  let add (x : S.dep_scope) = res := x :: !res in
  if scopes.all then add All
  else (
    if scopes.build then add Build;
    if scopes.test then add Test;
    if scopes.doc then add Doc;
    if scopes.dev then add Dev);
  !res

let make_purl ({ kind; name; version } : Sbom_deps.Dep.component) =
  assert (kind = Opam);
  match Sbom_types.Opam_purl.create ~name ~version with
  | Ok p -> Sbom_types.Purl.create_t (p :> string)
  | Error msg -> ksprintf failwith "invalid PURL for %s@%s: %s" name version msg

let opam_hash_kind (h : OpamHash.t) : S.checksum_kind =
  match OpamHash.kind h with
  | `MD5 -> MD5
  | `SHA256 -> SHA256
  | `SHA512 -> SHA512

let opam_hash_checksum (h : OpamHash.t) : S.checksum =
  S.create_checksum ~kind:(opam_hash_kind h) ~value:(OpamHash.contents h) ()

(* Don't return a private URL if we can prove it *)
let opam_url_string (u : OpamUrl.t) : string option =
  match u.transport (* scheme *) with
  | "file" -> None
  | _ -> Some (OpamUrl.to_string u)

(* naive, approximate email regexp; good enough for the purpose
   of splitting "The Name <name@example.com>" into "The Name"
   and "name@example.com". *)
let name_email_re = Str.regexp {|^\(.*[^ ]\) +<\([^@ >]+@[^> ]+\)>$|}

let actor_of_string s : S.actor =
  let s = String.trim s in
  if Str.string_match name_email_re s 0 then
    let name = Str.matched_group 1 s in
    let email = Str.matched_group 2 s in
    S.Person (S.create_person ~name ~email ())
  else S.Person (S.create_person ~name:s ())

(* Convert from Spdx_licenses.t to our internal license_expr type.
   The two type hierarchies are structurally similar but not identical:
   - LicenseIDPlus folds the "+" into the id string
   - LicenseRef/AdditionRef reconstruct the canonical "LicenseRef-" prefix
   - exception id and AdditionRef are both represented as plain strings *)

let spdx_simple (sl : Spdx_licenses.simple_license) : S.license_atom =
  match sl with
  | LicenseID id -> S.Spdx_id id
  | LicenseIDPlus id -> S.Spdx_id (id ^ "+")
  | LicenseRef { document_ref = None; license_ref } ->
      S.License_ref (S.create_license_ref ~id:("LicenseRef-" ^ license_ref) ())
  | LicenseRef { document_ref = Some doc; license_ref } ->
      S.License_ref
        (S.create_license_ref
           ~id:("DocumentRef-" ^ doc ^ ":LicenseRef-" ^ license_ref)
           ())

let spdx_addition (a : Spdx_licenses.addition) : string =
  match a with
  | Exception id -> id
  | AdditionRef { document_ref = None; addition_ref } ->
      "AdditionRef-" ^ addition_ref
  | AdditionRef { document_ref = Some doc; addition_ref } ->
      "DocumentRef-" ^ doc ^ ":AdditionRef-" ^ addition_ref

let rec spdx_expr (expr : Spdx_licenses.t) : S.license_expr =
  match expr with
  | Simple sl -> S.Atom (spdx_simple sl)
  | WITH (sl, a) -> S.With (spdx_simple sl, spdx_addition a)
  | AND (a, b) -> S.And (spdx_expr a, spdx_expr b)
  | OR (a, b) -> S.Or (spdx_expr a, spdx_expr b)

let license_expr_of_string s : S.license_expr =
  match Spdx_licenses.parse s with
  | Ok expr -> spdx_expr expr
  | Error _ -> S.Atom (S.License_ref (S.create_license_ref ~id:s ()))

let license_of_strings = function
  | [] -> S.Unknown
  | [ s ] -> S.Known (license_expr_of_string s)
  | first :: rest ->
      let expr =
        List.fold_left
          (fun acc s -> S.And (acc, license_expr_of_string s))
          (license_expr_of_string first)
          rest
      in
      S.Known expr

let make_component
    (package_info : (Sbom_deps.Dep.component, OpamFile.OPAM.t) Hashtbl.t)
    (x : Sbom_deps.Dep.component) =
  let o =
    match Hashtbl.find_opt package_info x with
    | None -> assert false
    | Some x -> x
  in
  let maintainers = List.map actor_of_string (OpamFile.OPAM.maintainer o) in
  let authors = List.map actor_of_string (OpamFile.OPAM.author o) in
  let licensing =
    let declared = license_of_strings (OpamFile.OPAM.license o) in
    S.create_licensing ~declared ~concluded:Unknown ()
  in
  let tags = OpamFile.OPAM.tags o in
  let description = OpamFile.OPAM.synopsis o in
  let homepage_url =
    match OpamFile.OPAM.homepage o with
    | url :: _ -> Some url
    | [] -> None
  in
  let doc_url =
    match OpamFile.OPAM.doc o with
    | url :: _ -> Some url
    | [] -> None
  in
  let bug_reports_url =
    match OpamFile.OPAM.bug_reports o with
    | url :: _ -> Some url
    | [] -> None
  in
  let dev_repo_url =
    match OpamFile.OPAM.dev_repo o with
    | None -> None
    | Some url -> opam_url_string url
  in
  let source_distribution =
    match OpamFile.OPAM.url o with
    | None -> S.create_url_with_checksums ~checksums:[] ()
    | Some u ->
        let url = opam_url_string (OpamFile.URL.url u) in
        let checksums = List.map opam_hash_checksum (OpamFile.URL.checksum u) in
        S.create_url_with_checksums ?url ~checksums ()
  in
  S.create_component ~key:(make_purl x) ~name:x.name ~version:x.version
    ~kind:(S.Opam_package Unknown) ~authors ~maintainers ~licensing ~tags
    ?description ?homepage_url ?doc_url ?bug_reports_url ?dev_repo_url
    ~source_distribution ()

let generate_sbom ?(ignore_all_suspected_components = false)
    ?(ignored_suspected_component_paths = []) ?output_file ?overlay_file
    ?use_lockfiles ~project_roots () =
  (* Resolve overlay file: use the explicit path if given, otherwise look for
     the default file name in the current directory. *)
  let effective_overlay_file =
    match overlay_file with
    | Some _ -> overlay_file
    | None ->
        let default = Fpath.v Overlay.default_name in
        if Sys.file_exists !!default then Some default else None
  in
  (* load the overlay file early so as to fail quickly if it's malformed *)
  let overlay =
    match effective_overlay_file with
    | None -> None
    | Some path -> Some (path, Overlay.load path)
  in
  let opamfiles =
    List.concat_map Sbom_deps.Opam_resolve.find_opamfiles project_roots
  in
  if opamfiles = [] then
    ksprintf failwith "no opam file (*.opam or 'opam') found in %s"
      (project_roots
      |> List.map (fun p -> !!(Sbom_util.Path.of_root p))
      |> String.concat ", ");
  let deps, package_info, warnings =
    Sbom_deps.Opam_resolve.resolve_dependencies ?use_lockfiles ~opamfiles ()
  in
  let root_components = List.map make_purl deps.root_components in
  let components = List.map (make_component package_info) deps.components in
  let dep_edges =
    List.concat_map
      (fun (dep : Sbom_deps.Dep.t) ->
        list_scopes dep.scopes
        |> List.map (fun scope ->
            S.create_dep_edge ~src:(make_purl dep.src) ~dst:(make_purl dep.dst)
              ~scope ()))
      deps.edges
  in
  let document =
    S.create_document ~format:ocaml_sbom_format
      ~namespace:
        (Uuidm.to_string (Uuidm.v4_gen (Random.State.make_self_init ()) ()))
      ~root_components ~components ~dep_edges ()
  in
  (* We should not generate bad sboms but if do, better fail early *)
  (match Sbom_types.Validate.sbom document with
  | Ok () -> ()
  | Error msg -> ksprintf failwith "internal error: malformed SBOM: %s" msg);
  let document =
    match overlay with
    | None -> document
    | Some (overlay_path, overlay) ->
        let document = Overlay.apply document overlay ~overlay_path in
        (match Sbom_types.Validate.sbom document with
        | Ok () -> ()
        | Error msg ->
            ksprintf failwith
              "malformed SBOM after applying the overlay '%s': %s"
              !!overlay_path msg);
        document
  in
  let json_str = S.Document.to_json document |> Yojson.Safe.prettify in
  (match output_file with
  | None -> print_endline json_str
  | Some path ->
      Out_channel.with_open_text !!path (fun oc -> fprintf oc "%s\n" json_str));
  let project_tree_warnings =
    if ignore_all_suspected_components then []
    else
      Check_project.scan ~ignored_paths:ignored_suspected_component_paths
        ~roots:project_roots document
  in
  warnings @ project_tree_warnings
