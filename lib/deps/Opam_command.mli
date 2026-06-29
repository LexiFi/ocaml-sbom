(** Application-local wrapper around the more generic [Command] module *)

(** Run an external command and return the captured standard output.

    Fail with an error message showing the command's error output if
    the exit status is nonzero.

    @param show_output is for debugging
*)
val run : ?show_output:bool -> string list -> string
