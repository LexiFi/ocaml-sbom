(*
   Apply a human-maintained overlay to a generated SBOM document.
*)

val default_name : string
(** Default file name searched for in the current directory when no overlay path
    is given explicitly. Currently ["ocaml-sbom.overlay.json"]. *)

val load : Fpath.t -> Sbom_types.Ocaml_sbom_overlay.document_overlay
(** [load path] reads and parses an overlay file. Raises on I/O or parse errors.
*)

val apply :
  Sbom_types.Ocaml_sbom.document ->
  Sbom_types.Ocaml_sbom_overlay.document_overlay ->
  Sbom_types.Ocaml_sbom.document
(** [apply doc overlay] applies [overlay] to [doc] and returns the patched
    document. Raises [Failure] if any patch operation is invalid (e.g. replacing
    a field that does not exist, or deleting a component that is not in [doc]).
*)
