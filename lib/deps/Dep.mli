(** An opam package dependency

    This is an internal type that holds what we need for the purposes
    of SBOM generation. It's derived from a lock file or from querying
    package repositories.
*)

type package_namespace = Opam

type source =
  | Lockfiles of string list
    (** relative paths to lockfiles, one per Opam package declared by the
        Dune project *)
(*
  | Dry_install of string list
    (** relative paths to opam files *)

  TODO: add support for projects without a lockfile but without installing
  anything either. Read package info by creating a temporary opam switch in
  a temp folder, then running:

    $ opam install ./*.opam --deps-only --with-test --with-doc --with-dev --dry-run --switch=./sbom.tmp --json=solution.json --yes

  The JSON file contains a 'solution' field that looks like this:

  "solution": [
    { "install": { "name": "ocaml-base-compiler", "version": "5.2.1" } },
    { "install": { "name": "base-unix", "version": "base" } },
    { "install": { "name": "base-threads", "version": "base" } },
    { "install": { "name": "base-bigarray", "version": "base" } },
    { "install": { "name": "ocaml-options-vanilla", "version": "1" } },
    ...
  ],
*)

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
