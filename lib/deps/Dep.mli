(** An opam package dependency

    This is an internal type that holds what we need for the purposes
    of SBOM generation. It's derived from a lock file or from querying
    package repositories.
*)

type package_namespace = Opam

type source =
  | Lockfiles of Fpath.t list
    (** relative paths to lockfiles, one per Opam package declared by the
        Dune project *)
  | Dry_install of Fpath.t list
    (** relative paths to opam files *)

(** Known contexts where a dependency applies. *)
type scope = {
  install: bool;
  build: bool;
  dev: bool;
  doc: bool;
  test: bool;
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
  scope: scope;
}
