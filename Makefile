.PHONY: build
build:
	dune build
	ln -sf _build/default/app/ocaml_sbom.exe ocaml-sbom

.PHONY: setup
setup:
	pre-commit --version || (echo "Please install 'pre-commit'"; exit 1)
	# Should we use a lockfile ('--locked')?
	# It would impose an OCaml version.
	opam install --deps-only \
	  --with-test --with-doc --with-dev-setup --with-doc .

.PHONY: test
test:
	dune build tests/test.exe
	./test --stack-backtrace

.PHONY: clean
clean:
	dune clean

.PHONY: sbom
sbom: build
	opam lock .
	./ocaml-sbom gen -v -o ocaml-sbom.ocaml-sbom \
	  --ignore-suspected-component lib/heuristics \
	  --ignore-suspected-component tests/test-repo \
	  --ignore-suspected-component tests/test-repo/src/dune-vendored-dir \
	  --ignore-suspected-component tests/test-repo/submodules/submodproject \
	  --ignore-suspected-component tests/test-repo/third_party/extlib \
	  --ignore-suspected-component tests/test-repo/vendor/anotherlib \
	  --ignore-suspected-component tests/test-repo/vendor/mylib
	$(MAKE) export-sbom

.PHONY: export-sbom
export-sbom:
	./ocaml-sbom export ocaml-sbom.ocaml-sbom \
	  -o ocaml-sbom.cdx.json
	./ocaml-sbom export ocaml-sbom.ocaml-sbom --format spdx-2.3 \
	  -o ocaml-sbom.spdx2.json
	./ocaml-sbom export ocaml-sbom.ocaml-sbom --format spdx-3.0 \
	  -o ocaml-sbom.spdx3.json
