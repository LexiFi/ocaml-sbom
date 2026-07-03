(** An opam package dependency

    This is an internal type that holds what we need for the purposes of SBOM
    generation. It's derived from a lock file or from querying package
    repositories. *)

type package_namespace = Opam

type scopes = {
  all : bool;
      (** defaults to true; disabled by [build], [with-doc], [with-test], or
          [with-dev-setup] *)
  build : bool;
  doc : bool;
  test : bool;
  dev : bool;
}
(** Known contexts where a dependency applies. Each scope represents a different
    context where a component is needed. If a component is needed for testing
    and for building the documentation but not in other contexts, it can be
    expressed with this record in a straightforward manner as
    [{runtime=false; build=false; doc=true; test=true; dev=false}].

    Some of combinations such as "runtime and not build" cannot be expressed
    using Opam's dependency flags. See below.

    https://opam.ocaml.org/doc/1.2/Manual.html#opamfield-depends says:

    - [build] dependencies are no longer needed at run-time: they won't trigger
      recompilations of your package.
    - [test] dependencies are only needed when building tests (i.e. by
      instructions in the build-test field)
    - likewise, [doc] dependencies are only required when building the package
      documentation
    - [with-dev-setup] dependencies are development tools (formatters, linters,
      etc.) not needed to build or install the package *)

type component = { kind : package_namespace; name : string; version : string }
(** A component identifier, equivalent to a PURL *)

type t = { src : component; dst : component; scopes : scopes }
(** A dependency: how component [src] depends on [dst] *)

val compare_component : component -> component -> int
val compare_t : t -> t -> int
