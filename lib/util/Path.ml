(* Fpath extension *)

module Ops = struct
  let ( !! ) = Fpath.to_string
  let ( // ) = Fpath.( // )
  let ( / ) = Fpath.( / )

  (* Treat a missing root differently from "." to avoid ending up with
     paths with a spurious leading "./" *)
  let ( /? ) a b =
    match a with
    | None -> Fpath.v b
    | Some a -> a / b

  let ( //? ) a b =
    match a with
    | None -> b
    | Some a -> a // b
end

let dot = Fpath.v "."

let of_root = function
  | None -> dot
  | Some path -> path
