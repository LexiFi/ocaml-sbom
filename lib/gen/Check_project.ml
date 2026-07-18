(*
   Run heuristics to report suspicious findings in the project
*)

let ( // ) = Fpath.( // )

module H = Sbom_heuristics

type evidence =
  | Git_submodule of Fpath.t * H.Git_submodules.git_submodule
    (* fs path, Git-submodule info *)
  | License_file_name of Fpath.t (* fs path to the license file *)
  | Vendored_dir_name of Fpath.t (* fs path to the folder *)
  | Dune_vendored_dir of Fpath.t (* fs path to 'dune' file *)

type suspected_component = {
  path : Fpath.t; (* key - fs path to the component's folder *)
  evidence : evidence list;
}

let get_candidate_names (x : suspected_component) : string list =
  (* TODO: derive a name from the basename of the path or from the
     name of the Git repo of the submodule, if available *)
  []

let matches_known_component sbom sus =
  (* TODO: if a candidate name for the suspected component is already
     declared as a component in the sbom, return true. *)
  false

let warn (sus : suspected_component) : string =
  (* TODO: turn a suspected component into a warning with supporting evidence *)
  "[TODO]"

(*
   We try to detect components that were not already detected as Opam packages.
*)
let scan ~roots sbom =
  (* Group the evidence by inferred component name - which is just the
     folder name. A better project name may be available from the Git
     repo name of the submodule if available. *)
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
  |> List.iter (fun root ->
      H.Git_submodules.scan ~root
      |> List.iter (fun (sub : H.Git_submodules.git_submodule) ->
          let path = root // sub.path in
          (* TODO: add submodule as evidence *)
          ());
      Scan_file_tree.scan ~exclude_dir_names:[ "_build"; "_opam"; ".git" ] ~root
        (fun (file : H.Scan_file_tree.file) ->
          if H.License_files.is_likely_license_file file then
            add (root // Fpath.parent file.path) (License_file_name file.path);
          if H.Vendored_dirs.is_likely_vendored_dir file then
            add (root // file.path) (Vendored_dir_name file.path);
          match H.Dune_vendored_dirs.extract_vendored_dirs_from_dune_file with
          | None -> ()
          | Some paths ->
              paths
              |> List.iter (fun path ->
                  let dune_file = root // file.path in
                  add (root // path) (Dune_vendored_dir dune_file))));
  Hashtbl.fold (fun k v acc -> (k, List.rev v) :: acc) components []
  |> List.filter (fun sus -> not (matches_known_component sbom sus))
  |> List.sort (fun (a, _) (b, _) -> Fpath.compare a b)
  |> List.map warn
