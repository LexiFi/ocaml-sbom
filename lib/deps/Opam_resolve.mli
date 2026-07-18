(** Obtain a dependency DAG from opam files or lockfiles without installing
    packages via [opam pin] and [opam tree] commands. *)

type dependencies = {
  root_components : Dep.component list;
  components : Dep.component list;
  edges : Dep.t list;
  source : Fpath.t list;  (** list of opam files or lockfiles *)
}
(** Dependency info obtained from multiple manifests or lockfiles

    [root_components] and [components] are deduplicated but some components may
    exist in multiple versions (which would indicate a problem because opam
    doesn't allow two versions of the same package to coexist).

    [root_components] are included in [components]. They are all the components
    that don't appear as [dst] components.

    [edges] are also deduplicated based on the pairs ([src], [dst]) i.e. there's
    only one scope object per pair ([src], [dst]). *)

type use_lockfiles =
  | Use_lockfiles_if_available
      (** we'll emit a warning if only some lockfiles are available *)
  | Require_lockfiles
  | Ignore_lockfiles

val find_opamfiles : Fpath.t option -> Fpath.t list
(** Take the project root dir and look for opam files *)

val resolve_dependencies :
  ?use_lockfiles:use_lockfiles ->
  opamfiles:Fpath.t list ->
  unit ->
  dependencies * (Dep.component, OpamFile.OPAM.t) Hashtbl.t * string list
(** Resolve the dependencies by invoking [opam] on a temporary empty switch.
    Returns the dependency graph and the details about each node (component).

    This command takes opam files (possibly coming from multiple project roots).
    Their base name must be [opam] or must end in [.opam]. Matching lockfiles
    have the same name with the [.locked] prefix.

    @param use_lockfiles
      whether to consult lockfiles. Default: [Use_lockfiles_if_available] *)
