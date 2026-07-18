(** Check for 'dune' files containing '(vendored_dirs ...)'

    https://dune.readthedocs.io/en/stable/reference/dune/vendored_dirs.html *)

open Sexplib0.Sexp

let find_vendored_dirs sexps =
  List.concat_map
    (function
      | List (Atom "vendored_dirs" :: rest) ->
          List.filter_map
            (function
              | Atom name -> Some name
              | List _ -> None)
            rest
      | _ -> [])
    sexps

let extract_vendored_dirs_from_dune_file (file : Scan_file_tree.file) =
  if file.name <> "dune" then None
  else
    match file.kind with
    | Dir
    | Other ->
        None
    | Reg content -> (
        let src = Lazy.force content in
        match Parsexp.Many.parse_string src with
        | Error _ -> None
        | Ok sexps ->
            let dir_names = find_vendored_dirs sexps in
            if dir_names = [] then None
            else
              let dir_parent = Fpath.parent file.path in
              Some (List.map (fun name -> Fpath.(dir_parent / name)) dir_names))
