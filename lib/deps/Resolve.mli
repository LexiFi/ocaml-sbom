(** Resolve Opam package dependencies using one method or the other *)

(** Dependency info obtained from multiple manifests or lockfiles

    [root_components] and [components] are deduplicated but some
    components may exist in multiple versions (which would indicate
    a problem because opam doesn't allow two versions of the
    same package to coexist).

    [root_components] are included in [components]. They are all the components
    that don't appear as [dst] components.

    [edges] are also deduplicated based on the pairs ([src], [dst]) i.e.
    there's only one scope object per pair ([src], [dst]).
*)
type dependencies = {
  root_components: Dep.component list;
  components: Dep.component list;
  edges: Dep.t list;
  source: Dep.source;
}

(** Take the project root dir and look for opam files and lockfiles
    to determine the best way to resolve the dependencies *)
val get_dependency_resolution_source : Fpath.t -> Dep.source

val resolve : Dep.source -> dependencies
