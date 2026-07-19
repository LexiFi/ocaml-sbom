(*
   Scan the project for files named 'LICENSE' or similar.
*)

let license_prefixes =
  [ "LICENSE"; "LICENCE"; "COPYING"; "COPYRIGHT"; "NOTICE" ]

let is_likely_license_file (file : Scan_file_tree.file) =
  match file.kind with
  | Reg _ ->
      let uppercase_name = String.uppercase_ascii file.name in
      List.exists
        (fun prefix -> String.starts_with ~prefix uppercase_name)
        license_prefixes
  | Dir
  | Other ->
      false
