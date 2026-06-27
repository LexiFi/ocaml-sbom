open Printf
module S = Sbom_types.Ocaml_sbom

let ( !! ) = Fpath.to_string

let common_format_version = "1.0"
let ocaml_sbom_format = "ocaml-sbom/" ^ common_format_version
let _overlay_format = "ocaml-sbom-overlay/" ^ common_format_version

let make_scope (scopes : Sbom_deps.Dep.scopes) : S.dep_scope =
  if scopes.install then Runtime
  else if scopes.build then Build
  else if scopes.doc || scopes.test then Optional
  else if scopes.test then Test
  else
    (* empty scope - this shouldn't happen; fall back to the safest option *)
    Runtime

let make_purl ({ kind; name; version } : Sbom_deps.Dep.component) =
  assert (kind = Opam);
  match Sbom_types.Opam_purl.create ~name ~version with
  | Ok p -> Sbom_types.Purl.create_t (p :> string)
  | Error msg ->
      ksprintf failwith "invalid PURL for %s@%s: %s" name version msg

let opam_hash_kind (h : OpamHash.t) : S.checksum_kind =
  match OpamHash.kind h with
  | `MD5 -> MD5
  | `SHA256 -> SHA256
  | `SHA512 -> SHA512

let opam_hash_checksum (h : OpamHash.t) : S.checksum =
  S.create_checksum ~kind:(opam_hash_kind h) ~value:(OpamHash.contents h) ()

let opam_url_string (u : OpamUrl.t) : string =
  OpamUrl.to_string u

(* naive, approximate email regexp; good enough for the purpose
   of splitting "The Name <name@example.com>" into "The Name"
   and "name@example.com". *)
let name_email_re =
  Str.regexp {|^\(.*[^ ]\) +<\([^@ >]+@[^> ]+\)>$|}

let actor_of_string s : S.actor =
  let s = String.trim s in
  if Str.string_match name_email_re s 0 then
    let name = Str.matched_group 1 s in
    let email = Str.matched_group 2 s in
    S.Person (S.create_person ~name ~email ())
  else
    S.Person (S.create_person ~name:s ())

let license_expr_of_string s : S.license_expr =
  (* opam license strings are free-form; treat each as an SPDX id *)
  (* TODO: check against list of valid SPDX IDs and use the correct constructor
     (Spdx_id or License_ref). Use the following two files:
     - licenses.json
     - exceptions.json
     They should be downloaded from
     https://github.com/spdx/license-list-data/tree/main/json
     and converted to OCaml using a program or script that is easy to
     rerun in the future. (alt: download them dynamically for each
     invocation of ocaml-sbom)

     Also, we need to parse this:
     "LGPL-2.1-or-later WITH OCaml-LGPL-linking-exception"
     into 'With (Atom ..., "OCaml-LGPL-linking-exception")'
  *)
  S.Atom (S.Spdx_id s)

let license_of_strings = function
  | [] -> S.Unknown
  | [s] -> S.Known (license_expr_of_string s)
  | first :: rest ->
      let expr =
        List.fold_left
          (fun acc s -> S.And (acc, license_expr_of_string s))
          (license_expr_of_string first)
          rest
      in
      S.Known expr

let make_component (x : Sbom_deps.Dep.component) =
  let o = Sbom_deps.Opam_package.get ~name:x.name ~version:x.version in
  let maintainers = List.map actor_of_string (OpamFile.OPAM.maintainer o) in
  let authors = List.map actor_of_string (OpamFile.OPAM.author o) in
  let licensing =
    let declared = license_of_strings (OpamFile.OPAM.license o) in
    S.create_licensing ~declared ~concluded:Unknown ()
  in
  let tags = OpamFile.OPAM.tags o in
  let description = OpamFile.OPAM.synopsis o in
  let homepage_url = match OpamFile.OPAM.homepage o with
    | url :: _ -> Some url | [] -> None in
  let doc_url = match OpamFile.OPAM.doc o with
    | url :: _ -> Some url | [] -> None in
  let bug_reports_url = match OpamFile.OPAM.bug_reports o with
    | url :: _ -> Some url | [] -> None in
  let dev_repo_url =
    Option.map (fun u -> opam_url_string u) (OpamFile.OPAM.dev_repo o) in
  let source_distribution =
    match OpamFile.OPAM.url o with
    | None ->
        S.create_url_with_checksums ~url:"" ~checksums:[] ()
    | Some u ->
        let url = opam_url_string (OpamFile.URL.url u) in
        let checksums = List.map opam_hash_checksum (OpamFile.URL.checksum u) in
        S.create_url_with_checksums ~url ~checksums ()
  in
  S.create_component
    ~key:(make_purl x)
    ~name:x.name
    ~version:x.version
    ~kind:(S.Opam_package Unknown)
    ~authors
    ~maintainers
    ~licensing
    ~tags
    ?description
    ?homepage_url
    ?doc_url
    ?bug_reports_url
    ?dev_repo_url
    ~source_distribution
    ()

let generate_sbom ?output_file ?overlay_file ?use_lockfiles ~project_root () =
  (* TODO: add overlay support *)
  ignore overlay_file;
  let opamfiles =
    Sbom_deps.Opam_resolve.find_opamfiles project_root in
  let deps, warnings =
    Sbom_deps.Opam_resolve.resolve_dependencies ?use_lockfiles ~opamfiles () in
  let root_components = List.map make_purl deps.root_components in
  let components = List.map make_component deps.components in
  let dep_edges =
    List.map (fun (dep : Sbom_deps.Dep.t) ->
      let scope = make_scope dep.scopes in
      S.create_dep_edge
        ~src:(make_purl dep.src)
        ~dst:(make_purl dep.dst)
        ~scope
        ()
    ) deps.edges
  in
  let document =
    S.create_document
      ~format:ocaml_sbom_format
      ~namespace:(Uuidm.to_string
                    (Uuidm.v4_gen
                       (Random.State.make_self_init ()) ()))
      ~root_components
      ~components
      ~dep_edges
      ()
  in
  let json_str = S.Document.to_json document |> Yojson.Safe.prettify in
  (match output_file with
   | None -> print_endline json_str
   | Some path ->
       Out_channel.with_open_text !!path (fun oc ->
         fprintf oc "%s\n" json_str
       )
  );
  warnings
