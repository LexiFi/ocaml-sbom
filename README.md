🚧 This project is under construction. 🚧

# SBOM generator for OCaml projects

ocaml-sbom is an [SBOM](https://en.wikipedia.org/wiki/Software_supply_chain)
generator for OCaml projects or subprojects.

## Planned features

- multiple levels of effort: from a light scan that doesn't download
  anything to a full build with dependency scanning and binary analysis;
- targets primarily projects built around Opam and Dune;
- any unrecognized asset or low-confidence assessment is
  reported;
- supports corrections via a separate, persistent file that is
  maintained manually;
- export to [CycloneDX](https://github.com/CycloneDX/specification) JSON.
