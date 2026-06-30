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
