(*
   Scan all the project files
*)

type kind = Reg of string Lazy.t | Dir | Other
type file = { name : string; path : Fpath.t; kind : kind Lazy.t }

let scan ?(exclude_dir_names = []) ~root func =
  (* TODO *)
  ()
