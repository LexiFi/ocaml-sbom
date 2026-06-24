(**
   Installation-free method for resolving Opam package dependencies
   when lockfiles are not available
*)

(** Take a list of relative paths to opam files and resolve the dependencies
    by invoking [opam] on a temporary empty switch. *)
val resolve_dependencies : Fpath.t list -> Dep.t list
