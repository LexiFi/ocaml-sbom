(* Extract dependencies from an opam lockfile.

   A lockfile (e.g. foo.opam.locked) is preferred over querying the opam
   repository because it records the exact versions that were resolved for
   the project, including transitive dependencies.

   Parsing and interpreting the AST is strict to prevent important info
   from slipping through.
*)

open Printf
module F = OpamParserTypes.FullPos

let ( !! ) = Fpath.to_string

(* local exception *)
exception Malformed_lockfile of { pos: F.pos; msg: string }

type t = {
  name : string;
  version : string;
  deps : Dep.t list;
}

let error pos msg =
  raise (Malformed_lockfile { pos; msg })

let without_pos (x : 'a F.with_pos) : 'a = x.pelem

let extract_version (x : F.value) : string =
  match x.pelem with
  | Prefix_relop ({ pelem = `Eq; _ }, { pelem = String version; _ }) -> version
  | _ -> error x.pos "unexpected package constraint"

let no_scope : Dep.scope = {
  install = false;
  build = false;
  dev = false;
  doc = false;
  test = false;
}

let all_scopes : Dep.scope = {
  install = true;
  build = true;
  dev = true;
  doc = true;
  test = true;
}

let extract_scope (x : F.value) : Dep.scope =
  match x.pelem with
  | Ident "build" -> { no_scope with build = true }
  | Ident "dev" -> { no_scope with dev = true }
  | Ident "with-doc" -> { no_scope with doc = true }
  | Ident "with-test" -> { no_scope with test = true }
  | Ident ident ->
      error x.pos (sprintf "unknown predicate %S" ident)
  | _ ->
      error x.pos "unexpected value"

let extract_version_and_scope pos (filters : F.value list) =
  match filters with
  | [ { pelem = Logop ({ pelem = `And; _ }, version, scope); _ } ] ->
      extract_version version, extract_scope scope
  | [ version ] ->
      extract_version version, all_scopes
  | _ ->
      error pos "unexpected package filters"

(* Parse a single item from the depends list, e.g.:
     "cmdliner"   {= "2.1.1"}
     "astring"    {= "0.8.5" & with-doc}
     "base-unix"  {= "base"}
     "ocaml"      {= "5.4.1"}

   If the dependency is not of the form {= VERSION} or {= VERSION & SCOPE},
   we emit an error.
*)
let interpret_dependency
    (src_component : Dep.component)
    ({ pos; pelem = x} : F.value) : Dep.t =
  match x with
  | F.Option (name, filters) ->
      let name =
        match name.pelem with
        | F.String name -> name
        | _ ->
            error name.pos "unexpected data found instead of dependency name"
      in
      let version, scope =
        extract_version_and_scope filters.pos filters.pelem
      in
      let dst : Dep.component = { kind = Opam; name; version } in
      { src = src_component; dst; scope }
  | F.String name ->
      error pos (sprintf "missing version for dependency '%s'" name)
  | _ ->
      error pos "unexpected data in dependency list"

let interpret_deps ~lockfile_path ~src (x : F.opamfile) : Dep.t list =
  match x.file_contents |> List.find_map (fun item ->
    match without_pos item with
    | F.Variable ({ pelem = "depends"; _ }, v) ->
        (match without_pos v with
         | F.List { pelem = values; _ } ->
             Some (List.map (interpret_dependency src) values)
         | _ ->
             None
        )
    | F.Variable _ | F.Section _ -> None)
  with Some deps -> deps
     | None -> failwith ("missing 'depends' section: " ^ !!lockfile_path)

(* TODO: check if opam lock files can contain multiple entries for the
   same dependency under 'depends'; *)
let check_duplicates deps =
  let visited = Hashtbl.create 10 in
  List.iter (fun (x : Dep.t) ->
    if Hashtbl.mem visited x.dst then
      failwith
        (sprintf "unsupported: duplicate entry for dependency %s %s"
           x.dst.name x.dst.version)
    else
      Hashtbl.add visited x.dst ()
  ) deps

let extract_string_field opamfile field_name =
  List.find_map (fun item ->
    match without_pos item with
    | F.Variable ({ pelem = name; _ }, v) when name = field_name ->
        (match v.pelem with
         | F.String s -> Some s
         | _ -> None)
    | _ -> None
  ) opamfile.F.file_contents

let get_deps ~lockfile_path ~src opamfile =
  let deps = interpret_deps ~lockfile_path ~src opamfile in
  check_duplicates deps;
  deps

let interpret ~(lockfile_path : Fpath.t) (opamfile : F.opamfile) =
  let name =
    match extract_string_field opamfile "name" with
    | Some n -> n
    | None -> failwith (sprintf "missing 'name' field in %s" !!lockfile_path)
  in
  let version =
    match extract_string_field opamfile "version" with
    | Some v -> v
    | None -> "dev"
  in
  let src : Dep.component = { kind = Opam; name; version } in
  let deps = get_deps ~lockfile_path ~src opamfile in
  { name; version; deps }

let parse lockfile_path =
  try Ok (interpret ~lockfile_path (OpamParser.FullPos.file !!lockfile_path))
  with
  | Malformed_lockfile {pos; msg} ->
      Error (
        sprintf "cannot interpret opam lockfile \
                 %S, lines %d-%d, columns %d-%d: %s"
          pos.filename
          (fst pos.start) (fst pos.stop)
          (snd pos.start) (snd pos.stop)
          msg
      )
  | exn ->
      Error (sprintf "cannot parse opam lockfile %S: %s"
               !!lockfile_path (Printexc.to_string exn))
