(*
   Scan all the project files
*)

open Sbom_util.Path.Ops

type kind = Reg of string Lazy.t | Dir | Other

type file = {
  name : string;
  proj_path : Fpath.t; (* relative to the project root *)
  kind : kind;
}

let scan ?(exclude_dir_names = []) ~root func =
  let rec loop fs_dir (proj_dir : Fpath.t option) =
    let entries =
      try Array.to_list (Sys.readdir !!fs_dir) with
      | Sys_error _ -> []
    in
    List.sort String.compare entries
    |> List.iter (fun name ->
        let proj_child = proj_dir /? name in
        let fs_child = fs_dir / name in
        match Unix.lstat !!fs_child with
        | exception Unix.Unix_error _ -> ()
        | stat -> (
            match stat.st_kind with
            | S_REG ->
                let contents = lazy (Sbom_util.File.read fs_child) in
                func { name; proj_path = proj_child; kind = Reg contents }
            | S_DIR ->
                if not (List.mem name exclude_dir_names) then (
                  func { name; proj_path = proj_child; kind = Dir };
                  loop fs_child (Some proj_child))
            | _ -> func { name; proj_path = proj_child; kind = Other }))
  in
  loop root None
