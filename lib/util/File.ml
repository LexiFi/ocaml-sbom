(* File manipulation utilities *)

open Path.Ops

let read path =
  let ic = open_in !!path in
  Fun.protect
    ~finally:(fun () -> close_in_noerr ic)
    (fun () ->
      let n = in_channel_length ic in
      really_input_string ic n)

let rec rm_recursive path =
  let path_str = !!path in
  match (Unix.lstat path_str).st_kind with
  | S_DIR ->
      Sys.readdir path_str
      |> Array.iter (fun name -> rm_recursive (path / name));
      Unix.rmdir path_str
  | _ -> Sys.remove path_str

let with_temp_dir ?(persist = false) ?(prefix = "") ?(suffix = "") f =
  let path = Filename.temp_dir prefix suffix in
  Fun.protect
    (fun () -> f (Fpath.v path))
    ~finally:(fun () -> if not persist then rm_recursive (Fpath.v path))

let with_temp_file ?(prefix = "") ?(suffix = ".tmp") func =
  let path, oc = Filename.open_temp_file prefix suffix in
  Fun.protect
    (fun () -> func (Fpath.v path) oc)
    ~finally:(fun () ->
      close_out_noerr oc;
      Sys.remove path)
