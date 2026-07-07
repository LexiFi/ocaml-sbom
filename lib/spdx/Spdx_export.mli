(** Export to SPDX JSON formats

    Specs: https://github.com/spdx/spdx-spec/tree/develop/schemas *)

val to_spdx_2_3 : Sbom_types.Ocaml_sbom.document -> Spdx_2_3_1_dev.sPDX231dev
val to_spdx_3_0 : Sbom_types.Ocaml_sbom.document -> Spdx_3_0_1.root_json
