let common_vendor_parent_names =
  [
    "vendor";
    "vendors";
    "vendored";
    "third_party";
    "thirdparty";
    "third-party";
    "external";
    "extern";
  ]

(* Check if the directory is a direct child of a vendor-named directory,
   matching the glob pattern '**/vendor/*'. *)
let is_likely_vendored_dir (file : Scan_file_tree.file) =
  match file.kind with
  | Dir ->
      let parent_name = Fpath.(basename (parent file.proj_path)) in
      List.mem parent_name common_vendor_parent_names
  | Reg _
  | Other ->
      false
