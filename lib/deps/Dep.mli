(** An opam package dependency

    This is an internal type that holds what we need for the purposes
    of SBOM generation. It's derived from a lock file or from querying
    package repositories.
*)

type package_namespace = Opam

type source = Lockfile of string (** path to lockfile *)

(** Known contexts where a dependency applies. *)
type context = {
  install: bool;
  build: bool;
  dev: bool;
  doc: bool;
  test: bool;
}

type t = {
  kind: package_namespace;
  name: string;
  version: string;
  context: context;
  source: source;
}
