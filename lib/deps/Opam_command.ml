(* Application-local wrapper around the more generic 'Command' module *)

open Printf

let quote str =
  str
  |> String.split_on_char '\n'
  |> List.map (fun line -> "| " ^ line)
  |> String.concat "\n"

(* check exit status and quote stderr if command failed *)
let check cmd (capture : Sbom_util.Command.capture) =
  match capture.status with
  | 0 -> ()
  | n ->
      let msg =
        sprintf "command failed with exit code %d: %s"
          n (Sbom_util.Command.show cmd)
      in
      eprintf "Error:\n%s\n%s\n%!"
        (quote capture.error_output) msg;
      failwith msg

let run cmd =
  let capture = Sbom_util.Command.run_capture cmd in
  check cmd capture;
  capture.output
