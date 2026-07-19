(* Get information about an opam package *)

open Printf
open Sbom_util.Path.Ops

let parse_file path =
  OpamFilename.of_string !!path |> OpamFile.make |> OpamFile.OPAM.read

let get ~switch ~name ~version =
  let full_name = sprintf "%s.%s" name version in
  let out =
    Opam_command.run [ "opam"; "show"; full_name; "--switch"; switch; "--raw" ]
  in
  OpamFile.OPAM.read_from_string out
