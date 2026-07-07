.PHONY: build
build:
	dune build
	ln -sf _build/default/app/ocaml_sbom.exe ocaml-sbom

.PHONY: setup
setup:
	pre-commit --version || (echo "Please install 'pre-commit'"; exit 1)
	opam install --deps-only --with-test --with-doc --with-dev ./*.opam

.PHONY: test
test:
	dune build tests/test.exe
	./test

.PHONY: clean
clean:
	dune clean

.PHONY: sbom
sbom: build
	opam lock .
	./ocaml-sbom -v -o ocaml-sbom.ocaml-sbom
	$(MAKE) export-sbom

.PHONY: export-sbom
export-sbom:
	./ocaml-sbom export ocaml-sbom.ocaml-sbom \
	  -o ocaml-sbom.cdx.json
	./ocaml-sbom export ocaml-sbom.ocaml-sbom --format spdx-2.3 \
	  -o ocaml-sbom.spdx2.json
	./ocaml-sbom export ocaml-sbom.ocaml-sbom --format spdx-3.0 \
	  -o ocaml-sbom.spdx3.json
