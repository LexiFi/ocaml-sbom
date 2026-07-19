(** Check for 'dune' files containing '(vendored_dirs ...)'

    https://dune.readthedocs.io/en/stable/reference/dune/vendored_dirs.html *)

val extract_vendored_dirs_from_dune_file :
  Scan_file_tree.file -> Fpath.t list option
(** Check if the file is named [dune] and parse it to extract vendored dirs.
    Return paths that are relative to the scan root.

    The result is [Some list] iff the file is a [dune] file that was parsed
    successfully. *)
