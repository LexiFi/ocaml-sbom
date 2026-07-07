🚧 This project is under construction. 🚧

# SBOM generator for OCaml projects

ocaml-sbom is an [SBOM](https://en.wikipedia.org/wiki/Software_supply_chain)
generator for OCaml projects or subprojects that use the Opam package
manager.

## Features

- Runs without installing the dependencies of the target project
- Produces a dependency graph
- Provides licensing information
- Works with or without lockfiles (`.opam` or `.opam.locked` files)
- Supports manual corrections via an overlay file
- Exports to CycloneDX and to SPDX (2.3 and 3.0)

## Installation

[Opam](https://opam.ocaml.org/) is required to build `ocaml-sbom` from
source. Build it and install it with (TODO)

```
$ opam install ocaml-sbom
```

## Usage

The target project must ship with one or several Opam files. These are
typically placed at the project root and have the `.opam` extension.
Lockfiles may be present. They have the `.opam.locked` extension and
are picked up automatically by `ocaml-sbom`. The tool provides options
to require or to ignore lockfiles, see `ocaml-sbom --help`.

First, generate the SBOM in ocaml-sbom's internal format. This may
take a few minutes:

```
$ ocaml-sbom -o myproject.ocaml-sbom --verbose
```

An overlay file named `ocaml-sbom.overlay.json` is used if present.
Its format is specified by
https://github.com/LexiFi/ocaml-sbom/blob/main/lib/types/ocaml_sbom_overlay.atd.
See `ocaml-sbom overlay --help` for examples (TODO).

Then export to your preferred SBOM format:

```
$ ocaml-sbom export myproject.ocaml-sbom -o myproject.cdx --format cyclonedx-1.6
```
or
```
$ ocaml-sbom export myproject.ocaml-sbom -o myproject.spdx --format spdx-3.0
```
