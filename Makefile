.PHONY: build
build:
	dune build
	ln -sf _build/default/app/ocaml_sbom.exe ocaml-sbom

.PHONY: setup
setup:
	opam install --deps-only --with-test --with-doc ./*.opam

.PHONY: clean
clean:
	dune clean
