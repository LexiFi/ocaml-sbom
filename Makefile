.PHONY: build
build:
	dune build
	ln -sf _build/default/app/ocaml_sbom.exe ocaml-sbom

.PHONY: setup
setup:
	pre-commit --version || (echo "Please install 'pre-commit'"; exit 1)
	# Should we use a lockfile ('--locked')?
	# It would impose an OCaml version.
	opam install --deps-only --with-test --with-doc --with-dev-setup .

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
	cat ocaml-sbom.opam.locked
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
	# suggested next: run 'make validate'

# Validate exported SBOMs using external tools
# TODO: run this in CI
#
.PHONY: validate
validate:
	### CycloneDX validation
	docker run -v "$$(pwd)"/ocaml-sbom.cdx.json:/ocaml-sbom.cdx.json \
	  cyclonedx/cyclonedx-cli validate \
	    --input-format json \
	    --input-version v1_6 \
	    --input-file /ocaml-sbom.cdx.json
	### SPDX 2.3 validation
	# (install with: 'pip install spdx-tools')
	# (no validator available for SPDX 3.0 (?))
	pyspdxtools -i ocaml-sbom.spdx2.json

# Update the opam files generated from 'dune-project'
.PHONY: opam-files
opam-files:
	opam exec -- dune build *.opam

# Attempt an automated release for the checked out branch.
#
# Release process:
#
# 1. Make sure the opam files are up to date: run 'make opam-files'.
# 2. Update CHANGES.md which will be used by dune-release to extract the
#    version and the release notes.
# 3. Run the release steps below.
#
.PHONY: opam-release
opam-release:
	dune-release tag
	dune-release distrib
	dune-release publish
	dune-release opam pkg
	dune-release opam submit
