(** Get information about an opam package *)

(** Call [opam show] to get the opamfile for a specific package name
    and version, then parse it.

    Fail with an exception if anything goes wrong.
*)
val get : name:string -> version:string -> OpamFile.OPAM.t

(** Parse an opamfile or an opam lockfile *)
val parse_file : Fpath.t -> OpamFile.OPAM.t
