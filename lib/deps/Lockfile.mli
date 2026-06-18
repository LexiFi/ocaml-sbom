(** Extract dependencies from an opam lockfile *)

val get_deps : string -> (Dep.t list, string) result
