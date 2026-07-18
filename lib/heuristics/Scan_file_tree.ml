(*
   Scan all the project files
*)

open Sbom_util.Path.Ops

type kind = Reg of string Lazy.t | Dir | Other
type file = { name : string; path : Fpath.t; kind : kind }

let scan ?(exclude_dir_names = []) ~root func =
  let rec loop abs_dir (rel_dir : Fpath.t option) =
    let entries =
      try Array.to_list (Sys.readdir !!abs_dir) with
      | Sys_error _ -> []
    in
    List.sort String.compare entries
    |> List.iter (fun name ->
        let child_rel = rel_dir /? name in
        let child_abs = abs_dir / name in
        match Unix.lstat !!child_abs with
        | exception Unix.Unix_error _ -> ()
        | stat -> (
            match stat.Unix.st_kind with
            | Unix.S_REG ->
                let abs_path = !!child_abs in
                let content =
                  lazy
                    (let ic = open_in abs_path in
                     let n = in_channel_length ic in
                     let s = Bytes.create n in
                     really_input ic s 0 n;
                     close_in ic;
                     Bytes.to_string s)
                in
                func { name; path = child_rel; kind = Reg content }
            | Unix.S_DIR ->
                if not (List.mem name exclude_dir_names) then begin
                  let dir_rel = Fpath.to_dir_path child_rel in
                  let dir_abs = Fpath.to_dir_path child_abs in
                  func { name; path = dir_rel; kind = Dir };
                  loop dir_abs (Some dir_rel)
                end
            | _ -> func { name; path = child_rel; kind = Other }))
  in
  loop root None
