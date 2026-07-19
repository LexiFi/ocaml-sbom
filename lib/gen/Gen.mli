(** Entry point for generating an SBOM *)

val generate_sbom :
  ?ignore_all_suspected_components:bool ->
  ?ignored_suspected_component_paths:Fpath.t list ->
  ?output_file:Fpath.t ->
  ?overlay_file:Fpath.t ->
  ?use_lockfiles:Sbom_deps.Opam_resolve.use_lockfiles ->
  project_roots:Fpath.t option list ->
  unit ->
  string list
(** Generate an SBOM and print it to stdout or save it to the provided output
    file.

    Fail by raising an exception.

    Return a list of warning messages to be addressed by the user. The caller
    will decide what to do with the warnings (print them out, nonzero exit
    status, etc.) *)
