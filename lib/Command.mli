(** Execute a command synchronously

    This is meant to be reusable as a standalone library that only depends
    on Unix library.
*)

type input =
  | Default
  | File of string  (** file to read from instead of stdin *)
  | Data of string  (** data to read from instead of stdin *)

type output =
  | Default
  | File of string  (** file to write to instead of stdout or stderr *)
  | Buffer of Buffer.t  (** buffer to write to instead of stdout or stderr *)
  | Ignore

(* TODO: implement this using Unix.open_process_args_* and temporary files
   (use with_temp_file that we also expose publicly) *)
(** Same convenience level as [Sys.command] without running a shell

    @param name command name, defaults to [List.hd argv]
*)
val run :
  ?input:input ->
  ?output:output ->
  ?error_output:output ->
  ?name:string ->
  string list -> int

(** Work with a temporary output file *)
val with_temp_file :
  ?prefix:string ->
  ?suffix:string ->
  (string -> out_channel -> 'a) -> 'a
