(** Sanity checks to run before importing or exporting *)

val sbom : Ocaml_sbom.Document.t -> (unit, string) result
(** Check that the SBOM is well-formed. This is important when taking a JSON
    SBOM as input that a user may have tempered with.

    In particular, we check the following:
    - component PURLs must match name and version
    - no cycles in the component graph
    - no orphan components: no non-root components that are not dependents of
      any component
    - no edges connecting unknown components *)
