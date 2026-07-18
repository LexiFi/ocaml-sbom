(** Read [.gitmodules] file to discover Git submodules, then repeat on each
    submodule. *)

type git_submodule = {
  root : Fpath.t option;  (** project root *)
  proj_path : Fpath.t;
      (** local path relative to the project root, may not match the name found
          in the URL *)
  url : string;  (** "https://example.com/proj.git" *)
  repo_name : string;  (** extracted from the URL: "proj" *)
}

val scan : root:Fpath.t option -> git_submodule list
(** Scan recursively for Git submodules starting from a [root] folder. *)
