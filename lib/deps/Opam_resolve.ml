(*
   Obtain a dependency tree from opam files or lockfiles without
   installing packages via 'opam pin' and 'opam tree' commands.

   An opam lockfile has the same format as an ordinary opam file, only with
   stricter version constraints.

   This approach uses the following steps:

   1. Create a temporary workspace.
   2. Copy the opam lockfiles into the temporary workspace and rename them
      into opam files. If no lockfile is found, use the opam file instead.
   3. Create an empty opam local switch.
   4. Pin the opam files with 'opam pin'.
   5. For each root package, request a tree with 'opam tree'.
   6. Read the JSON trees and convert them to our internal format.
*)

type dependencies = {
  root_components: Dep.component list;
  components: Dep.component list;
  edges: Dep.t list;
  source: Fpath.t list;
}

type use_lockfiles =
  | Use_lockfiles_if_available
  | Require_lockfiles
  | Ignore_lockfiles

let ( / ) = Fpath.( / )
let ( // ) = Fpath.( // )
let ( !! ) = Fpath.to_string

(* Find opam package files in the project root directory.
   These are files named '*.opam' or simply 'opam', as per:
   https://opam.ocaml.org/doc/Packaging.html *)
let find_opamfiles project_root =
  Sys.readdir !!project_root
  |> Array.to_list
  |> List.filter_map (fun name ->
      if Filename.check_suffix name ".opam" || name = "opam"
      then Some (project_root / name)
      else None)

let check_lockfiles opamfiles =
  opamfiles
  |> List.map (fun opamfile ->
    if not (Fpath.is_dir_path opamfile) && Sys.file_exists !!opamfile then
      let lockfile = Fpath.v (!!opamfile ^ ".locked") in
      if Sys.file_exists !!lockfile then
        (opamfile, Some lockfile)
      else
        (opamfile, None)
    else
      failwith ("missing opam file: " ^ !!opamfile)
  )

(* Return a list of (src, dst_name) where src is the file path to an
   opam-like file (opam file or lockfile) to copy into dst_name (the
   name of the an opam file as recognized by opam). *)
let get_resolution_sources use_lockfiles all_files =
  let warnings = [] in
  match use_lockfiles with
  | Use_lockfiles_if_available ->
      let with_lockfile, without_lockfile =
        List.partition (function (_, Some _) -> true | _ -> false) all_files
      in
      let warnings =
        match with_lockfile, without_lockfile with
        | [], _
        | _, [] -> warnings
        | _ ->
            ("some opam files have a lockfile and some don't. \
              The following opam files lack a lockfile: " ^
             (without_lockfile
              |> List.map (fun (path, _) -> !!path)
              |> String.concat ", ")) :: warnings
      in
      let res =
        all_files
        |> List.map (function
          | (opamfile, None) ->
              (opamfile, Fpath.basename opamfile)
          | (opamfile, Some lockfile) ->
              (lockfile, Fpath.basename opamfile)
        )
      in
      res, warnings
  | Require_lockfiles ->
      let res =
        all_files
        |> List.map (function
          | (opamfile, None) ->
              failwith ("missing lockfile for opam file: " ^ !!opamfile)
          | (opamfile, Some lockfile) ->
              lockfile, Fpath.basename opamfile
        )
      in
      res, warnings
  | Ignore_lockfiles ->
      let res =
        all_files
        |> List.map (fun (opamfile, _opt_lockfile) ->
          opamfile, Fpath.basename opamfile
        )
      in
      res, warnings

let read_name_from_file path =
  match (Opam_package.parse_file path).name with
  | None ->
      failwith ("cannot determine the name of root opam package: " ^ !!path)
  | Some name -> OpamPackage.Name.to_string name

let get_name_of_opamfile path =
  match Fpath.basename path with
  | "opam"
  | "opam.locked" ->
      read_name_from_file path
  | fname when Filename.check_suffix fname ".opam" ->
      Filename.chop_suffix fname ".opam"
  | fname when Filename.check_suffix fname ".opam.locked" ->
      Filename.chop_suffix fname ".opam.locked"
  | _ ->
      (* unsupported opam file name *)
      assert false

let component_of_package (p : Opam_tree.package) : Dep.component =
  {
    kind = Opam;
    name = p.name;
    version = p.version;
  }

(*
   Hack: extract scope from the 'satisfies' JSON field of the 'opam tree'
   export such as "(= 0.8.5 & with-doc)".
*)
let contains ~word =
  (* match bool or ident or int:
     see https://opam.ocaml.org/doc/1.2/Manual.html#General-file-format
     for the tokenization rules in *opam files*.
     Here, we're not in an opam file. The syntax isn't the same.
     For example, version strings are not quoted here but they're
     double-quoted in opam files.
  *)
  let re = Str.regexp {|[a-zA-Z_][a-zA-Z0-9:_+-]*\|-?[0-9]+|} in
  fun str ->
    Str.full_split re str
    |> List.exists (function Str.Delim s when s = word -> true
                           | _ -> false)

let contains_build = contains ~word:"build"
let contains_with_doc = contains ~word:"with-doc"
let contains_with_test = contains ~word:"with-test"

let scopes_of_constraint constraints_string : Dep.scopes =
  (* Assume that if multiple filters are found, they're ORed and not negated.

     "(with-doc | with-test)" is possible and makes sense according
     to our interpretation.

     TODO: ask opam authors to expose a clean 'scopes' field.
  *)
  let build_only = contains_build constraints_string in
  let doc_only = contains_with_doc constraints_string in
  let test_only = contains_with_test constraints_string in
  {
    build = not (doc_only || test_only);
    install = not (build_only || doc_only || test_only);
    doc = doc_only;
    test = test_only;
  }

(* = scopes_of_constraint "" *)
let default_scopes : Dep.scopes = {
  build = true;
  install = true;
  doc = false;
  test = false;
}

let edge_of_opam_dep (src : Dep.component) (dst_pkg : Opam_tree.package)
  : Dep.t =
  let dst = component_of_package dst_pkg in
  let scopes =
    match dst_pkg.satisfies with
    | Some str -> scopes_of_constraint str
    | None -> default_scopes
  in
  { src; dst; scopes }

let edges_of_dep_tree (x : Opam_tree.t) : Dep.t list =
  let rec walk (opt_src : Dep.component option) dependencies =
    let edges =
      match opt_src with
      | None -> []
      | Some src ->
          dependencies
          |> List.map (edge_of_opam_dep src)
    in
    let deeper_edges =
      dependencies
      |> List.concat_map (fun (pkg : Opam_tree.package) ->
        walk (Some (component_of_package pkg)) pkg.dependencies
      )
    in
    edges @ deeper_edges
  in
  walk None x.tree

let make_abs_path path =
  Fpath.v (Sys.getcwd ()) // path

let run argv =
  let _ : string = Opam_command.run argv in
  ()

let resolve
    ~use_lockfiles
    ~opamfiles : string list * Dep.t list * Fpath.t list * string list =
  let all_files = check_lockfiles opamfiles in
  let resolution_sources, warnings =
    get_resolution_sources use_lockfiles all_files in
  let root_names, deps, sources =
    Sbom_util.File.with_temp_dir (* debug: use ~persist:true *)
    @@ fun temp_dir ->
    let empty_switch =
      let path = temp_dir / "empty-opam-switch" in
      if Fpath.is_rel path then
        Fpath.v "." // path
      else
        path
    in
    run ["opam"; "switch"; "create"; !!empty_switch; "--empty"] |> ignore;
    Fun.protect
      ~finally:(fun () ->
        run ["opam"; "switch"; "remove"; !!empty_switch; "--yes"]
      )
    @@ fun () ->
    resolution_sources
    |> List.iter (fun (src, dst_name) ->
      let dst = temp_dir / dst_name in
      Unix.symlink ~to_dir:false !!(make_abs_path src) !!dst
    );
    run ["opam"; "pin"; "add"; !!temp_dir;
         "--switch"; !!empty_switch; "--no-action"; "--yes"];

    let root_names =
       resolution_sources
       |> List.map (fun (src, _dst_name) -> get_name_of_opamfile src)
    in
    let output_file = temp_dir / "tree.json" in
    run (["opam"; "tree";
          "--json"; !!output_file;
          "--switch"; !!empty_switch;
          "--with-test"; "--with-dev-setup"; "--with-doc"] @ root_names);
    let dep_tree =
      Yojson.Safe.from_file !!output_file
      |> Opam_tree.T.of_yojson
    in
    let deps = edges_of_dep_tree dep_tree in
    let sources = List.map fst resolution_sources in
    root_names, deps, sources
  in
  root_names, deps, sources, warnings

let merge_scopes (a : Dep.scopes) (b : Dep.scopes) : Dep.scopes =
  {
    install = a.install || b.install;
    build = a.build || b.build;
    doc = a.doc || b.doc;
    test = a.test || b.test;
  }

(* Handle duplicates, derive lists of nodes from the edges *)
let deduplicate ~root_names source (edges : Dep.t list) : dependencies =
  let merged_edges = Hashtbl.create 100 in
  edges
  |> List.iter (fun (dep : Dep.t) ->
    let k = (dep.src, dep.dst) in
    match Hashtbl.find_opt merged_edges k with
    | Some (v : Dep.t) ->
        Hashtbl.replace merged_edges k {
          Dep.src = dep.src;
          dst = dep.dst;
          scopes = merge_scopes dep.scopes v.scopes
        }
    | None ->
        Hashtbl.add merged_edges k dep
  );
  let edges =
    Hashtbl.fold (fun _k v acc -> v :: acc) merged_edges []
    |> List.sort Dep.compare_t
  in
  let all_components = Hashtbl.create 100 in
  edges
  |> List.iter (fun (dep : Dep.t) ->
    Hashtbl.replace all_components dep.src ();
    Hashtbl.replace all_components dep.dst ()
  );
  let components =
    Hashtbl.fold (fun x _ acc -> x :: acc) all_components []
    |> List.sort Dep.compare_component
  in
  let root_components =
    List.filter
      (fun (x : Dep.component) ->
         List.exists (fun name -> name = x.name) root_names)
      components in
  {
    root_components;
    components;
    edges;
    source;
  }

let resolve_dependencies
    ?(use_lockfiles = Use_lockfiles_if_available)
    ~opamfiles ()
  : dependencies * string list =
  let root_names, edges, source, warnings =
    resolve ~use_lockfiles ~opamfiles in
  deduplicate ~root_names source edges, warnings
