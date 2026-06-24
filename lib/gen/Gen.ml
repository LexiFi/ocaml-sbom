open Printf
module S = Sbom_types.Ocaml_sbom

let ( !! ) = Fpath.to_string

let common_format_version = "1.0"
let ocaml_sbom_format = "ocaml-sbom/" ^ common_format_version
let _overlay_format = "ocaml-sbom-overlay/" ^ common_format_version

let make_scope (scope : Sbom_deps.Dep.scope) : S.dep_scope =
  let { Sbom_deps.Dep.install = _; build; dev; doc; test } = scope in
  match build, dev, doc, test with
  | false, false, false, false -> S.Runtime  (* all_contexts: no restriction *)
  | true,  false, false, false -> S.Build
  | false, true,  false, false -> S.Dev
  | false, false, true,  false -> S.Optional
  | false, false, false, true  -> S.Test
  | _ -> S.Runtime

let unknown_licensing =
  S.create_licensing ~declared:S.Unknown ~concluded:S.Unknown ()

let make_purl ({ kind; name; version } : Sbom_deps.Dep.component) =
  assert (kind = Opam);
  match Sbom_types.Opam_purl.create ~name ~version with
  | Ok p -> Sbom_types.Purl.create_t (p :> string)
  | Error msg ->
      ksprintf failwith "invalid PURL for %s@%s: %s" name version msg

let make_component (x : Sbom_deps.Dep.component) =
  S.create_component
    ~key:(make_purl x)
    ~name:x.name
    ~version:x.version
    ~kind:(S.Opam_package None)
    ~authors:[]
    ~licensing:unknown_licensing
    ()

let generate_sbom ?output_file ?overlay_file ~project_root () =
  (* TODO: add overlay support *)
  ignore overlay_file;
  let dep_src =
    Sbom_deps.Resolve.get_dependency_resolution_source project_root in
  let deps = Sbom_deps.Resolve.resolve dep_src in
  let root_components = List.map make_purl deps.root_components in
  let components = List.map make_component deps.components in
  let dep_edges =
    List.map (fun (dep : Sbom_deps.Dep.t) ->
      let scope = make_scope dep.scope in
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
  let warnings = [] in
  warnings
