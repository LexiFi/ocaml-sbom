(** Execute a command synchronously

    This is meant to be reusable as a standalone library that only depends
    on the Unix library.
*)

type input =
  | Default  (** share stdin with the current process *)
  | File of string  (** read from this file instead of stdin *)
  | Data of string  (** read from this string instead of stdin *)

type output =
  | Default  (** share stdout or stderr with the current process *)
  | File of string  (** write to this file instead of stdout or stderr;
                        if the file already exists, it is truncated to
                        zero length before writing *)
  | Buffer of Buffer.t  (** write to a buffer instead of stdout or stderr *)
  | Ignore  (** redirect stdout or stderr to oblivion;
                functionally equivalent to [File "/dev/null"] on Unix *)

(** Same convenience level as [Sys.command] without running a shell

    @param input optionally read from a file or from a string instead of stdin
    @param output optionally write to a file or to a buffer instead of stdout
    @param error_output optionally write to a file or to a buffer instead of
    stderr
    @param name command name, defaults to [List.hd argv]
*)
val run :
  ?input:input ->
  ?output:output ->
  ?error_output:output ->
  ?name:string ->
  string list -> int

type capture = {
  status: int;
  output: string;
  error_output: string;
}

(** A specialized variant of {!run} that captures standard and error outputs
    as strings. *)
val run_capture :
  ?input:input ->
  ?name:string ->
  string list -> capture

val show : string list -> string
