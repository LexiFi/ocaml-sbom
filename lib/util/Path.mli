(** Fpath extension *)

module Ops : sig
  val ( !! ) : Fpath.t -> string
  (** Prefix operator equivalent to [Fpath.to_string] *)

  val ( // ) : Fpath.t -> Fpath.t -> Fpath.t
  (** Concatenate two paths; same as [Fpath.(//)]. *)

  val ( / ) : Fpath.t -> string -> Fpath.t
  (** Add a segment to a path; same as [Fpath.(/)]. *)

  val ( //? ) : Fpath.t option -> Fpath.t -> Fpath.t
  (** Concatenate two paths or just use the right-handside path. Allows using
      the current directory without introducing a spurious leading [./]. *)

  val ( /? ) : Fpath.t option -> string -> Fpath.t
  (** Add a segment to a path or just use the new segment as the path. Allows
      using the current directory without introducing a spurious leading [./].
  *)
end

val of_root : Fpath.t option -> Fpath.t
(** Turn an implicit current folder into "." *)
