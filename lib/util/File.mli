(** File manipulation utilities *)

(** Remove a folder and all its contents, or any kind of file *)
val rm_recursive : Fpath.t -> unit

(** Create a temporary folder and remove it when done. *)
val with_temp_dir :
  ?prefix:string ->
  ?suffix:string ->
  (Fpath.t -> 'a) -> 'a

(** Create a temporary file and remove it when done. *)
val with_temp_file :
  ?prefix:string ->
  ?suffix:string ->
  (Fpath.t -> out_channel -> 'a) -> 'a
