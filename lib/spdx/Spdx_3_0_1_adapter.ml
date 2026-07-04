(* Adapter for the graph_element variant type in spdx_3_0_1.atd.

   ATD's <json adapter.ocaml="..."> mechanism calls normalize/restore to
   translate between the on-wire JSON form and ATD's internal list form.

   On-wire JSON:   {"type": "SpdxDocument", "spdxId": "...", ...}
   ATD list form:  ["SpdxDocument", {"spdxId": "...", ...}]

   The "type" field acts as the variant tag: normalize extracts it and restore
   reinserts it, so the element record types stay clean (no type_ field).
*)

let normalize = function
  | `Assoc fields -> (
      match List.assoc_opt "type" fields with
      | Some (`String tag) ->
          let rest = List.filter (fun (k, _) -> k <> "type") fields in
          `List [ `String tag; `Assoc rest ]
      | _ ->
          failwith
            "Spdx_3_0_1_adapter.normalize: missing or non-string 'type' field")
  | _ -> failwith "Spdx_3_0_1_adapter.normalize: expected a JSON object"

let restore = function
  | `List [ `String tag; `Assoc fields ] ->
      `Assoc (("type", `String tag) :: fields)
  | _ -> failwith "Spdx_3_0_1_adapter.restore: unexpected ATD internal form"
