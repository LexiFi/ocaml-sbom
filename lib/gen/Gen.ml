open Printf
module S = Sbom_types.Ocaml_sbom

let ( / ) = Fpath.( / )
let ( !! ) = Fpath.to_string

let common_format_version = "1.0"
let ocaml_sbom_format = "ocaml-sbom/" ^ common_format_version
let _overlay_format = "ocaml-sbom-overlay/" ^ common_format_version

let context_to_scope (ctx : Sbom_deps.Dep.context) : S.dep_scope =
  let { Sbom_deps.Dep.install = _; build; dev; doc; test } = ctx in
  match build, dev, doc, test with
  | false, false, false, false -> S.Runtime  (* all_contexts: no restriction *)
  | true,  false, false, false -> S.Build
  | false, true,  false, false -> S.Dev
  | false, false, true,  false -> S.Optional
  | false, false, false, true  -> S.Test
  | _ -> S.Runtime

let make_purl name version =
  match Sbom_deps.Opam_purl.create ~name ~version with
  | Ok p -> (p :> string)
  | Error msg -> failwith (sprintf "invalid PURL for %s@%s: %s" name version msg)

let unknown_licensing =
  S.create_licensing ~declared:S.Unknown ~concluded:S.Unknown ()

let make_component name version =
  S.create_component
    ~key:(S.create_purl (make_purl name version))
    ~name
    ~version
    ~kind:(S.Opam_package None)
    ~authors:[]
    ~licensing:unknown_licensing
    ()

type processed = {
  root_purl : S.purl;
  root_name : string;
  root_version : string;
  deps : Sbom_deps.Dep.t list;
}

let process_lockfile lockfile_path =
  let info =
    match Sbom_deps.Lockfile.parse lockfile_path with
    | Ok x -> x
    | Error msg -> failwith msg
  in
  let root_name = info.name in
  let root_version = info.version in
  let root_purl = S.create_purl (make_purl root_name root_version) in
  { root_purl; root_name; root_version; deps = info.deps }

(* Find opam package files in the project root directory.
   These are files named '*.opam' or simply 'opam', as per:
   https://opam.ocaml.org/doc/Packaging.html *)
let find_opam_files project_root =
  Sys.readdir !!project_root
  |> Array.to_list
  |> List.filter_map (fun name ->
      if Filename.check_suffix name ".opam" || name = "opam"
      then Some (project_root / name)
      else None)

let generate_sbom ?output_file ?overlay_file ~project_root () =
  (* TODO: add overlay support *)
  ignore overlay_file;
  match find_opam_files project_root with
  | [] ->
      failwith (sprintf "no opam files found in %s" !!project_root);
  | opam_files ->
      List.iter (fun opam_path ->
        let locked = Fpath.add_ext ".locked" opam_path in
        if not (Sys.file_exists !!locked) then
          failwith (sprintf "missing lockfile for %s (expected %s)"
                      !!opam_path !!locked)
      ) opam_files;
      let processed =
        List.map (fun p ->
          process_lockfile !!(Fpath.add_ext ".locked" p)) opam_files
  in
  let root_purl_set = Hashtbl.create 4 in
  List.iter (fun pr -> Hashtbl.replace root_purl_set (pr.root_purl :> string) ()) processed;
  let component_tbl : (string, S.component) Hashtbl.t = Hashtbl.create 64 in
  List.iter (fun pr ->
    List.iter (fun (dep : Sbom_deps.Dep.t) ->
      let purl_str = make_purl dep.name dep.version in
      if not (Hashtbl.mem root_purl_set purl_str) &&
         not (Hashtbl.mem component_tbl purl_str) then
        Hashtbl.add component_tbl purl_str (make_component dep.name dep.version)
    ) pr.deps
  ) processed;
  let root_components =
    List.map (fun pr -> make_component pr.root_name pr.root_version) processed
  in
  let dep_components =
    Hashtbl.fold (fun _ c acc -> c :: acc) component_tbl []
  in
  let dep_edges =
    List.concat_map (fun pr ->
      List.map (fun (dep : Sbom_deps.Dep.t) ->
        let scope = context_to_scope dep.context in
        S.create_dep_edge
          ~src:pr.root_purl
          ~dst:(S.create_purl (make_purl dep.name dep.version))
          ~scope
          ()
      ) pr.deps
    ) processed
  in
  let document = S.create_document
    ~format:ocaml_sbom_format
    ~namespace:(Uuidm.to_string (Uuidm.v4_gen (Random.State.make_self_init ()) ()))
    ~root_components:(List.map (fun pr -> pr.root_purl) processed)
    ~components:(root_components @ dep_components)
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
