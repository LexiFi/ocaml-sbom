(** Extract dependencies from an opam lockfile *)

type t = {
  name : string;
  version : string; (** defaults to ["dev"] *)
  deps : Dep.t list;
}

val parse : Fpath.t -> (t, string) result
