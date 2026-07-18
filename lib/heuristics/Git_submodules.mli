(** Read [.gitmodules] file to discover Git submodules, then repeat on each
    submodule. *)

type git_submodule = {
  path : Fpath.t;  (** local path, may not match the name found in the URL *)
  url : string;  (** "https://example.com/proj.git" *)
  repo_name : string;  (** extracted from the URL: "proj" *)
}

val scan : root:Fpath.t -> git_submodule list
(** Scan recursively for Git submodules starting from a [root] folder. *)
