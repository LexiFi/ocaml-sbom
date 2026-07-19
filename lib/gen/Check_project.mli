(** Run heuristics to report suspicious findings in the project *)

val scan :
  ?ignored_paths:Fpath.t list ->
  roots:Fpath.t option list ->
  Sbom_types.Ocaml_sbom.document ->
  string list
(** Try to detect vendored components that are not already in the SBOM built
    from opam package info. Return a list of warnings.

    @param ignored_paths
      is a list of filesystem paths for folder that should not produce a warning
      saying they are suspected unlisted components. *)
