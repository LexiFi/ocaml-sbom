(** Generate valid PURLs for Opam packages.

    Opam name/version constraints: src/format/opamPackage.ml in the opam source:
    https://github.com/ocaml/opam/blob/65fa20ed7d17aa13482d60962924ff61888b87de/src/format/opamPackage.ml

    Generic PURL spec:
    https://ecma-international.org/wp-content/uploads/ECMA-427_1st_edition_december_2025.pdf

    Opam-specific PURL spec:
    https://github.com/package-url/purl-spec/blob/main/types/opam-definition.json
*)

val create : name:string -> version:string -> (Purl.t, string) result
(** Create an opam package purl from name and version. Fail with an error
    message if the name or the version is not opam-compliant. *)
