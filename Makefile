.PHONY: build
build:
	dune build
	ln -sf _build/default/app/ocaml_sbom.exe ocaml-sbom
