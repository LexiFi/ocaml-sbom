(* Resolve Opam package dependencies using one method or the other *)

open Printf

type dependencies = {
  root_components: Dep.component list;
  components: Dep.component list;
  edges: Dep.t list;
  source: Dep.source;
}

let ( !! ) = Fpath.to_string
let ( / ) = Fpath.( / )

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

let get_dependency_resolution_source project_root : Dep.source =
  match find_opam_files project_root with
  | [] ->
      ksprintf failwith "no opam files found in %s" !!project_root;
  | opam_files ->
      let all =
        List.map (fun opam_file ->
          let lockfile = Fpath.add_ext ".locked" opam_file in
          if Sys.file_exists !!lockfile then
            ((opam_file, lockfile), true)
          else
            ((opam_file, lockfile), false)
        ) opam_files
      in
      let found_lockfiles =
        List.filter_map
          (function ((_, lockfile), true) -> Some lockfile | _ -> None)
          all
      in
      let missing_lockfiles =
        List.filter_map
          (function ((_, lockfile), false) -> Some !!lockfile | _ -> None)
          all
      in
      let opam_files =
        List.map
          (fun ((opam_file, _), _) -> opam_file)
          all
      in
      let all_n = List.length all in
      let found_n = List.length found_lockfiles in
      if found_n = all_n then
        Lockfiles found_lockfiles
      else if found_n = 0 then
        (* all the lockfiles are missing, which is fine *)
        Dry_install opam_files
      else
        ksprintf failwith "some lockfiles are missing: %s"
          (String.concat ", " missing_lockfiles)

let resolve_from_lockfiles lockfile_paths : Dep.t list =
  lockfile_paths
  |> List.concat_map (fun path ->
    let lockfile =
      match Lockfile.parse path with
      | Ok x -> x
      | Error msg -> failwith msg
    in
    lockfile.deps
  )

let merge_scopes (a : Dep.scope) (b : Dep.scope) : Dep.scope =
  {
    install = a.install || b.install;
    build = a.build || b.build;
    dev = a.dev || b.dev;
    doc = a.doc || b.doc;
    test = a.test || b.test;
  }

(* Handle duplicates, derive redundant lists of nodes from the edges *)
let expand source (edges : Dep.t list) : dependencies =
  let merged_edges = Hashtbl.create 100 in
  edges
  |> List.iter (fun (dep : Dep.t) ->
    let k = (dep.src, dep.dst) in
    match Hashtbl.find_opt merged_edges k with
    | Some (v : Dep.t) ->
        Hashtbl.replace merged_edges k {
          Dep.src = dep.src;
          dst = dep.dst;
          scope = merge_scopes dep.scope v.scope
        }
    | None ->
        Hashtbl.add merged_edges k dep
  );
  let edges = Hashtbl.fold (fun _k v acc -> v :: acc) merged_edges [] in
  let all_components = Hashtbl.create 100 in
  let dst_components = Hashtbl.create 100 in
  edges
  |> List.iter (fun (dep : Dep.t) ->
    Hashtbl.replace dst_components dep.dst ();
    Hashtbl.replace all_components dep.src ();
    Hashtbl.replace all_components dep.dst ()
  );
  let components =
    Hashtbl.fold (fun x _ acc -> x :: acc) all_components [] in
  let root_components =
    List.filter (fun x -> not (Hashtbl.mem dst_components x)) components in
  {
    root_components;
    components;
    edges;
    source;
  }

let resolve (source : Dep.source) : dependencies =
  let edges =
    match source with
    | Lockfiles lockfile_paths -> resolve_from_lockfiles lockfile_paths
    | Dry_install _ -> failwith "TODO: Dry_install"
  in
  expand source edges
