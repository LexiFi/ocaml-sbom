(*
   Run heuristics to report suspicious findings in the project
*)

open Printf
open Sbom_util.Path.Ops
module H = Sbom_heuristics

type evidence =
  | Git_submodule of H.Git_submodules.git_submodule (* Git-submodule info *)
  | License_file_name of Fpath.t (* fs path to the license file *)
  | Vendored_dir_name of Fpath.t (* fs path to the folder *)
  | Dune_vendored_dir of Fpath.t (* fs path to 'dune' file *)

type suspected_component = {
  path : Fpath.t; (* key - fs path to the component's folder *)
  evidence : evidence list;
}

let get_candidate_names (x : suspected_component) : string list =
  let from_path = Fpath.basename x.path in
  let from_git =
    List.filter_map
      (function
        | Git_submodule sub -> Some sub.repo_name
        | _ -> None)
      x.evidence
  in
  List.sort_uniq String.compare (from_path :: from_git)

let is_known_component (sbom : Sbom_types.Ocaml_sbom.document) =
  let sbom_names = Hashtbl.create 100 in
  sbom.components
  |> List.iter (fun (c : Sbom_types.Ocaml_sbom.component) ->
      Hashtbl.add sbom_names c.name ());
  fun name -> Hashtbl.mem sbom_names name

let matches_known_component is_known_component (sus : suspected_component) =
  let candidate_names = get_candidate_names sus in
  List.exists is_known_component candidate_names

let pp_evidence = function
  | Git_submodule sub ->
      sprintf "git submodule at '%s' (from repo '%s')" !!(sub.path)
        sub.repo_name
  | License_file_name p -> sprintf "license file '%s'" !!p
  | Vendored_dir_name p -> sprintf "vendor directory '%s'" !!p
  | Dune_vendored_dir p -> sprintf "listed in dune file '%s'" !!p

let warn (sus : suspected_component) : string =
  let path = !!(sus.path) in
  let evidence_strs = List.map pp_evidence sus.evidence in
  sprintf "Possible unlisted component at '%s': %s" path
    (String.concat "; " evidence_strs)

(*
   We try to detect components that were not already detected as Opam packages.
*)
let scan ~roots sbom =
  (* Group the evidence by inferred component path. *)
  let components = Hashtbl.create 10 in
  let add component_path evidence =
    let component_path = Fpath.rem_empty_seg component_path in
    let evidence_list =
      match Hashtbl.find_opt components component_path with
      | Some x -> x
      | None -> []
    in
    if not (List.mem evidence evidence_list) then
      Hashtbl.replace components component_path (evidence :: evidence_list)
  in
  roots
  |> List.iter (fun (root : Fpath.t option) ->
      H.Git_submodules.scan ~root
      |> List.iter (fun (sub : H.Git_submodules.git_submodule) ->
          add sub.path (Git_submodule sub));
      H.Scan_file_tree.scan
        ~exclude_dir_names:[ "_build"; "_opam"; ".git" ]
        ~root:(Option.value ~default:(Fpath.v ".") root)
        (fun (file : H.Scan_file_tree.file) ->
          if H.License_files.is_likely_license_file file then
            add (root //? Fpath.parent file.path) (License_file_name file.path);
          if H.Vendored_dirs.is_likely_vendored_dir file then
            add (root //? file.path) (Vendored_dir_name file.path);
          match
            H.Dune_vendored_dirs.extract_vendored_dirs_from_dune_file file
          with
          | None -> ()
          | Some paths ->
              paths
              |> List.iter (fun path ->
                  let dune_file = root //? file.path in
                  add (root //? path) (Dune_vendored_dir dune_file))));
  let is_known_component = is_known_component sbom in
  Hashtbl.fold
    (fun k v acc -> { path = k; evidence = List.rev v } :: acc)
    components []
  |> List.filter (fun sus ->
      not (matches_known_component is_known_component sus))
  |> List.sort (fun a b -> Fpath.compare a.path b.path)
  |> List.map warn
