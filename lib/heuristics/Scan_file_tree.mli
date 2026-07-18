(** Scan all the project files *)

type kind = Reg of string Lazy.t | Dir | Other

type file = {
  name : string;
  proj_path : Fpath.t;
      (** Path relative to the project root (not a valid file system path in
          general) *)
  kind : kind;
}

val scan :
  ?exclude_dir_names:string list -> root:Fpath.t -> (file -> unit) -> unit
(** Scan all the regular files and directories starting from the root folder
    (excluded). Symlinks are ignored. *)
