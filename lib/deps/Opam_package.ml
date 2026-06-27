(* Get information about an opam package *)

open Printf

let ( !! ) = Fpath.to_string

let parse_file path =
  OpamFilename.of_string !!path
  |> OpamFile.make
  |> OpamFile.OPAM.read

let get ~name ~version =
  let full_name = sprintf "%s.%s" name version in
  let out = Opam_command.run ["opam"; "show"; full_name; "--raw"] in
  OpamFile.OPAM.read_from_string out
