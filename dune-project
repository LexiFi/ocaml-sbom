(lang dune 3.18)
(name ocaml-sbom)

(using menhir 3.0)

(generate_opam_files)

(license "ISC")
(source (github LexiFi/ocaml-sbom))
(homepage "https://github.com/LexiFi/ocaml-sbom")
(maintainers "Martin Jambon <martin@mjambon.com>")
(authors
  "Martin Jambon"
)

(package
  (name ocaml-sbom)
  (synopsis "SBOM generator for OCaml projects")
  (description "\
ocaml-sbom is an SBOM generator for OCaml projects with export to CycloneDX.
")
  (depends
    (ocaml (>= 4.14.0))
    (atdml :build)
    cmdliner
    fpath
    (ocamlformat (and (>= 0.28.0) (< 0.29.0) :with-dev-setup))
    opam-format
    spdx_licenses
    uuidm
  )
  (maintenance_intent "(latest)")
)
