(** Run heuristics to report suspicious findings in the project *)

val scan : roots:Fpath.t list -> Sbom_types.Ocaml_sbom.t -> string list
(** Try to detect vendored components that are not already in the SBOM built
    from opam package info. Return a list of warnings. *)
