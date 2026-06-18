(* Extract dependencies from an opam lockfile.

   A lockfile (e.g. foo.opam.locked) is preferred over querying the opam
   repository because it records the exact versions that were resolved for
   the project, including transitive dependencies.

   Parsing and interpreting the AST is strict to prevent important info
   from slipping through.
*)

open Printf
module F = OpamParserTypes.FullPos

exception Malformed_lockfile of { pos: F.pos; msg: string }

let error pos msg =
  raise (Malformed_lockfile { pos; msg })

let without_pos (x : 'a F.with_pos) : 'a = x.pelem

let extract_version (x : F.value) : string =
  match x.pelem with
  | Prefix_relop ({ pelem = `Eq; _ }, { pelem = String version; _ }) -> version
  | _ -> error x.pos "unexpected package constraint"

let no_context : Dep.context = {
  install = false;
  build = false;
  dev = false;
  doc = false;
  test = false;
}

let all_contexts : Dep.context = {
  install = true;
  build = true;
  dev = true;
  doc = true;
  test = true;
}

let extract_context (x : F.value) : Dep.context =
  match x.pelem with
  | Ident "build" -> { no_context with build = true }
  | Ident "dev" -> { no_context with dev = true }
  | Ident "with-doc" -> { no_context with doc = true }
  | Ident "with-test" -> { no_context with test = true }
  | Ident ident ->
      error x.pos (sprintf "unknown predicate %S" ident)
  | _ ->
      error x.pos "unexpected value"

let extract_version_and_context pos (filters : F.value list) =
  match filters with
  | [ { pelem = Logop ({ pelem = `And; _ }, version, context); _ } ] ->
      extract_version version, extract_context context
  | [ version ] ->
      extract_version version, all_contexts
  | _ ->
      error pos "unexpected package filters"

(* Parse a single item from the depends list, e.g.:
     "cmdliner"   {= "2.1.1"}
     "astring"    {= "0.8.5" & with-doc}
     "base-unix"  {= "base"}
     "ocaml"      {= "5.4.1"}

   If the dependency is not of the form {= VERSION} or {= VERSION & CONTEXT},
   we emit an error.
*)
let simplify_dependency
    (source : Dep.source)
    ({ pos; pelem = x} : F.value) : Dep.t =
  match x with
  | F.Option (name, filters) ->
      let name =
        match name.pelem with
        | F.String name -> name
        | _ ->
            error name.pos "unexpected data found instead of dependency name"
      in
      let version, context =
        extract_version_and_context filters.pos filters.pelem
      in
      { kind = Opam; name; version; context; source }
  | F.String name ->
      error pos (sprintf "missing version for dependency '%s'" name)
  | _ ->
      error pos "unexpected data in dependency list"

let simplify_opamfile (lockfile_path : string) (x : F.opamfile) : Dep.t list =
  let source = Dep.Lockfile lockfile_path in
  match x.file_contents |> List.find_map (fun item ->
    match without_pos item with
    | F.Variable ({ pelem = "depends"; _ }, v) ->
        (match without_pos v with
         | F.List { pelem = values; _ } ->
             Some (List.map (simplify_dependency source) values)
         | _ ->
             None
        )
    | F.Variable _ | F.Section _ -> None)
  with Some deps -> deps
     | None -> failwith "missing 'depends' section"

(* TODO: check if opam lock files can contain multiple entries for the
   same dependency under 'depends'; *)
let check_duplicates deps =
  let visited = Hashtbl.create 10 in
  List.iter (fun (x : Dep.t) ->
    if Hashtbl.mem visited x.name then
      failwith
        (sprintf "unsupported: duplicate entry for dependency %s" x.name)
    else
      Hashtbl.add visited x.name ()
  ) deps

let get_deps lockfile_path =
  try
    let opamfile = OpamParser.FullPos.file lockfile_path in
    let deps = simplify_opamfile lockfile_path opamfile in
    check_duplicates deps;
    Ok deps
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
               lockfile_path (Printexc.to_string exn))
