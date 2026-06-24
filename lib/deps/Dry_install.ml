(*
   Resolve opam dependencies without a lockfile and without installing them.

     $ opam switch create ./empty.tmp --empty

   Read package info by creating a temporary opam switch in
   a temp folder, then run:

     $ opam install ./*.opam --deps-only --with-test --with-doc --with-dev --dry-run --switch=./empty.tmp --json=solution.json --yes

   The JSON file contains a 'solution' field that looks like this:

   "solution": [
     { "install": { "name": "ocaml-base-compiler", "version": "5.2.1" } },
     { "install": { "name": "base-unix", "version": "base" } },
     { "install": { "name": "base-threads", "version": "base" } },
     { "install": { "name": "base-bigarray", "version": "base" } },
     { "install": { "name": "ocaml-options-vanilla", "version": "1" } },
     ...
   ],

   In the case of multiple opam files, run one pass on each opam file
   to determine the list of packages that it requires and run a global
   pass on all the opam files at the same time to determine
   mutually-compatible versions.

   Any extra dependency that may show up only in the global resolution
   pass is considered to be a dependency of all the opam files
   (root components). This is more approximate than using lockfiles.
*)

let resolve_dependencies (_opam_files : Fpath.t list) : Dep.t list =
  failwith "Dry_install: not implemented"
