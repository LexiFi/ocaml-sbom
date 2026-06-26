(** An opam package dependency

    This is an internal type that holds what we need for the purposes
    of SBOM generation. It's derived from a lock file or from querying
    package repositories.
*)

type package_namespace = Opam

(** Known contexts where a dependency applies.

    https://opam.ocaml.org/doc/1.2/Manual.html#opamfield-depends says:

    - [build] dependencies are no longer needed at run-time:
      they won't trigger recompilations of your package.
    - [test] dependencies are only needed when building tests
      (i.e. by instructions in the build-test field)
    - likewise, [doc] dependencies are only required when building
      the package documentation
*)
type scopes = {
  build: bool;   (** defaults to true; disabled by [with-doc] or [with-test] *)
  install: bool; (** defaults to true; disabled by [build], [with-doc],
                     or [with-test] *)
  doc: bool;     (** defaults to false; enabled by [with-doc] *)
  test: bool;    (** defaults to false; enabled by [with-test] *)
}

(** A component identifier, equivalent to a PURL *)
type component = {
  kind: package_namespace;
  name: string;
  version: string;
}

(** A dependency: how component [src] depends on [dst] *)
type t = {
  src: component;
  dst: component;
  scopes: scopes;
}

val compare_component : component -> component -> int
val compare_t : t -> t -> int
