(** ATD adapter (copied and adapted from jsonschema2atd) *)

module Adapter = struct
  module One_of = struct
    let normalize _x = failwith "not supported: read from CycloneDX"

    let restore = function
      (* Unbox variant value *)
      | `List [ `String _; value ] -> value
      | x -> x
  end
end
