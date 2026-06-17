(* Auto-generated from "CycloneDX_1_6.atd" by atdml. *)
[@@@ocaml.warning "-27-32-33-35-39"]

(* Inlined runtime — no external dependency needed. *)
module Atdml_runtime = struct
  (* Returns true iff the list has strictly more than [n] elements,
     without traversing past element n+1. *)
  let rec list_length_gt n = function
    | _ :: rest -> if n = 0 then true else list_length_gt (n - 1) rest
    | [] -> false

  module Yojson = struct
    let bad_type expected_type x =
      Printf.ksprintf failwith "expected %s, got: %s"
        expected_type (Yojson.Safe.to_string x)

    let bad_sum type_name x =
      Printf.ksprintf failwith "invalid variant for type '%s': %s"
        type_name (Yojson.Safe.to_string x)

    let missing_field type_name field_name =
      Printf.ksprintf failwith "missing field '%s' in object of type '%s'"
        field_name type_name

    let bool_of_yojson = function
      | `Bool b -> b
      | x -> bad_type "bool" x

    let yojson_of_bool b = `Bool b

    let int_of_yojson = function
      | `Int n -> n
      | x -> bad_type "int" x

    let yojson_of_int n = `Int n

    let float_of_yojson = function
      | `Float f -> f
      | `Int n -> Float.of_int n
      | x -> bad_type "float" x

    let yojson_of_float f = `Float f

    let string_of_yojson = function
      | `String s -> s
      | x -> bad_type "string" x

    let yojson_of_string s = `String s

    let unit_of_yojson = function
      | `Null -> ()
      | x -> bad_type "null" x

    let yojson_of_unit () = `Null

    let list_of_yojson f = function
      | `List xs -> List.map f xs
      | x -> bad_type "array" x

    let yojson_of_list f xs = `List (List.map f xs)

    let option_of_yojson f = function
      | `String "None" -> None
      | `List [`String "Some"; x] -> Some (f x)
      | x -> bad_type "option" x

    let yojson_of_option f = function
      | None -> `String "None"
      | Some x -> `List [`String "Some"; f x]

    let nullable_of_yojson f = function
      | `Null -> None
      | x -> Some (f x)

    let yojson_of_nullable f = function
      | None -> `Null
      | Some x -> f x

    let assoc_of_yojson f = function
      | `Assoc pairs -> List.map (fun (k, v) -> (k, f v)) pairs
      | x -> bad_type "object" x

    let yojson_of_assoc f xs =
      `Assoc (List.map (fun (k, v) -> (k, f v)) xs)
  end
end

(** Specifies the optional encoding the text is represented in. *)
type attachmentEncoding =
  | Base64

let attachmentEncoding_of_yojson (x : Yojson.Safe.t) : attachmentEncoding =
  match x with
  | `String "base64" -> Base64
  | _ -> Atdml_runtime.Yojson.bad_sum "attachmentEncoding" x

let yojson_of_attachmentEncoding (x : attachmentEncoding) : Yojson.Safe.t =
  match x with
  | Base64 -> `String "base64"

let attachmentEncoding_of_json s =
  attachmentEncoding_of_yojson (Yojson.Safe.from_string s)

let json_of_attachmentEncoding x =
  Yojson.Safe.to_string (yojson_of_attachmentEncoding x)

module AttachmentEncoding = struct
  type nonrec t = attachmentEncoding
  let of_yojson = attachmentEncoding_of_yojson
  let to_yojson = yojson_of_attachmentEncoding
  let of_json = attachmentEncoding_of_json
  let to_json = json_of_attachmentEncoding
end

(** Specifies the metadata and content for an attachment. *)
type attachment = {
  contentType: string;
  (**
     Specifies the format and nature of the data being attached, helping
     systems correctly interpret and process the content. Common content
     type examples include `application/json` for JSON data and
     `text/plain` for plain text documents. \[RFC 2045 section
     5.1\](https://www.ietf.org/rfc/rfc2045.html#section-5.1) outlines the
     structure and use of content types. For a comprehensive list of
     registered content types, refer to the \[IANA media types
     registry\](https://www.iana.org/assignments/media-types/media-types.xhtml).
  *)
  encoding: attachmentEncoding option;  (** Specifies the optional encoding the text is represented in. *)
  content: string;
  (**
     The attachment data. Proactive controls such as input validation and
     sanitization should be employed to prevent misuse of attachment text.
  *)
}

let create_attachment ?(contentType = "text/plain") ?encoding ~content () : attachment =
  { contentType; encoding; content }

let attachment_of_yojson (x : Yojson.Safe.t) : attachment =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let contentType =
      match assoc "contentType" with
      | None -> "text/plain"
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
    in
    let encoding =
      match assoc "encoding" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (attachmentEncoding_of_yojson v)
    in
    let content =
      match assoc "content" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "attachment" "content"
    in
    { contentType; encoding; content }
  | _ -> Atdml_runtime.Yojson.bad_type "attachment" x

let yojson_of_attachment (x : attachment) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("contentType", Atdml_runtime.Yojson.yojson_of_string x.contentType)];
    (match x.encoding with None -> [] | Some v -> [("encoding", yojson_of_attachmentEncoding v)]);
    [("content", Atdml_runtime.Yojson.yojson_of_string x.content)];
  ])

let attachment_of_json s =
  attachment_of_yojson (Yojson.Safe.from_string s)

let json_of_attachment x =
  Yojson.Safe.to_string (yojson_of_attachment x)

module Attachment = struct
  type nonrec t = attachment
  let create = create_attachment
  let of_yojson = attachment_of_yojson
  let to_yojson = yojson_of_attachment
  let of_json = attachment_of_json
  let to_json = json_of_attachment
end

(**
   Descriptor for another BOM document. See
   https://cyclonedx.org/capabilities/bomlink/
*)
type bomLinkDocumentType = string

let create_bomLinkDocumentType (x : string) : bomLinkDocumentType = x


let bomLinkDocumentType_of_yojson (x : Yojson.Safe.t) : bomLinkDocumentType =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_bomLinkDocumentType (x : bomLinkDocumentType) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let bomLinkDocumentType_of_json s =
  bomLinkDocumentType_of_yojson (Yojson.Safe.from_string s)

let json_of_bomLinkDocumentType x =
  Yojson.Safe.to_string (yojson_of_bomLinkDocumentType x)

module BomLinkDocumentType = struct
  type nonrec t = bomLinkDocumentType
  let create = create_bomLinkDocumentType
  let of_yojson = bomLinkDocumentType_of_yojson
  let to_yojson = yojson_of_bomLinkDocumentType
  let of_json = bomLinkDocumentType_of_json
  let to_json = json_of_bomLinkDocumentType
end

(**
   Descriptor for an element in a BOM document. See
   https://cyclonedx.org/capabilities/bomlink/
*)
type bomLinkElementType = string

let create_bomLinkElementType (x : string) : bomLinkElementType = x


let bomLinkElementType_of_yojson (x : Yojson.Safe.t) : bomLinkElementType =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_bomLinkElementType (x : bomLinkElementType) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let bomLinkElementType_of_json s =
  bomLinkElementType_of_yojson (Yojson.Safe.from_string s)

let json_of_bomLinkElementType x =
  Yojson.Safe.to_string (yojson_of_bomLinkElementType x)

module BomLinkElementType = struct
  type nonrec t = bomLinkElementType
  let create = create_bomLinkElementType
  let of_yojson = bomLinkElementType_of_yojson
  let to_yojson = yojson_of_bomLinkElementType
  let of_json = bomLinkElementType_of_json
  let to_json = json_of_bomLinkElementType
end

type bomLink =
  | BomLinkDocumentType of bomLinkDocumentType
  | BomLinkElementType of bomLinkElementType

let bomLink_of_yojson (x : Yojson.Safe.t) : bomLink =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "BomLinkDocumentType"; v] -> BomLinkDocumentType (bomLinkDocumentType_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "bomLink" x

let yojson_of_bomLink (x : bomLink) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | BomLinkDocumentType v -> `List [`String "BomLinkDocumentType"; yojson_of_bomLinkDocumentType v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let bomLink_of_json s =
  bomLink_of_yojson (Yojson.Safe.from_string s)

let json_of_bomLink x =
  Yojson.Safe.to_string (yojson_of_bomLink x)

module BomLink = struct
  type nonrec t = bomLink
  let of_yojson = bomLink_of_yojson
  let to_yojson = yojson_of_bomLink
  let of_json = bomLink_of_json
  let to_json = json_of_bomLink
end

(** Unit of carbon dioxide (CO2). *)
type co2MeasureUnit =
  | TCO2eq

let co2MeasureUnit_of_yojson (x : Yojson.Safe.t) : co2MeasureUnit =
  match x with
  | `String "tCO2eq" -> TCO2eq
  | _ -> Atdml_runtime.Yojson.bad_sum "co2MeasureUnit" x

let yojson_of_co2MeasureUnit (x : co2MeasureUnit) : Yojson.Safe.t =
  match x with
  | TCO2eq -> `String "tCO2eq"

let co2MeasureUnit_of_json s =
  co2MeasureUnit_of_yojson (Yojson.Safe.from_string s)

let json_of_co2MeasureUnit x =
  Yojson.Safe.to_string (yojson_of_co2MeasureUnit x)

module Co2MeasureUnit = struct
  type nonrec t = co2MeasureUnit
  let of_yojson = co2MeasureUnit_of_yojson
  let to_yojson = yojson_of_co2MeasureUnit
  let of_json = co2MeasureUnit_of_json
  let to_json = json_of_co2MeasureUnit
end

(** A measure of carbon dioxide (CO2). *)
type co2Measure = {
  value: float;  (** Quantity of carbon dioxide (CO2). *)
  unit: co2MeasureUnit;  (** Unit of carbon dioxide (CO2). *)
}

let create_co2Measure ~value ~unit () : co2Measure =
  { value; unit }

let co2Measure_of_yojson (x : Yojson.Safe.t) : co2Measure =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let value =
      match assoc "value" with
      | Some v -> Atdml_runtime.Yojson.float_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "co2Measure" "value"
    in
    let unit =
      match assoc "unit" with
      | Some v -> co2MeasureUnit_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "co2Measure" "unit"
    in
    { value; unit }
  | _ -> Atdml_runtime.Yojson.bad_type "co2Measure" x

let yojson_of_co2Measure (x : co2Measure) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("value", Atdml_runtime.Yojson.yojson_of_float x.value)];
    [("unit", yojson_of_co2MeasureUnit x.unit)];
  ])

let co2Measure_of_json s =
  co2Measure_of_yojson (Yojson.Safe.from_string s)

let json_of_co2Measure x =
  Yojson.Safe.to_string (yojson_of_co2Measure x)

module Co2Measure = struct
  type nonrec t = co2Measure
  let create = create_co2Measure
  let of_yojson = co2Measure_of_yojson
  let to_yojson = yojson_of_co2Measure
  let of_json = co2Measure_of_json
  let to_json = json_of_co2Measure
end

(** The general theme or subject matter of the data being specified. *)
type componentDataType =
  | Sourcecode
  | Configuration
  | Dataset
  | Definition
  | Other

let componentDataType_of_yojson (x : Yojson.Safe.t) : componentDataType =
  match x with
  | `String "source-code" -> Sourcecode
  | `String "configuration" -> Configuration
  | `String "dataset" -> Dataset
  | `String "definition" -> Definition
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "componentDataType" x

let yojson_of_componentDataType (x : componentDataType) : Yojson.Safe.t =
  match x with
  | Sourcecode -> `String "source-code"
  | Configuration -> `String "configuration"
  | Dataset -> `String "dataset"
  | Definition -> `String "definition"
  | Other -> `String "other"

let componentDataType_of_json s =
  componentDataType_of_yojson (Yojson.Safe.from_string s)

let json_of_componentDataType x =
  Yojson.Safe.to_string (yojson_of_componentDataType x)

module ComponentDataType = struct
  type nonrec t = componentDataType
  let of_yojson = componentDataType_of_yojson
  let to_yojson = yojson_of_componentDataType
  let of_json = componentDataType_of_json
  let to_json = json_of_componentDataType
end

type componentEvidenceCallstackFrames = {
  package: string option;
  (**
     A package organizes modules into namespaces, providing a unique
     namespace for each type it contains.
  *)
  module_: string;  (** A module or class that encloses functions/methods and other code. *)
  function_: string option;  (** A block of code designed to perform a particular task. *)
  parameters: string list option;  (** Optional arguments that are passed to the module or function. *)
  line: int option;  (** The line number the code that is called resides on. *)
  column: int option;  (** The column the code that is called resides. *)
  fullFilename: string option;  (** The full path and filename of the module. *)
}

let create_componentEvidenceCallstackFrames ?package ~module_ ?function_ ?parameters ?line ?column ?fullFilename () : componentEvidenceCallstackFrames =
  { package; module_; function_; parameters; line; column; fullFilename }

let componentEvidenceCallstackFrames_of_yojson (x : Yojson.Safe.t) : componentEvidenceCallstackFrames =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let package =
      match assoc "package" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let module_ =
      match assoc "module" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "componentEvidenceCallstackFrames" "module"
    in
    let function_ =
      match assoc "function" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let parameters =
      match assoc "parameters" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let line =
      match assoc "line" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let column =
      match assoc "column" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let fullFilename =
      match assoc "fullFilename" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { package; module_; function_; parameters; line; column; fullFilename }
  | _ -> Atdml_runtime.Yojson.bad_type "componentEvidenceCallstackFrames" x

let yojson_of_componentEvidenceCallstackFrames (x : componentEvidenceCallstackFrames) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.package with None -> [] | Some v -> [("package", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("module", Atdml_runtime.Yojson.yojson_of_string x.module_)];
    (match x.function_ with None -> [] | Some v -> [("function", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.parameters with None -> [] | Some v -> [("parameters", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.line with None -> [] | Some v -> [("line", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.column with None -> [] | Some v -> [("column", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.fullFilename with None -> [] | Some v -> [("fullFilename", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let componentEvidenceCallstackFrames_of_json s =
  componentEvidenceCallstackFrames_of_yojson (Yojson.Safe.from_string s)

let json_of_componentEvidenceCallstackFrames x =
  Yojson.Safe.to_string (yojson_of_componentEvidenceCallstackFrames x)

module ComponentEvidenceCallstackFrames = struct
  type nonrec t = componentEvidenceCallstackFrames
  let create = create_componentEvidenceCallstackFrames
  let of_yojson = componentEvidenceCallstackFrames_of_yojson
  let to_yojson = yojson_of_componentEvidenceCallstackFrames
  let of_json = componentEvidenceCallstackFrames_of_json
  let to_json = json_of_componentEvidenceCallstackFrames
end

(** Evidence of the components use through the callstack. *)
type componentEvidenceCallstack = {
  frames: componentEvidenceCallstackFrames list option;
  (**
     Within a call stack, a frame is a discrete unit that encapsulates an
     execution context, including local variables, parameters, and the
     return address. As function calls are made, frames are pushed onto the
     stack, forming an array-like structure that orchestrates the flow of
     program execution and manages the sequence of function invocations.
  *)
}

let create_componentEvidenceCallstack ?frames () : componentEvidenceCallstack =
  { frames }

let componentEvidenceCallstack_of_yojson (x : Yojson.Safe.t) : componentEvidenceCallstack =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let frames =
      match assoc "frames" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson componentEvidenceCallstackFrames_of_yojson) v)
    in
    { frames }
  | _ -> Atdml_runtime.Yojson.bad_type "componentEvidenceCallstack" x

let yojson_of_componentEvidenceCallstack (x : componentEvidenceCallstack) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.frames with None -> [] | Some v -> [("frames", (Atdml_runtime.Yojson.yojson_of_list yojson_of_componentEvidenceCallstackFrames) v)]);
  ])

let componentEvidenceCallstack_of_json s =
  componentEvidenceCallstack_of_yojson (Yojson.Safe.from_string s)

let json_of_componentEvidenceCallstack x =
  Yojson.Safe.to_string (yojson_of_componentEvidenceCallstack x)

module ComponentEvidenceCallstack = struct
  type nonrec t = componentEvidenceCallstack
  let create = create_componentEvidenceCallstack
  let of_yojson = componentEvidenceCallstack_of_yojson
  let to_yojson = yojson_of_componentEvidenceCallstack
  let of_json = componentEvidenceCallstack_of_json
  let to_json = json_of_componentEvidenceCallstack
end

(** The identity field of the component which the evidence describes. *)
type componentIdentityEvidenceField =
  | Group
  | Name
  | Version
  | Purl
  | Cpe
  | OmniborId
  | Swhid
  | Swid
  | Hash

let componentIdentityEvidenceField_of_yojson (x : Yojson.Safe.t) : componentIdentityEvidenceField =
  match x with
  | `String "group" -> Group
  | `String "name" -> Name
  | `String "version" -> Version
  | `String "purl" -> Purl
  | `String "cpe" -> Cpe
  | `String "omniborId" -> OmniborId
  | `String "swhid" -> Swhid
  | `String "swid" -> Swid
  | `String "hash" -> Hash
  | _ -> Atdml_runtime.Yojson.bad_sum "componentIdentityEvidenceField" x

let yojson_of_componentIdentityEvidenceField (x : componentIdentityEvidenceField) : Yojson.Safe.t =
  match x with
  | Group -> `String "group"
  | Name -> `String "name"
  | Version -> `String "version"
  | Purl -> `String "purl"
  | Cpe -> `String "cpe"
  | OmniborId -> `String "omniborId"
  | Swhid -> `String "swhid"
  | Swid -> `String "swid"
  | Hash -> `String "hash"

let componentIdentityEvidenceField_of_json s =
  componentIdentityEvidenceField_of_yojson (Yojson.Safe.from_string s)

let json_of_componentIdentityEvidenceField x =
  Yojson.Safe.to_string (yojson_of_componentIdentityEvidenceField x)

module ComponentIdentityEvidenceField = struct
  type nonrec t = componentIdentityEvidenceField
  let of_yojson = componentIdentityEvidenceField_of_yojson
  let to_yojson = yojson_of_componentIdentityEvidenceField
  let of_json = componentIdentityEvidenceField_of_json
  let to_json = json_of_componentIdentityEvidenceField
end

(** The technique used in this method of analysis. *)
type componentIdentityEvidenceMethodsTechnique =
  | Sourcecodeanalysis
  | Binaryanalysis
  | Manifestanalysis
  | Astfingerprint
  | Hashcomparison
  | Instrumentation
  | Dynamicanalysis
  | Filename
  | Attestation
  | Other

let componentIdentityEvidenceMethodsTechnique_of_yojson (x : Yojson.Safe.t) : componentIdentityEvidenceMethodsTechnique =
  match x with
  | `String "source-code-analysis" -> Sourcecodeanalysis
  | `String "binary-analysis" -> Binaryanalysis
  | `String "manifest-analysis" -> Manifestanalysis
  | `String "ast-fingerprint" -> Astfingerprint
  | `String "hash-comparison" -> Hashcomparison
  | `String "instrumentation" -> Instrumentation
  | `String "dynamic-analysis" -> Dynamicanalysis
  | `String "filename" -> Filename
  | `String "attestation" -> Attestation
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "componentIdentityEvidenceMethodsTechnique" x

let yojson_of_componentIdentityEvidenceMethodsTechnique (x : componentIdentityEvidenceMethodsTechnique) : Yojson.Safe.t =
  match x with
  | Sourcecodeanalysis -> `String "source-code-analysis"
  | Binaryanalysis -> `String "binary-analysis"
  | Manifestanalysis -> `String "manifest-analysis"
  | Astfingerprint -> `String "ast-fingerprint"
  | Hashcomparison -> `String "hash-comparison"
  | Instrumentation -> `String "instrumentation"
  | Dynamicanalysis -> `String "dynamic-analysis"
  | Filename -> `String "filename"
  | Attestation -> `String "attestation"
  | Other -> `String "other"

let componentIdentityEvidenceMethodsTechnique_of_json s =
  componentIdentityEvidenceMethodsTechnique_of_yojson (Yojson.Safe.from_string s)

let json_of_componentIdentityEvidenceMethodsTechnique x =
  Yojson.Safe.to_string (yojson_of_componentIdentityEvidenceMethodsTechnique x)

module ComponentIdentityEvidenceMethodsTechnique = struct
  type nonrec t = componentIdentityEvidenceMethodsTechnique
  let of_yojson = componentIdentityEvidenceMethodsTechnique_of_yojson
  let to_yojson = yojson_of_componentIdentityEvidenceMethodsTechnique
  let of_json = componentIdentityEvidenceMethodsTechnique_of_json
  let to_json = json_of_componentIdentityEvidenceMethodsTechnique
end

type componentIdentityEvidenceMethods = {
  technique: componentIdentityEvidenceMethodsTechnique;  (** The technique used in this method of analysis. *)
  confidence: float;
  (**
     The confidence of the evidence from 0 - 1, where 1 is 100% confidence.
     Confidence is specific to the technique used. Each technique of
     analysis can have independent confidence.
  *)
  value: string option;  (** The value or contents of the evidence. *)
}

let create_componentIdentityEvidenceMethods ~technique ~confidence ?value () : componentIdentityEvidenceMethods =
  { technique; confidence; value }

let componentIdentityEvidenceMethods_of_yojson (x : Yojson.Safe.t) : componentIdentityEvidenceMethods =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let technique =
      match assoc "technique" with
      | Some v -> componentIdentityEvidenceMethodsTechnique_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "componentIdentityEvidenceMethods" "technique"
    in
    let confidence =
      match assoc "confidence" with
      | Some v -> Atdml_runtime.Yojson.float_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "componentIdentityEvidenceMethods" "confidence"
    in
    let value =
      match assoc "value" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { technique; confidence; value }
  | _ -> Atdml_runtime.Yojson.bad_type "componentIdentityEvidenceMethods" x

let yojson_of_componentIdentityEvidenceMethods (x : componentIdentityEvidenceMethods) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("technique", yojson_of_componentIdentityEvidenceMethodsTechnique x.technique)];
    [("confidence", Atdml_runtime.Yojson.yojson_of_float x.confidence)];
    (match x.value with None -> [] | Some v -> [("value", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let componentIdentityEvidenceMethods_of_json s =
  componentIdentityEvidenceMethods_of_yojson (Yojson.Safe.from_string s)

let json_of_componentIdentityEvidenceMethods x =
  Yojson.Safe.to_string (yojson_of_componentIdentityEvidenceMethods x)

module ComponentIdentityEvidenceMethods = struct
  type nonrec t = componentIdentityEvidenceMethods
  let create = create_componentIdentityEvidenceMethods
  let of_yojson = componentIdentityEvidenceMethods_of_yojson
  let to_yojson = yojson_of_componentIdentityEvidenceMethods
  let of_json = componentIdentityEvidenceMethods_of_json
  let to_json = json_of_componentIdentityEvidenceMethods
end

(**
   Specifies the scope of the component. If scope is not specified,
   'required' scope SHOULD be assumed by the consumer of the BOM.
*)
type componentScope =
  | Required
  | Optional
  | Excluded

let componentScope_of_yojson (x : Yojson.Safe.t) : componentScope =
  match x with
  | `String "required" -> Required
  | `String "optional" -> Optional
  | `String "excluded" -> Excluded
  | _ -> Atdml_runtime.Yojson.bad_sum "componentScope" x

let yojson_of_componentScope (x : componentScope) : Yojson.Safe.t =
  match x with
  | Required -> `String "required"
  | Optional -> `String "optional"
  | Excluded -> `String "excluded"

let componentScope_of_json s =
  componentScope_of_yojson (Yojson.Safe.from_string s)

let json_of_componentScope x =
  Yojson.Safe.to_string (yojson_of_componentScope x)

module ComponentScope = struct
  type nonrec t = componentScope
  let of_yojson = componentScope_of_yojson
  let to_yojson = yojson_of_componentScope
  let of_json = componentScope_of_json
  let to_json = json_of_componentScope
end

(**
   Specifies the type of component. For software components, classify as
   application if no more specific appropriate classification is
   available or cannot be determined for the component.
*)
type componentType =
  | Application
  | Framework
  | Library
  | Container
  | Platform
  | Operatingsystem
  | Device
  | Devicedriver
  | Firmware
  | File
  | Machinelearningmodel
  | Data
  | Cryptographicasset

let componentType_of_yojson (x : Yojson.Safe.t) : componentType =
  match x with
  | `String "application" -> Application
  | `String "framework" -> Framework
  | `String "library" -> Library
  | `String "container" -> Container
  | `String "platform" -> Platform
  | `String "operating-system" -> Operatingsystem
  | `String "device" -> Device
  | `String "device-driver" -> Devicedriver
  | `String "firmware" -> Firmware
  | `String "file" -> File
  | `String "machine-learning-model" -> Machinelearningmodel
  | `String "data" -> Data
  | `String "cryptographic-asset" -> Cryptographicasset
  | _ -> Atdml_runtime.Yojson.bad_sum "componentType" x

let yojson_of_componentType (x : componentType) : Yojson.Safe.t =
  match x with
  | Application -> `String "application"
  | Framework -> `String "framework"
  | Library -> `String "library"
  | Container -> `String "container"
  | Platform -> `String "platform"
  | Operatingsystem -> `String "operating-system"
  | Device -> `String "device"
  | Devicedriver -> `String "device-driver"
  | Firmware -> `String "firmware"
  | File -> `String "file"
  | Machinelearningmodel -> `String "machine-learning-model"
  | Data -> `String "data"
  | Cryptographicasset -> `String "cryptographic-asset"

let componentType_of_json s =
  componentType_of_yojson (Yojson.Safe.from_string s)

let json_of_componentType x =
  Yojson.Safe.to_string (yojson_of_componentType x)

module ComponentType = struct
  type nonrec t = componentType
  let of_yojson = componentType_of_yojson
  let to_yojson = yojson_of_componentType
  let of_json = componentType_of_json
  let to_json = json_of_componentType
end

(**
   A copyright notice informing users of the underlying claims to
   copyright ownership in a published work.
*)
type copyright = {
  text: string;  (** The textual content of the copyright. *)
}

let create_copyright ~text () : copyright =
  { text }

let copyright_of_yojson (x : Yojson.Safe.t) : copyright =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let text =
      match assoc "text" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "copyright" "text"
    in
    { text }
  | _ -> Atdml_runtime.Yojson.bad_type "copyright" x

let yojson_of_copyright (x : copyright) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("text", Atdml_runtime.Yojson.yojson_of_string x.text)];
  ])

let copyright_of_json s =
  copyright_of_yojson (Yojson.Safe.from_string s)

let json_of_copyright x =
  Yojson.Safe.to_string (yojson_of_copyright x)

module Copyright = struct
  type nonrec t = copyright
  let create = create_copyright
  let of_yojson = copyright_of_yojson
  let to_yojson = yojson_of_copyright
  let of_json = copyright_of_json
  let to_json = json_of_copyright
end

type cryptoPropertiesAlgorithmPropertiesCertificationLevel =
  | None
  | Fips141l1
  | Fips141l2
  | Fips141l3
  | Fips141l4
  | Fips142l1
  | Fips142l2
  | Fips142l3
  | Fips142l4
  | Fips143l1
  | Fips143l2
  | Fips143l3
  | Fips143l4
  | Cceal1
  | Cceal1plus
  | Cceal2
  | Cceal2plus
  | Cceal3
  | Cceal3plus
  | Cceal4
  | Cceal4plus
  | Cceal5
  | Cceal5plus
  | Cceal6
  | Cceal6plus
  | Cceal7
  | Cceal7plus
  | Other
  | Unknown

let cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmPropertiesCertificationLevel =
  match x with
  | `String "none" -> None
  | `String "fips140-1-l1" -> Fips141l1
  | `String "fips140-1-l2" -> Fips141l2
  | `String "fips140-1-l3" -> Fips141l3
  | `String "fips140-1-l4" -> Fips141l4
  | `String "fips140-2-l1" -> Fips142l1
  | `String "fips140-2-l2" -> Fips142l2
  | `String "fips140-2-l3" -> Fips142l3
  | `String "fips140-2-l4" -> Fips142l4
  | `String "fips140-3-l1" -> Fips143l1
  | `String "fips140-3-l2" -> Fips143l2
  | `String "fips140-3-l3" -> Fips143l3
  | `String "fips140-3-l4" -> Fips143l4
  | `String "cc-eal1" -> Cceal1
  | `String "cc-eal1+" -> Cceal1plus
  | `String "cc-eal2" -> Cceal2
  | `String "cc-eal2+" -> Cceal2plus
  | `String "cc-eal3" -> Cceal3
  | `String "cc-eal3+" -> Cceal3plus
  | `String "cc-eal4" -> Cceal4
  | `String "cc-eal4+" -> Cceal4plus
  | `String "cc-eal5" -> Cceal5
  | `String "cc-eal5+" -> Cceal5plus
  | `String "cc-eal6" -> Cceal6
  | `String "cc-eal6+" -> Cceal6plus
  | `String "cc-eal7" -> Cceal7
  | `String "cc-eal7+" -> Cceal7plus
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAlgorithmPropertiesCertificationLevel" x

let yojson_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel (x : cryptoPropertiesAlgorithmPropertiesCertificationLevel) : Yojson.Safe.t =
  match x with
  | None -> `String "none"
  | Fips141l1 -> `String "fips140-1-l1"
  | Fips141l2 -> `String "fips140-1-l2"
  | Fips141l3 -> `String "fips140-1-l3"
  | Fips141l4 -> `String "fips140-1-l4"
  | Fips142l1 -> `String "fips140-2-l1"
  | Fips142l2 -> `String "fips140-2-l2"
  | Fips142l3 -> `String "fips140-2-l3"
  | Fips142l4 -> `String "fips140-2-l4"
  | Fips143l1 -> `String "fips140-3-l1"
  | Fips143l2 -> `String "fips140-3-l2"
  | Fips143l3 -> `String "fips140-3-l3"
  | Fips143l4 -> `String "fips140-3-l4"
  | Cceal1 -> `String "cc-eal1"
  | Cceal1plus -> `String "cc-eal1+"
  | Cceal2 -> `String "cc-eal2"
  | Cceal2plus -> `String "cc-eal2+"
  | Cceal3 -> `String "cc-eal3"
  | Cceal3plus -> `String "cc-eal3+"
  | Cceal4 -> `String "cc-eal4"
  | Cceal4plus -> `String "cc-eal4+"
  | Cceal5 -> `String "cc-eal5"
  | Cceal5plus -> `String "cc-eal5+"
  | Cceal6 -> `String "cc-eal6"
  | Cceal6plus -> `String "cc-eal6+"
  | Cceal7 -> `String "cc-eal7"
  | Cceal7plus -> `String "cc-eal7+"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_json s =
  cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel x)

module CryptoPropertiesAlgorithmPropertiesCertificationLevel = struct
  type nonrec t = cryptoPropertiesAlgorithmPropertiesCertificationLevel
  let of_yojson = cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel
  let of_json = cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel
end

type cryptoPropertiesAlgorithmPropertiesCryptoFunctions =
  | Generate
  | Keygen
  | Encrypt
  | Decrypt
  | Digest
  | Tag
  | Keyderive
  | Sign
  | Verify
  | Encapsulate
  | Decapsulate
  | Other
  | Unknown

let cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmPropertiesCryptoFunctions =
  match x with
  | `String "generate" -> Generate
  | `String "keygen" -> Keygen
  | `String "encrypt" -> Encrypt
  | `String "decrypt" -> Decrypt
  | `String "digest" -> Digest
  | `String "tag" -> Tag
  | `String "keyderive" -> Keyderive
  | `String "sign" -> Sign
  | `String "verify" -> Verify
  | `String "encapsulate" -> Encapsulate
  | `String "decapsulate" -> Decapsulate
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAlgorithmPropertiesCryptoFunctions" x

let yojson_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions (x : cryptoPropertiesAlgorithmPropertiesCryptoFunctions) : Yojson.Safe.t =
  match x with
  | Generate -> `String "generate"
  | Keygen -> `String "keygen"
  | Encrypt -> `String "encrypt"
  | Decrypt -> `String "decrypt"
  | Digest -> `String "digest"
  | Tag -> `String "tag"
  | Keyderive -> `String "keyderive"
  | Sign -> `String "sign"
  | Verify -> `String "verify"
  | Encapsulate -> `String "encapsulate"
  | Decapsulate -> `String "decapsulate"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_json s =
  cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions x)

module CryptoPropertiesAlgorithmPropertiesCryptoFunctions = struct
  type nonrec t = cryptoPropertiesAlgorithmPropertiesCryptoFunctions
  let of_yojson = cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions
  let of_json = cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions
end

(**
   The target and execution environment in which the algorithm is
   implemented in.
*)
type cryptoPropertiesAlgorithmPropertiesExecutionEnvironment =
  | Softwareplainram
  | Softwareencryptedram
  | Softwaretee
  | Hardware
  | Other
  | Unknown

let cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmPropertiesExecutionEnvironment =
  match x with
  | `String "software-plain-ram" -> Softwareplainram
  | `String "software-encrypted-ram" -> Softwareencryptedram
  | `String "software-tee" -> Softwaretee
  | `String "hardware" -> Hardware
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAlgorithmPropertiesExecutionEnvironment" x

let yojson_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment (x : cryptoPropertiesAlgorithmPropertiesExecutionEnvironment) : Yojson.Safe.t =
  match x with
  | Softwareplainram -> `String "software-plain-ram"
  | Softwareencryptedram -> `String "software-encrypted-ram"
  | Softwaretee -> `String "software-tee"
  | Hardware -> `String "hardware"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_json s =
  cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment x)

module CryptoPropertiesAlgorithmPropertiesExecutionEnvironment = struct
  type nonrec t = cryptoPropertiesAlgorithmPropertiesExecutionEnvironment
  let of_yojson = cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment
  let of_json = cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment
end

(**
   The target platform for which the algorithm is implemented. The
   implementation can be 'generic', running on any platform or for a
   specific platform.
*)
type cryptoPropertiesAlgorithmPropertiesImplementationPlatform =
  | Generic
  | X86_32
  | X86_64
  | Armv7a
  | Armv7m
  | Armv8a
  | Armv8m
  | Armv9a
  | Armv9m
  | S39x
  | Ppc64
  | Ppc64le
  | Other
  | Unknown

let cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmPropertiesImplementationPlatform =
  match x with
  | `String "generic" -> Generic
  | `String "x86_32" -> X86_32
  | `String "x86_64" -> X86_64
  | `String "armv7-a" -> Armv7a
  | `String "armv7-m" -> Armv7m
  | `String "armv8-a" -> Armv8a
  | `String "armv8-m" -> Armv8m
  | `String "armv9-a" -> Armv9a
  | `String "armv9-m" -> Armv9m
  | `String "s390x" -> S39x
  | `String "ppc64" -> Ppc64
  | `String "ppc64le" -> Ppc64le
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAlgorithmPropertiesImplementationPlatform" x

let yojson_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform (x : cryptoPropertiesAlgorithmPropertiesImplementationPlatform) : Yojson.Safe.t =
  match x with
  | Generic -> `String "generic"
  | X86_32 -> `String "x86_32"
  | X86_64 -> `String "x86_64"
  | Armv7a -> `String "armv7-a"
  | Armv7m -> `String "armv7-m"
  | Armv8a -> `String "armv8-a"
  | Armv8m -> `String "armv8-m"
  | Armv9a -> `String "armv9-a"
  | Armv9m -> `String "armv9-m"
  | S39x -> `String "s390x"
  | Ppc64 -> `String "ppc64"
  | Ppc64le -> `String "ppc64le"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_json s =
  cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform x)

module CryptoPropertiesAlgorithmPropertiesImplementationPlatform = struct
  type nonrec t = cryptoPropertiesAlgorithmPropertiesImplementationPlatform
  let of_yojson = cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform
  let of_json = cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform
end

(**
   The mode of operation in which the cryptographic algorithm (block
   cipher) is used.
*)
type cryptoPropertiesAlgorithmPropertiesMode =
  | Cbc
  | Ecb
  | Ccm
  | Gcm
  | Cfb
  | Ofb
  | Ctr
  | Other
  | Unknown

let cryptoPropertiesAlgorithmPropertiesMode_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmPropertiesMode =
  match x with
  | `String "cbc" -> Cbc
  | `String "ecb" -> Ecb
  | `String "ccm" -> Ccm
  | `String "gcm" -> Gcm
  | `String "cfb" -> Cfb
  | `String "ofb" -> Ofb
  | `String "ctr" -> Ctr
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAlgorithmPropertiesMode" x

let yojson_of_cryptoPropertiesAlgorithmPropertiesMode (x : cryptoPropertiesAlgorithmPropertiesMode) : Yojson.Safe.t =
  match x with
  | Cbc -> `String "cbc"
  | Ecb -> `String "ecb"
  | Ccm -> `String "ccm"
  | Gcm -> `String "gcm"
  | Cfb -> `String "cfb"
  | Ofb -> `String "ofb"
  | Ctr -> `String "ctr"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesAlgorithmPropertiesMode_of_json s =
  cryptoPropertiesAlgorithmPropertiesMode_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmPropertiesMode x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmPropertiesMode x)

module CryptoPropertiesAlgorithmPropertiesMode = struct
  type nonrec t = cryptoPropertiesAlgorithmPropertiesMode
  let of_yojson = cryptoPropertiesAlgorithmPropertiesMode_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmPropertiesMode
  let of_json = cryptoPropertiesAlgorithmPropertiesMode_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmPropertiesMode
end

(** The padding scheme that is used for the cryptographic algorithm. *)
type cryptoPropertiesAlgorithmPropertiesPadding =
  | Pkcs5
  | Pkcs7
  | Pkcs1v15
  | Oaep
  | Raw
  | Other
  | Unknown

let cryptoPropertiesAlgorithmPropertiesPadding_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmPropertiesPadding =
  match x with
  | `String "pkcs5" -> Pkcs5
  | `String "pkcs7" -> Pkcs7
  | `String "pkcs1v15" -> Pkcs1v15
  | `String "oaep" -> Oaep
  | `String "raw" -> Raw
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAlgorithmPropertiesPadding" x

let yojson_of_cryptoPropertiesAlgorithmPropertiesPadding (x : cryptoPropertiesAlgorithmPropertiesPadding) : Yojson.Safe.t =
  match x with
  | Pkcs5 -> `String "pkcs5"
  | Pkcs7 -> `String "pkcs7"
  | Pkcs1v15 -> `String "pkcs1v15"
  | Oaep -> `String "oaep"
  | Raw -> `String "raw"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesAlgorithmPropertiesPadding_of_json s =
  cryptoPropertiesAlgorithmPropertiesPadding_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmPropertiesPadding x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmPropertiesPadding x)

module CryptoPropertiesAlgorithmPropertiesPadding = struct
  type nonrec t = cryptoPropertiesAlgorithmPropertiesPadding
  let of_yojson = cryptoPropertiesAlgorithmPropertiesPadding_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmPropertiesPadding
  let of_json = cryptoPropertiesAlgorithmPropertiesPadding_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmPropertiesPadding
end

(**
   Cryptographic building blocks used in higher-level cryptographic
   systems and protocols. Primitives represent different cryptographic
   routines: deterministic random bit generators (drbg, e.g. CTR_DRBG
   from NIST SP800-90A-r1), message authentication codes (mac, e.g.
   HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20),
   signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key
   encryption schemes (pke, e.g. RSA), extended output functions (xof,
   e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement
   algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM),
   authenticated encryption (ae, e.g. AES-GCM) and the combination of
   multiple algorithms (combiner, e.g. SP800-56Cr2).
*)
type cryptoPropertiesAlgorithmPropertiesPrimitive =
  | Drbg
  | Mac
  | Blockcipher
  | Streamcipher
  | Signature
  | Hash
  | Pke
  | Xof
  | Kdf
  | Keyagree
  | Kem
  | Ae
  | Combiner
  | Other
  | Unknown

let cryptoPropertiesAlgorithmPropertiesPrimitive_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmPropertiesPrimitive =
  match x with
  | `String "drbg" -> Drbg
  | `String "mac" -> Mac
  | `String "block-cipher" -> Blockcipher
  | `String "stream-cipher" -> Streamcipher
  | `String "signature" -> Signature
  | `String "hash" -> Hash
  | `String "pke" -> Pke
  | `String "xof" -> Xof
  | `String "kdf" -> Kdf
  | `String "key-agree" -> Keyagree
  | `String "kem" -> Kem
  | `String "ae" -> Ae
  | `String "combiner" -> Combiner
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAlgorithmPropertiesPrimitive" x

let yojson_of_cryptoPropertiesAlgorithmPropertiesPrimitive (x : cryptoPropertiesAlgorithmPropertiesPrimitive) : Yojson.Safe.t =
  match x with
  | Drbg -> `String "drbg"
  | Mac -> `String "mac"
  | Blockcipher -> `String "block-cipher"
  | Streamcipher -> `String "stream-cipher"
  | Signature -> `String "signature"
  | Hash -> `String "hash"
  | Pke -> `String "pke"
  | Xof -> `String "xof"
  | Kdf -> `String "kdf"
  | Keyagree -> `String "key-agree"
  | Kem -> `String "kem"
  | Ae -> `String "ae"
  | Combiner -> `String "combiner"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesAlgorithmPropertiesPrimitive_of_json s =
  cryptoPropertiesAlgorithmPropertiesPrimitive_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmPropertiesPrimitive x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmPropertiesPrimitive x)

module CryptoPropertiesAlgorithmPropertiesPrimitive = struct
  type nonrec t = cryptoPropertiesAlgorithmPropertiesPrimitive
  let of_yojson = cryptoPropertiesAlgorithmPropertiesPrimitive_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmPropertiesPrimitive
  let of_json = cryptoPropertiesAlgorithmPropertiesPrimitive_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmPropertiesPrimitive
end

(** Additional properties specific to a cryptographic algorithm. *)
type cryptoPropertiesAlgorithmProperties = {
  primitive: cryptoPropertiesAlgorithmPropertiesPrimitive option;
  (**
     Cryptographic building blocks used in higher-level cryptographic
     systems and protocols. Primitives represent different cryptographic
     routines: deterministic random bit generators (drbg, e.g. CTR_DRBG
     from NIST SP800-90A-r1), message authentication codes (mac, e.g.
     HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20),
     signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key
     encryption schemes (pke, e.g. RSA), extended output functions (xof,
     e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement
     algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM),
     authenticated encryption (ae, e.g. AES-GCM) and the combination of
     multiple algorithms (combiner, e.g. SP800-56Cr2).
  *)
  parameterSetIdentifier: string option;
  (**
     An identifier for the parameter set of the cryptographic algorithm.
     Examples: in AES128, '128' identifies the key length in bits, in
     SHA256, '256' identifies the digest length, '128' in SHAKE128
     identifies its maximum security level in bits, and 'SHA2-128s'
     identifies a parameter set used in SLH-DSA (FIPS205).
  *)
  curve: string option;
  (**
     The specific underlying Elliptic Curve (EC) definition employed which
     is an indicator of the level of security strength, performance and
     complexity. Absent an authoritative source of curve names, CycloneDX
     recommends using curve names as defined at
     \[https://neuromancer.sk/std/\](https://neuromancer.sk/std/), the
     source of which can be found at
     \[https://github.com/J08nY/std-curves\](https://github.com/J08nY/std-curves).
  *)
  executionEnvironment: cryptoPropertiesAlgorithmPropertiesExecutionEnvironment option;
  (**
     The target and execution environment in which the algorithm is
     implemented in.
  *)
  implementationPlatform: cryptoPropertiesAlgorithmPropertiesImplementationPlatform option;
  (**
     The target platform for which the algorithm is implemented. The
     implementation can be 'generic', running on any platform or for a
     specific platform.
  *)
  certificationLevel: cryptoPropertiesAlgorithmPropertiesCertificationLevel list option;
  (**
     The certification that the implementation of the cryptographic
     algorithm has received, if any. Certifications include revisions and
     levels of FIPS 140 or Common Criteria of different Extended Assurance
     Levels (CC-EAL).
  *)
  mode: cryptoPropertiesAlgorithmPropertiesMode option;
  (**
     The mode of operation in which the cryptographic algorithm (block
     cipher) is used.
  *)
  padding: cryptoPropertiesAlgorithmPropertiesPadding option;  (** The padding scheme that is used for the cryptographic algorithm. *)
  cryptoFunctions: cryptoPropertiesAlgorithmPropertiesCryptoFunctions list option;
  (**
     The cryptographic functions implemented by the cryptographic
     algorithm.
  *)
  classicalSecurityLevel: int option;
  (**
     The classical security level that a cryptographic algorithm provides
     (in bits).
  *)
  nistQuantumSecurityLevel: int option;
  (**
     The NIST security strength category as defined in
     https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria).
     A value of 0 indicates that none of the categories are met.
  *)
}

let create_cryptoPropertiesAlgorithmProperties ?primitive ?parameterSetIdentifier ?curve ?executionEnvironment ?implementationPlatform ?certificationLevel ?mode ?padding ?cryptoFunctions ?classicalSecurityLevel ?nistQuantumSecurityLevel () : cryptoPropertiesAlgorithmProperties =
  { primitive; parameterSetIdentifier; curve; executionEnvironment; implementationPlatform; certificationLevel; mode; padding; cryptoFunctions; classicalSecurityLevel; nistQuantumSecurityLevel }

let cryptoPropertiesAlgorithmProperties_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAlgorithmProperties =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let primitive =
      match assoc "primitive" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesAlgorithmPropertiesPrimitive_of_yojson v)
    in
    let parameterSetIdentifier =
      match assoc "parameterSetIdentifier" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let curve =
      match assoc "curve" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let executionEnvironment =
      match assoc "executionEnvironment" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_yojson v)
    in
    let implementationPlatform =
      match assoc "implementationPlatform" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_yojson v)
    in
    let certificationLevel =
      match assoc "certificationLevel" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_yojson) v)
    in
    let mode =
      match assoc "mode" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesAlgorithmPropertiesMode_of_yojson v)
    in
    let padding =
      match assoc "padding" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesAlgorithmPropertiesPadding_of_yojson v)
    in
    let cryptoFunctions =
      match assoc "cryptoFunctions" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_yojson) v)
    in
    let classicalSecurityLevel =
      match assoc "classicalSecurityLevel" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let nistQuantumSecurityLevel =
      match assoc "nistQuantumSecurityLevel" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    { primitive; parameterSetIdentifier; curve; executionEnvironment; implementationPlatform; certificationLevel; mode; padding; cryptoFunctions; classicalSecurityLevel; nistQuantumSecurityLevel }
  | _ -> Atdml_runtime.Yojson.bad_type "cryptoPropertiesAlgorithmProperties" x

let yojson_of_cryptoPropertiesAlgorithmProperties (x : cryptoPropertiesAlgorithmProperties) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.primitive with None -> [] | Some v -> [("primitive", yojson_of_cryptoPropertiesAlgorithmPropertiesPrimitive v)]);
    (match x.parameterSetIdentifier with None -> [] | Some v -> [("parameterSetIdentifier", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.curve with None -> [] | Some v -> [("curve", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.executionEnvironment with None -> [] | Some v -> [("executionEnvironment", yojson_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment v)]);
    (match x.implementationPlatform with None -> [] | Some v -> [("implementationPlatform", yojson_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform v)]);
    (match x.certificationLevel with None -> [] | Some v -> [("certificationLevel", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel) v)]);
    (match x.mode with None -> [] | Some v -> [("mode", yojson_of_cryptoPropertiesAlgorithmPropertiesMode v)]);
    (match x.padding with None -> [] | Some v -> [("padding", yojson_of_cryptoPropertiesAlgorithmPropertiesPadding v)]);
    (match x.cryptoFunctions with None -> [] | Some v -> [("cryptoFunctions", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions) v)]);
    (match x.classicalSecurityLevel with None -> [] | Some v -> [("classicalSecurityLevel", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.nistQuantumSecurityLevel with None -> [] | Some v -> [("nistQuantumSecurityLevel", Atdml_runtime.Yojson.yojson_of_int v)]);
  ])

let cryptoPropertiesAlgorithmProperties_of_json s =
  cryptoPropertiesAlgorithmProperties_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAlgorithmProperties x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAlgorithmProperties x)

module CryptoPropertiesAlgorithmProperties = struct
  type nonrec t = cryptoPropertiesAlgorithmProperties
  let create = create_cryptoPropertiesAlgorithmProperties
  let of_yojson = cryptoPropertiesAlgorithmProperties_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAlgorithmProperties
  let of_json = cryptoPropertiesAlgorithmProperties_of_json
  let to_json = json_of_cryptoPropertiesAlgorithmProperties
end

(**
   Cryptographic assets occur in several forms. Algorithms and protocols
   are most commonly implemented in specialized cryptographic libraries.
   They may, however, also be 'hardcoded' in software components.
   Certificates and related cryptographic material like keys, tokens,
   secrets or passwords are other cryptographic assets to be modelled.
*)
type cryptoPropertiesAssetType =
  | Algorithm
  | Certificate
  | Protocol
  | Relatedcryptomaterial

let cryptoPropertiesAssetType_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesAssetType =
  match x with
  | `String "algorithm" -> Algorithm
  | `String "certificate" -> Certificate
  | `String "protocol" -> Protocol
  | `String "related-crypto-material" -> Relatedcryptomaterial
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesAssetType" x

let yojson_of_cryptoPropertiesAssetType (x : cryptoPropertiesAssetType) : Yojson.Safe.t =
  match x with
  | Algorithm -> `String "algorithm"
  | Certificate -> `String "certificate"
  | Protocol -> `String "protocol"
  | Relatedcryptomaterial -> `String "related-crypto-material"

let cryptoPropertiesAssetType_of_json s =
  cryptoPropertiesAssetType_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesAssetType x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesAssetType x)

module CryptoPropertiesAssetType = struct
  type nonrec t = cryptoPropertiesAssetType
  let of_yojson = cryptoPropertiesAssetType_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesAssetType
  let of_json = cryptoPropertiesAssetType_of_json
  let to_json = json_of_cryptoPropertiesAssetType
end

(** The concrete protocol type. *)
type cryptoPropertiesProtocolPropertiesType =
  | Tls
  | Ssh
  | Ipsec
  | Ike
  | Sstp
  | Wpa
  | Other
  | Unknown

let cryptoPropertiesProtocolPropertiesType_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesProtocolPropertiesType =
  match x with
  | `String "tls" -> Tls
  | `String "ssh" -> Ssh
  | `String "ipsec" -> Ipsec
  | `String "ike" -> Ike
  | `String "sstp" -> Sstp
  | `String "wpa" -> Wpa
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesProtocolPropertiesType" x

let yojson_of_cryptoPropertiesProtocolPropertiesType (x : cryptoPropertiesProtocolPropertiesType) : Yojson.Safe.t =
  match x with
  | Tls -> `String "tls"
  | Ssh -> `String "ssh"
  | Ipsec -> `String "ipsec"
  | Ike -> `String "ike"
  | Sstp -> `String "sstp"
  | Wpa -> `String "wpa"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesProtocolPropertiesType_of_json s =
  cryptoPropertiesProtocolPropertiesType_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesProtocolPropertiesType x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesProtocolPropertiesType x)

module CryptoPropertiesProtocolPropertiesType = struct
  type nonrec t = cryptoPropertiesProtocolPropertiesType
  let of_yojson = cryptoPropertiesProtocolPropertiesType_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesProtocolPropertiesType
  let of_json = cryptoPropertiesProtocolPropertiesType_of_json
  let to_json = json_of_cryptoPropertiesProtocolPropertiesType
end

(** The key state as defined by NIST SP 800-57. *)
type cryptoPropertiesRelatedCryptoMaterialPropertiesState =
  | Preactivation
  | Active
  | Suspended
  | Deactivated
  | Compromised
  | Destroyed

let cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesRelatedCryptoMaterialPropertiesState =
  match x with
  | `String "pre-activation" -> Preactivation
  | `String "active" -> Active
  | `String "suspended" -> Suspended
  | `String "deactivated" -> Deactivated
  | `String "compromised" -> Compromised
  | `String "destroyed" -> Destroyed
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesRelatedCryptoMaterialPropertiesState" x

let yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState (x : cryptoPropertiesRelatedCryptoMaterialPropertiesState) : Yojson.Safe.t =
  match x with
  | Preactivation -> `String "pre-activation"
  | Active -> `String "active"
  | Suspended -> `String "suspended"
  | Deactivated -> `String "deactivated"
  | Compromised -> `String "compromised"
  | Destroyed -> `String "destroyed"

let cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_json s =
  cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState x)

module CryptoPropertiesRelatedCryptoMaterialPropertiesState = struct
  type nonrec t = cryptoPropertiesRelatedCryptoMaterialPropertiesState
  let of_yojson = cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState
  let of_json = cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_json
  let to_json = json_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState
end

(** The type for the related cryptographic material *)
type cryptoPropertiesRelatedCryptoMaterialPropertiesType =
  | Privatekey
  | Publickey
  | Secretkey
  | Key
  | Ciphertext
  | Signature
  | Digest
  | Initializationvector
  | Nonce
  | Seed
  | Salt
  | Sharedsecret
  | Tag
  | Additionaldata
  | Password
  | Credential
  | Token
  | Other
  | Unknown

let cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesRelatedCryptoMaterialPropertiesType =
  match x with
  | `String "private-key" -> Privatekey
  | `String "public-key" -> Publickey
  | `String "secret-key" -> Secretkey
  | `String "key" -> Key
  | `String "ciphertext" -> Ciphertext
  | `String "signature" -> Signature
  | `String "digest" -> Digest
  | `String "initialization-vector" -> Initializationvector
  | `String "nonce" -> Nonce
  | `String "seed" -> Seed
  | `String "salt" -> Salt
  | `String "shared-secret" -> Sharedsecret
  | `String "tag" -> Tag
  | `String "additional-data" -> Additionaldata
  | `String "password" -> Password
  | `String "credential" -> Credential
  | `String "token" -> Token
  | `String "other" -> Other
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "cryptoPropertiesRelatedCryptoMaterialPropertiesType" x

let yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType (x : cryptoPropertiesRelatedCryptoMaterialPropertiesType) : Yojson.Safe.t =
  match x with
  | Privatekey -> `String "private-key"
  | Publickey -> `String "public-key"
  | Secretkey -> `String "secret-key"
  | Key -> `String "key"
  | Ciphertext -> `String "ciphertext"
  | Signature -> `String "signature"
  | Digest -> `String "digest"
  | Initializationvector -> `String "initialization-vector"
  | Nonce -> `String "nonce"
  | Seed -> `String "seed"
  | Salt -> `String "salt"
  | Sharedsecret -> `String "shared-secret"
  | Tag -> `String "tag"
  | Additionaldata -> `String "additional-data"
  | Password -> `String "password"
  | Credential -> `String "credential"
  | Token -> `String "token"
  | Other -> `String "other"
  | Unknown -> `String "unknown"

let cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_json s =
  cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType x)

module CryptoPropertiesRelatedCryptoMaterialPropertiesType = struct
  type nonrec t = cryptoPropertiesRelatedCryptoMaterialPropertiesType
  let of_yojson = cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType
  let of_json = cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_json
  let to_json = json_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType
end

(**
   Data classification tags data according to its type, sensitivity, and
   value if altered, stolen, or destroyed.
*)
type dataClassification = string

let create_dataClassification (x : string) : dataClassification = x


let dataClassification_of_yojson (x : Yojson.Safe.t) : dataClassification =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_dataClassification (x : dataClassification) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let dataClassification_of_json s =
  dataClassification_of_yojson (Yojson.Safe.from_string s)

let json_of_dataClassification x =
  Yojson.Safe.to_string (yojson_of_dataClassification x)

module DataClassification = struct
  type nonrec t = dataClassification
  let create = create_dataClassification
  let of_yojson = dataClassification_of_yojson
  let to_yojson = yojson_of_dataClassification
  let of_json = dataClassification_of_json
  let to_json = json_of_dataClassification
end

(**
   Specifies the flow direction of the data. Direction is relative to the
   service.
*)
type dataFlowDirection =
  | Inbound
  | Outbound
  | Bidirectional
  | Unknown

let dataFlowDirection_of_yojson (x : Yojson.Safe.t) : dataFlowDirection =
  match x with
  | `String "inbound" -> Inbound
  | `String "outbound" -> Outbound
  | `String "bi-directional" -> Bidirectional
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "dataFlowDirection" x

let yojson_of_dataFlowDirection (x : dataFlowDirection) : Yojson.Safe.t =
  match x with
  | Inbound -> `String "inbound"
  | Outbound -> `String "outbound"
  | Bidirectional -> `String "bi-directional"
  | Unknown -> `String "unknown"

let dataFlowDirection_of_json s =
  dataFlowDirection_of_yojson (Yojson.Safe.from_string s)

let json_of_dataFlowDirection x =
  Yojson.Safe.to_string (yojson_of_dataFlowDirection x)

module DataFlowDirection = struct
  type nonrec t = dataFlowDirection
  let of_yojson = dataFlowDirection_of_yojson
  let to_yojson = yojson_of_dataFlowDirection
  let of_json = dataFlowDirection_of_json
  let to_json = json_of_dataFlowDirection
end

(**
   The patch file (or diff) that shows changes. Refer to
   https://en.wikipedia.org/wiki/Diff
*)
type diff = {
  text: attachment option;
  url: string option;  (** Specifies the URL to the diff *)
}

let create_diff ?text ?url () : diff =
  { text; url }

let diff_of_yojson (x : Yojson.Safe.t) : diff =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let text =
      match assoc "text" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (attachment_of_yojson v)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { text; url }
  | _ -> Atdml_runtime.Yojson.bad_type "diff" x

let yojson_of_diff (x : diff) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.text with None -> [] | Some v -> [("text", yojson_of_attachment v)]);
    (match x.url with None -> [] | Some v -> [("url", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let diff_of_json s =
  diff_of_yojson (Yojson.Safe.from_string s)

let json_of_diff x =
  Yojson.Safe.to_string (yojson_of_diff x)

module Diff = struct
  type nonrec t = diff
  let create = create_diff
  let of_yojson = diff_of_yojson
  let to_yojson = yojson_of_diff
  let of_json = diff_of_json
  let to_json = json_of_diff
end

(**
   The type of activity that is part of a machine learning model
   development or operational lifecycle.
*)
type energyConsumptionActivity =
  | Design
  | Datacollection
  | Datapreparation
  | Training
  | Finetuning
  | Validation
  | Deployment
  | Inference
  | Other

let energyConsumptionActivity_of_yojson (x : Yojson.Safe.t) : energyConsumptionActivity =
  match x with
  | `String "design" -> Design
  | `String "data-collection" -> Datacollection
  | `String "data-preparation" -> Datapreparation
  | `String "training" -> Training
  | `String "fine-tuning" -> Finetuning
  | `String "validation" -> Validation
  | `String "deployment" -> Deployment
  | `String "inference" -> Inference
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "energyConsumptionActivity" x

let yojson_of_energyConsumptionActivity (x : energyConsumptionActivity) : Yojson.Safe.t =
  match x with
  | Design -> `String "design"
  | Datacollection -> `String "data-collection"
  | Datapreparation -> `String "data-preparation"
  | Training -> `String "training"
  | Finetuning -> `String "fine-tuning"
  | Validation -> `String "validation"
  | Deployment -> `String "deployment"
  | Inference -> `String "inference"
  | Other -> `String "other"

let energyConsumptionActivity_of_json s =
  energyConsumptionActivity_of_yojson (Yojson.Safe.from_string s)

let json_of_energyConsumptionActivity x =
  Yojson.Safe.to_string (yojson_of_energyConsumptionActivity x)

module EnergyConsumptionActivity = struct
  type nonrec t = energyConsumptionActivity
  let of_yojson = energyConsumptionActivity_of_yojson
  let to_yojson = yojson_of_energyConsumptionActivity
  let of_json = energyConsumptionActivity_of_json
  let to_json = json_of_energyConsumptionActivity
end

(** Unit of energy. *)
type energyMeasureUnit =
  | KWh

let energyMeasureUnit_of_yojson (x : Yojson.Safe.t) : energyMeasureUnit =
  match x with
  | `String "kWh" -> KWh
  | _ -> Atdml_runtime.Yojson.bad_sum "energyMeasureUnit" x

let yojson_of_energyMeasureUnit (x : energyMeasureUnit) : Yojson.Safe.t =
  match x with
  | KWh -> `String "kWh"

let energyMeasureUnit_of_json s =
  energyMeasureUnit_of_yojson (Yojson.Safe.from_string s)

let json_of_energyMeasureUnit x =
  Yojson.Safe.to_string (yojson_of_energyMeasureUnit x)

module EnergyMeasureUnit = struct
  type nonrec t = energyMeasureUnit
  let of_yojson = energyMeasureUnit_of_yojson
  let to_yojson = yojson_of_energyMeasureUnit
  let of_json = energyMeasureUnit_of_json
  let to_json = json_of_energyMeasureUnit
end

(** A measure of energy. *)
type energyMeasure = {
  value: float;  (** Quantity of energy. *)
  unit: energyMeasureUnit;  (** Unit of energy. *)
}

let create_energyMeasure ~value ~unit () : energyMeasure =
  { value; unit }

let energyMeasure_of_yojson (x : Yojson.Safe.t) : energyMeasure =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let value =
      match assoc "value" with
      | Some v -> Atdml_runtime.Yojson.float_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "energyMeasure" "value"
    in
    let unit =
      match assoc "unit" with
      | Some v -> energyMeasureUnit_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "energyMeasure" "unit"
    in
    { value; unit }
  | _ -> Atdml_runtime.Yojson.bad_type "energyMeasure" x

let yojson_of_energyMeasure (x : energyMeasure) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("value", Atdml_runtime.Yojson.yojson_of_float x.value)];
    [("unit", yojson_of_energyMeasureUnit x.unit)];
  ])

let energyMeasure_of_json s =
  energyMeasure_of_yojson (Yojson.Safe.from_string s)

let json_of_energyMeasure x =
  Yojson.Safe.to_string (yojson_of_energyMeasure x)

module EnergyMeasure = struct
  type nonrec t = energyMeasure
  let create = create_energyMeasure
  let of_yojson = energyMeasure_of_yojson
  let to_yojson = yojson_of_energyMeasure
  let of_json = energyMeasure_of_json
  let to_json = json_of_energyMeasure
end

(** The energy source for the energy provider. *)
type energyProviderEnergySource =
  | Coal
  | Oil
  | Naturalgas
  | Nuclear
  | Wind
  | Solar
  | Geothermal
  | Hydropower
  | Biofuel
  | Unknown
  | Other

let energyProviderEnergySource_of_yojson (x : Yojson.Safe.t) : energyProviderEnergySource =
  match x with
  | `String "coal" -> Coal
  | `String "oil" -> Oil
  | `String "natural-gas" -> Naturalgas
  | `String "nuclear" -> Nuclear
  | `String "wind" -> Wind
  | `String "solar" -> Solar
  | `String "geothermal" -> Geothermal
  | `String "hydropower" -> Hydropower
  | `String "biofuel" -> Biofuel
  | `String "unknown" -> Unknown
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "energyProviderEnergySource" x

let yojson_of_energyProviderEnergySource (x : energyProviderEnergySource) : Yojson.Safe.t =
  match x with
  | Coal -> `String "coal"
  | Oil -> `String "oil"
  | Naturalgas -> `String "natural-gas"
  | Nuclear -> `String "nuclear"
  | Wind -> `String "wind"
  | Solar -> `String "solar"
  | Geothermal -> `String "geothermal"
  | Hydropower -> `String "hydropower"
  | Biofuel -> `String "biofuel"
  | Unknown -> `String "unknown"
  | Other -> `String "other"

let energyProviderEnergySource_of_json s =
  energyProviderEnergySource_of_yojson (Yojson.Safe.from_string s)

let json_of_energyProviderEnergySource x =
  Yojson.Safe.to_string (yojson_of_energyProviderEnergySource x)

module EnergyProviderEnergySource = struct
  type nonrec t = energyProviderEnergySource
  let of_yojson = energyProviderEnergySource_of_yojson
  let to_yojson = yojson_of_energyProviderEnergySource
  let of_json = energyProviderEnergySource_of_json
  let to_json = json_of_energyProviderEnergySource
end

(** Specifies the type of external reference. *)
type externalReferenceType =
  | Vcs
  | Issuetracker
  | Website
  | Advisories
  | Bom
  | Mailinglist
  | Social
  | Chat
  | Documentation
  | Support
  | Sourcedistribution
  | Distribution
  | Distributionintake
  | License
  | Buildmeta
  | Buildsystem
  | Releasenotes
  | Securitycontact
  | Modelcard
  | Log
  | Configuration
  | Evidence
  | Formulation
  | Attestation
  | Threatmodel
  | Adversarymodel
  | Riskassessment
  | Vulnerabilityassertion
  | Exploitabilitystatement
  | Pentestreport
  | Staticanalysisreport
  | Dynamicanalysisreport
  | Runtimeanalysisreport
  | Componentanalysisreport
  | Maturityreport
  | Certificationreport
  | Codifiedinfrastructure
  | Qualitymetrics
  | Poam
  | Electronicsignature
  | Digitalsignature
  | Rfc9116
  | Other

let externalReferenceType_of_yojson (x : Yojson.Safe.t) : externalReferenceType =
  match x with
  | `String "vcs" -> Vcs
  | `String "issue-tracker" -> Issuetracker
  | `String "website" -> Website
  | `String "advisories" -> Advisories
  | `String "bom" -> Bom
  | `String "mailing-list" -> Mailinglist
  | `String "social" -> Social
  | `String "chat" -> Chat
  | `String "documentation" -> Documentation
  | `String "support" -> Support
  | `String "source-distribution" -> Sourcedistribution
  | `String "distribution" -> Distribution
  | `String "distribution-intake" -> Distributionintake
  | `String "license" -> License
  | `String "build-meta" -> Buildmeta
  | `String "build-system" -> Buildsystem
  | `String "release-notes" -> Releasenotes
  | `String "security-contact" -> Securitycontact
  | `String "model-card" -> Modelcard
  | `String "log" -> Log
  | `String "configuration" -> Configuration
  | `String "evidence" -> Evidence
  | `String "formulation" -> Formulation
  | `String "attestation" -> Attestation
  | `String "threat-model" -> Threatmodel
  | `String "adversary-model" -> Adversarymodel
  | `String "risk-assessment" -> Riskassessment
  | `String "vulnerability-assertion" -> Vulnerabilityassertion
  | `String "exploitability-statement" -> Exploitabilitystatement
  | `String "pentest-report" -> Pentestreport
  | `String "static-analysis-report" -> Staticanalysisreport
  | `String "dynamic-analysis-report" -> Dynamicanalysisreport
  | `String "runtime-analysis-report" -> Runtimeanalysisreport
  | `String "component-analysis-report" -> Componentanalysisreport
  | `String "maturity-report" -> Maturityreport
  | `String "certification-report" -> Certificationreport
  | `String "codified-infrastructure" -> Codifiedinfrastructure
  | `String "quality-metrics" -> Qualitymetrics
  | `String "poam" -> Poam
  | `String "electronic-signature" -> Electronicsignature
  | `String "digital-signature" -> Digitalsignature
  | `String "rfc-9116" -> Rfc9116
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "externalReferenceType" x

let yojson_of_externalReferenceType (x : externalReferenceType) : Yojson.Safe.t =
  match x with
  | Vcs -> `String "vcs"
  | Issuetracker -> `String "issue-tracker"
  | Website -> `String "website"
  | Advisories -> `String "advisories"
  | Bom -> `String "bom"
  | Mailinglist -> `String "mailing-list"
  | Social -> `String "social"
  | Chat -> `String "chat"
  | Documentation -> `String "documentation"
  | Support -> `String "support"
  | Sourcedistribution -> `String "source-distribution"
  | Distribution -> `String "distribution"
  | Distributionintake -> `String "distribution-intake"
  | License -> `String "license"
  | Buildmeta -> `String "build-meta"
  | Buildsystem -> `String "build-system"
  | Releasenotes -> `String "release-notes"
  | Securitycontact -> `String "security-contact"
  | Modelcard -> `String "model-card"
  | Log -> `String "log"
  | Configuration -> `String "configuration"
  | Evidence -> `String "evidence"
  | Formulation -> `String "formulation"
  | Attestation -> `String "attestation"
  | Threatmodel -> `String "threat-model"
  | Adversarymodel -> `String "adversary-model"
  | Riskassessment -> `String "risk-assessment"
  | Vulnerabilityassertion -> `String "vulnerability-assertion"
  | Exploitabilitystatement -> `String "exploitability-statement"
  | Pentestreport -> `String "pentest-report"
  | Staticanalysisreport -> `String "static-analysis-report"
  | Dynamicanalysisreport -> `String "dynamic-analysis-report"
  | Runtimeanalysisreport -> `String "runtime-analysis-report"
  | Componentanalysisreport -> `String "component-analysis-report"
  | Maturityreport -> `String "maturity-report"
  | Certificationreport -> `String "certification-report"
  | Codifiedinfrastructure -> `String "codified-infrastructure"
  | Qualitymetrics -> `String "quality-metrics"
  | Poam -> `String "poam"
  | Electronicsignature -> `String "electronic-signature"
  | Digitalsignature -> `String "digital-signature"
  | Rfc9116 -> `String "rfc-9116"
  | Other -> `String "other"

let externalReferenceType_of_json s =
  externalReferenceType_of_yojson (Yojson.Safe.from_string s)

let json_of_externalReferenceType x =
  Yojson.Safe.to_string (yojson_of_externalReferenceType x)

module ExternalReferenceType = struct
  type nonrec t = externalReferenceType
  let of_yojson = externalReferenceType_of_yojson
  let to_yojson = yojson_of_externalReferenceType
  let of_json = externalReferenceType_of_json
  let to_json = json_of_externalReferenceType
end

(**
   The URI (URL or URN) to the external reference. External references
   are URIs and therefore can accept any URL scheme including https
   (\[RFC-7230\](https://www.ietf.org/rfc/rfc7230.txt)), mailto
   (\[RFC-2368\](https://www.ietf.org/rfc/rfc2368.txt)), tel
   (\[RFC-3966\](https://www.ietf.org/rfc/rfc3966.txt)), and dns
   (\[RFC-4501\](https://www.ietf.org/rfc/rfc4501.txt)). External
   references may also include formally registered URNs such as
   \[CycloneDX BOM-Link\](https://cyclonedx.org/capabilities/bomlink/) to
   reference CycloneDX BOMs or any object within a BOM. BOM-Link
   transforms applicable external references into relationships that can
   be expressed in a BOM or across BOMs.
*)
type externalReferenceUrl =
  | String of string
  | BomLink of bomLink

let externalReferenceUrl_of_yojson (x : Yojson.Safe.t) : externalReferenceUrl =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "String"; v] -> String (Atdml_runtime.Yojson.string_of_yojson v)
  | `List [`String "BomLink"; v] -> BomLink (bomLink_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "externalReferenceUrl" x

let yojson_of_externalReferenceUrl (x : externalReferenceUrl) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | String v -> `List [`String "String"; Atdml_runtime.Yojson.yojson_of_string v]
    | BomLink v -> `List [`String "BomLink"; yojson_of_bomLink v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let externalReferenceUrl_of_json s =
  externalReferenceUrl_of_yojson (Yojson.Safe.from_string s)

let json_of_externalReferenceUrl x =
  Yojson.Safe.to_string (yojson_of_externalReferenceUrl x)

module ExternalReferenceUrl = struct
  type nonrec t = externalReferenceUrl
  let of_yojson = externalReferenceUrl_of_yojson
  let to_yojson = yojson_of_externalReferenceUrl
  let of_json = externalReferenceUrl_of_json
  let to_json = json_of_externalReferenceUrl
end

(**
   Information about the benefits and harms of the model to an identified
   at risk group.
*)
type fairnessAssessment = {
  groupAtRisk: string option;
  (**
     The groups or individuals at risk of being systematically
     disadvantaged by the model.
  *)
  benefits: string option;  (** Expected benefits to the identified groups. *)
  harms: string option;  (** Expected harms to the identified groups. *)
  mitigationStrategy: string option;
  (**
     With respect to the benefits and harms outlined, please describe any
     mitigation strategy implemented.
  *)
}

let create_fairnessAssessment ?groupAtRisk ?benefits ?harms ?mitigationStrategy () : fairnessAssessment =
  { groupAtRisk; benefits; harms; mitigationStrategy }

let fairnessAssessment_of_yojson (x : Yojson.Safe.t) : fairnessAssessment =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let groupAtRisk =
      match assoc "groupAtRisk" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let benefits =
      match assoc "benefits" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let harms =
      match assoc "harms" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let mitigationStrategy =
      match assoc "mitigationStrategy" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { groupAtRisk; benefits; harms; mitigationStrategy }
  | _ -> Atdml_runtime.Yojson.bad_type "fairnessAssessment" x

let yojson_of_fairnessAssessment (x : fairnessAssessment) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.groupAtRisk with None -> [] | Some v -> [("groupAtRisk", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.benefits with None -> [] | Some v -> [("benefits", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.harms with None -> [] | Some v -> [("harms", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.mitigationStrategy with None -> [] | Some v -> [("mitigationStrategy", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let fairnessAssessment_of_json s =
  fairnessAssessment_of_yojson (Yojson.Safe.from_string s)

let json_of_fairnessAssessment x =
  Yojson.Safe.to_string (yojson_of_fairnessAssessment x)

module FairnessAssessment = struct
  type nonrec t = fairnessAssessment
  let create = create_fairnessAssessment
  let of_yojson = fairnessAssessment_of_yojson
  let to_yojson = yojson_of_fairnessAssessment
  let of_json = fairnessAssessment_of_json
  let to_json = json_of_fairnessAssessment
end

type graphic = {
  name: string option;  (** The name of the graphic. *)
  image: attachment option;
}

let create_graphic ?name ?image () : graphic =
  { name; image }

let graphic_of_yojson (x : Yojson.Safe.t) : graphic =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let image =
      match assoc "image" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (attachment_of_yojson v)
    in
    { name; image }
  | _ -> Atdml_runtime.Yojson.bad_type "graphic" x

let yojson_of_graphic (x : graphic) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.image with None -> [] | Some v -> [("image", yojson_of_attachment v)]);
  ])

let graphic_of_json s =
  graphic_of_yojson (Yojson.Safe.from_string s)

let json_of_graphic x =
  Yojson.Safe.to_string (yojson_of_graphic x)

module Graphic = struct
  type nonrec t = graphic
  let create = create_graphic
  let of_yojson = graphic_of_yojson
  let to_yojson = yojson_of_graphic
  let of_json = graphic_of_json
  let to_json = json_of_graphic
end

(** A collection of graphics that represent various measurements. *)
type graphicsCollection = {
  description: string option;  (** A description of this collection of graphics. *)
  collection: graphic list option;  (** A collection of graphics. *)
}

let create_graphicsCollection ?description ?collection () : graphicsCollection =
  { description; collection }

let graphicsCollection_of_yojson (x : Yojson.Safe.t) : graphicsCollection =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let collection =
      match assoc "collection" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson graphic_of_yojson) v)
    in
    { description; collection }
  | _ -> Atdml_runtime.Yojson.bad_type "graphicsCollection" x

let yojson_of_graphicsCollection (x : graphicsCollection) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.collection with None -> [] | Some v -> [("collection", (Atdml_runtime.Yojson.yojson_of_list yojson_of_graphic) v)]);
  ])

let graphicsCollection_of_json s =
  graphicsCollection_of_yojson (Yojson.Safe.from_string s)

let json_of_graphicsCollection x =
  Yojson.Safe.to_string (yojson_of_graphicsCollection x)

module GraphicsCollection = struct
  type nonrec t = graphicsCollection
  let create = create_graphicsCollection
  let of_yojson = graphicsCollection_of_yojson
  let to_yojson = yojson_of_graphicsCollection
  let of_json = graphicsCollection_of_json
  let to_json = json_of_graphicsCollection
end

(** The algorithm that generated the hash value. *)
type hashalg =
  | MD5
  | SHA1
  | SHA256
  | SHA384
  | SHA512
  | SHA3256
  | SHA3384
  | SHA3512
  | BLAKE2b256
  | BLAKE2b384
  | BLAKE2b512
  | BLAKE3

let hashalg_of_yojson (x : Yojson.Safe.t) : hashalg =
  match x with
  | `String "MD5" -> MD5
  | `String "SHA-1" -> SHA1
  | `String "SHA-256" -> SHA256
  | `String "SHA-384" -> SHA384
  | `String "SHA-512" -> SHA512
  | `String "SHA3-256" -> SHA3256
  | `String "SHA3-384" -> SHA3384
  | `String "SHA3-512" -> SHA3512
  | `String "BLAKE2b-256" -> BLAKE2b256
  | `String "BLAKE2b-384" -> BLAKE2b384
  | `String "BLAKE2b-512" -> BLAKE2b512
  | `String "BLAKE3" -> BLAKE3
  | _ -> Atdml_runtime.Yojson.bad_sum "hashalg" x

let yojson_of_hashalg (x : hashalg) : Yojson.Safe.t =
  match x with
  | MD5 -> `String "MD5"
  | SHA1 -> `String "SHA-1"
  | SHA256 -> `String "SHA-256"
  | SHA384 -> `String "SHA-384"
  | SHA512 -> `String "SHA-512"
  | SHA3256 -> `String "SHA3-256"
  | SHA3384 -> `String "SHA3-384"
  | SHA3512 -> `String "SHA3-512"
  | BLAKE2b256 -> `String "BLAKE2b-256"
  | BLAKE2b384 -> `String "BLAKE2b-384"
  | BLAKE2b512 -> `String "BLAKE2b-512"
  | BLAKE3 -> `String "BLAKE3"

let hashalg_of_json s =
  hashalg_of_yojson (Yojson.Safe.from_string s)

let json_of_hashalg x =
  Yojson.Safe.to_string (yojson_of_hashalg x)

module Hashalg = struct
  type nonrec t = hashalg
  let of_yojson = hashalg_of_yojson
  let to_yojson = yojson_of_hashalg
  let of_json = hashalg_of_json
  let to_json = json_of_hashalg
end

(** The value of the hash. *)
type hashcontent = string

let create_hashcontent (x : string) : hashcontent = x


let hashcontent_of_yojson (x : Yojson.Safe.t) : hashcontent =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_hashcontent (x : hashcontent) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let hashcontent_of_json s =
  hashcontent_of_yojson (Yojson.Safe.from_string s)

let json_of_hashcontent x =
  Yojson.Safe.to_string (yojson_of_hashcontent x)

module Hashcontent = struct
  type nonrec t = hashcontent
  let create = create_hashcontent
  let of_yojson = hashcontent_of_yojson
  let to_yojson = yojson_of_hashcontent
  let of_json = hashcontent_of_json
  let to_json = json_of_hashcontent
end

type hash = {
  alg: hashalg;
  content: hashcontent;
}

let create_hash ~alg ~content () : hash =
  { alg; content }

let hash_of_yojson (x : Yojson.Safe.t) : hash =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let alg =
      match assoc "alg" with
      | Some v -> hashalg_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "hash" "alg"
    in
    let content =
      match assoc "content" with
      | Some v -> hashcontent_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "hash" "content"
    in
    { alg; content }
  | _ -> Atdml_runtime.Yojson.bad_type "hash" x

let yojson_of_hash (x : hash) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("alg", yojson_of_hashalg x.alg)];
    [("content", yojson_of_hashcontent x.content)];
  ])

let hash_of_json s =
  hash_of_yojson (Yojson.Safe.from_string s)

let json_of_hash x =
  Yojson.Safe.to_string (yojson_of_hash x)

module Hash = struct
  type nonrec t = hash
  let create = create_hash
  let of_yojson = hash_of_yojson
  let to_yojson = yojson_of_hash
  let of_json = hash_of_json
  let to_json = json_of_hash
end

(**
   External references provide a way to document systems, sites, and
   information that may be relevant but are not included with the BOM.
   They may also establish specific relationships within or external to
   the BOM.
*)
type externalReference = {
  url: externalReferenceUrl;
  (**
     The URI (URL or URN) to the external reference. External references
     are URIs and therefore can accept any URL scheme including https
     (\[RFC-7230\](https://www.ietf.org/rfc/rfc7230.txt)), mailto
     (\[RFC-2368\](https://www.ietf.org/rfc/rfc2368.txt)), tel
     (\[RFC-3966\](https://www.ietf.org/rfc/rfc3966.txt)), and dns
     (\[RFC-4501\](https://www.ietf.org/rfc/rfc4501.txt)). External
     references may also include formally registered URNs such as
     \[CycloneDX BOM-Link\](https://cyclonedx.org/capabilities/bomlink/) to
     reference CycloneDX BOMs or any object within a BOM. BOM-Link
     transforms applicable external references into relationships that can
     be expressed in a BOM or across BOMs.
  *)
  comment: string option;  (** An optional comment describing the external reference *)
  type_: externalReferenceType;  (** Specifies the type of external reference. *)
  hashes: hash list option;  (** The hashes of the external reference (if applicable). *)
}

let create_externalReference ~url ?comment ~type_ ?hashes () : externalReference =
  { url; comment; type_; hashes }

let externalReference_of_yojson (x : Yojson.Safe.t) : externalReference =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let url =
      match assoc "url" with
      | Some v -> externalReferenceUrl_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "externalReference" "url"
    in
    let comment =
      match assoc "comment" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let type_ =
      match assoc "type" with
      | Some v -> externalReferenceType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "externalReference" "type"
    in
    let hashes =
      match assoc "hashes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson hash_of_yojson) v)
    in
    { url; comment; type_; hashes }
  | _ -> Atdml_runtime.Yojson.bad_type "externalReference" x

let yojson_of_externalReference (x : externalReference) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("url", yojson_of_externalReferenceUrl x.url)];
    (match x.comment with None -> [] | Some v -> [("comment", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("type", yojson_of_externalReferenceType x.type_)];
    (match x.hashes with None -> [] | Some v -> [("hashes", (Atdml_runtime.Yojson.yojson_of_list yojson_of_hash) v)]);
  ])

let externalReference_of_json s =
  externalReference_of_yojson (Yojson.Safe.from_string s)

let json_of_externalReference x =
  Yojson.Safe.to_string (yojson_of_externalReference x)

module ExternalReference = struct
  type nonrec t = externalReference
  let create = create_externalReference
  let of_yojson = externalReference_of_yojson
  let to_yojson = yojson_of_externalReference
  let of_json = externalReference_of_json
  let to_json = json_of_externalReference
end

(** Specifies an individual commit *)
type identifiableAction = {
  timestamp: string option;  (** The timestamp in which the action occurred *)
  name: string option;  (** The name of the individual who performed the action *)
  email: string option;  (** The email address of the individual who performed the action *)
}

let create_identifiableAction ?timestamp ?name ?email () : identifiableAction =
  { timestamp; name; email }

let identifiableAction_of_yojson (x : Yojson.Safe.t) : identifiableAction =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let timestamp =
      match assoc "timestamp" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let email =
      match assoc "email" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { timestamp; name; email }
  | _ -> Atdml_runtime.Yojson.bad_type "identifiableAction" x

let yojson_of_identifiableAction (x : identifiableAction) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.timestamp with None -> [] | Some v -> [("timestamp", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.email with None -> [] | Some v -> [("email", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let identifiableAction_of_json s =
  identifiableAction_of_yojson (Yojson.Safe.from_string s)

let json_of_identifiableAction x =
  Yojson.Safe.to_string (yojson_of_identifiableAction x)

module IdentifiableAction = struct
  type nonrec t = identifiableAction
  let create = create_identifiableAction
  let of_yojson = identifiableAction_of_yojson
  let to_yojson = yojson_of_identifiableAction
  let of_json = identifiableAction_of_json
  let to_json = json_of_identifiableAction
end

(** Specifies an individual commit *)
type commit = {
  uid: string option;
  (**
     A unique identifier of the commit. This may be version control
     specific. For example, Subversion uses revision numbers whereas git
     uses commit hashes.
  *)
  url: string option;
  (**
     The URL to the commit. This URL will typically point to a commit in a
     version control system.
  *)
  author: identifiableAction option;
  committer: identifiableAction option;
  message: string option;  (** The text description of the contents of the commit *)
}

let create_commit ?uid ?url ?author ?committer ?message () : commit =
  { uid; url; author; committer; message }

let commit_of_yojson (x : Yojson.Safe.t) : commit =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let uid =
      match assoc "uid" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let author =
      match assoc "author" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (identifiableAction_of_yojson v)
    in
    let committer =
      match assoc "committer" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (identifiableAction_of_yojson v)
    in
    let message =
      match assoc "message" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { uid; url; author; committer; message }
  | _ -> Atdml_runtime.Yojson.bad_type "commit" x

let yojson_of_commit (x : commit) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.uid with None -> [] | Some v -> [("uid", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.url with None -> [] | Some v -> [("url", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.author with None -> [] | Some v -> [("author", yojson_of_identifiableAction v)]);
    (match x.committer with None -> [] | Some v -> [("committer", yojson_of_identifiableAction v)]);
    (match x.message with None -> [] | Some v -> [("message", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let commit_of_json s =
  commit_of_yojson (Yojson.Safe.from_string s)

let json_of_commit x =
  Yojson.Safe.to_string (yojson_of_commit x)

module Commit = struct
  type nonrec t = commit
  let create = create_commit
  let of_yojson = commit_of_yojson
  let to_yojson = yojson_of_commit
  let of_json = commit_of_json
  let to_json = json_of_commit
end

type inputOutputMLParameters = {
  format: string option;  (** The data format for input/output to the model. *)
}

let create_inputOutputMLParameters ?format () : inputOutputMLParameters =
  { format }

let inputOutputMLParameters_of_yojson (x : Yojson.Safe.t) : inputOutputMLParameters =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let format =
      match assoc "format" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { format }
  | _ -> Atdml_runtime.Yojson.bad_type "inputOutputMLParameters" x

let yojson_of_inputOutputMLParameters (x : inputOutputMLParameters) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.format with None -> [] | Some v -> [("format", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let inputOutputMLParameters_of_json s =
  inputOutputMLParameters_of_yojson (Yojson.Safe.from_string s)

let json_of_inputOutputMLParameters x =
  Yojson.Safe.to_string (yojson_of_inputOutputMLParameters x)

module InputOutputMLParameters = struct
  type nonrec t = inputOutputMLParameters
  let create = create_inputOutputMLParameters
  let of_yojson = inputOutputMLParameters_of_yojson
  let to_yojson = yojson_of_inputOutputMLParameters
  let of_json = inputOutputMLParameters_of_json
  let to_json = json_of_inputOutputMLParameters
end

(** The source of the issue where it is documented *)
type issueSource = {
  name: string option;  (** The name of the source. *)
  url: string option;  (** The url of the issue documentation as provided by the source *)
}

let create_issueSource ?name ?url () : issueSource =
  { name; url }

let issueSource_of_yojson (x : Yojson.Safe.t) : issueSource =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { name; url }
  | _ -> Atdml_runtime.Yojson.bad_type "issueSource" x

let yojson_of_issueSource (x : issueSource) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.url with None -> [] | Some v -> [("url", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let issueSource_of_json s =
  issueSource_of_yojson (Yojson.Safe.from_string s)

let json_of_issueSource x =
  Yojson.Safe.to_string (yojson_of_issueSource x)

module IssueSource = struct
  type nonrec t = issueSource
  let create = create_issueSource
  let of_yojson = issueSource_of_yojson
  let to_yojson = yojson_of_issueSource
  let of_json = issueSource_of_json
  let to_json = json_of_issueSource
end

(** Specifies the type of issue *)
type issueType =
  | Defect
  | Enhancement
  | Security

let issueType_of_yojson (x : Yojson.Safe.t) : issueType =
  match x with
  | `String "defect" -> Defect
  | `String "enhancement" -> Enhancement
  | `String "security" -> Security
  | _ -> Atdml_runtime.Yojson.bad_sum "issueType" x

let yojson_of_issueType (x : issueType) : Yojson.Safe.t =
  match x with
  | Defect -> `String "defect"
  | Enhancement -> `String "enhancement"
  | Security -> `String "security"

let issueType_of_json s =
  issueType_of_yojson (Yojson.Safe.from_string s)

let json_of_issueType x =
  Yojson.Safe.to_string (yojson_of_issueType x)

module IssueType = struct
  type nonrec t = issueType
  let of_yojson = issueType_of_yojson
  let to_yojson = yojson_of_issueType
  let of_json = issueType_of_json
  let to_json = json_of_issueType
end

(** An individual issue that has been resolved. *)
type issue = {
  type_: issueType;  (** Specifies the type of issue *)
  id: string option;  (** The identifier of the issue assigned by the source of the issue *)
  name: string option;  (** The name of the issue *)
  description: string option;  (** A description of the issue *)
  source: issueSource option;  (** The source of the issue where it is documented *)
  references: string list option;  (** A collection of URL's for reference. Multiple URLs are allowed. *)
}

let create_issue ~type_ ?id ?name ?description ?source ?references () : issue =
  { type_; id; name; description; source; references }

let issue_of_yojson (x : Yojson.Safe.t) : issue =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | Some v -> issueType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "issue" "type"
    in
    let id =
      match assoc "id" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let source =
      match assoc "source" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (issueSource_of_yojson v)
    in
    let references =
      match assoc "references" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    { type_; id; name; description; source; references }
  | _ -> Atdml_runtime.Yojson.bad_type "issue" x

let yojson_of_issue (x : issue) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("type", yojson_of_issueType x.type_)];
    (match x.id with None -> [] | Some v -> [("id", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.source with None -> [] | Some v -> [("source", yojson_of_issueSource v)]);
    (match x.references with None -> [] | Some v -> [("references", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
  ])

let issue_of_json s =
  issue_of_yojson (Yojson.Safe.from_string s)

let json_of_issue x =
  Yojson.Safe.to_string (yojson_of_issue x)

module Issue = struct
  type nonrec t = issue
  let create = create_issue
  let of_yojson = issue_of_yojson
  let to_yojson = yojson_of_issue
  let of_json = issue_of_json
  let to_json = json_of_issue
end

type json_ = Yojson.Safe.t

let json__of_yojson (x : Yojson.Safe.t) : json_ =
  (fun x -> x) x

let yojson_of_json_ (x : json_) : Yojson.Safe.t =
  (fun x -> x) x

let json__of_json s =
  json__of_yojson (Yojson.Safe.from_string s)

let json_of_json_ x =
  Yojson.Safe.to_string (yojson_of_json_ x)

module Json_ = struct
  type nonrec t = json_
  let of_yojson = json__of_yojson
  let to_yojson = yojson_of_json_
  let of_json = json__of_json
  let to_json = json_of_json_
end

type dataGovernanceResponsibleParty =
  | JsondataGovernanceResponsibleParty_1 of json_
  | JsondataGovernanceResponsibleParty_2 of json_

let dataGovernanceResponsibleParty_of_yojson (x : Yojson.Safe.t) : dataGovernanceResponsibleParty =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "JsondataGovernanceResponsibleParty_1"; v] -> JsondataGovernanceResponsibleParty_1 (json__of_yojson v)
  | `List [`String "JsondataGovernanceResponsibleParty_2"; v] -> JsondataGovernanceResponsibleParty_2 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "dataGovernanceResponsibleParty" x

let yojson_of_dataGovernanceResponsibleParty (x : dataGovernanceResponsibleParty) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | JsondataGovernanceResponsibleParty_1 v -> `List [`String "JsondataGovernanceResponsibleParty_1"; yojson_of_json_ v]
    | JsondataGovernanceResponsibleParty_2 v -> `List [`String "JsondataGovernanceResponsibleParty_2"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let dataGovernanceResponsibleParty_of_json s =
  dataGovernanceResponsibleParty_of_yojson (Yojson.Safe.from_string s)

let json_of_dataGovernanceResponsibleParty x =
  Yojson.Safe.to_string (yojson_of_dataGovernanceResponsibleParty x)

module DataGovernanceResponsibleParty = struct
  type nonrec t = dataGovernanceResponsibleParty
  let of_yojson = dataGovernanceResponsibleParty_of_yojson
  let to_yojson = yojson_of_dataGovernanceResponsibleParty
  let of_json = dataGovernanceResponsibleParty_of_json
  let to_json = json_of_dataGovernanceResponsibleParty
end

(**
   Data governance captures information regarding data ownership,
   stewardship, and custodianship, providing insights into the
   individuals or entities responsible for managing, overseeing, and
   safeguarding the data throughout its lifecycle.
*)
type dataGovernance = {
  custodians: dataGovernanceResponsibleParty list option;
  (**
     Data custodians are responsible for the safe custody, transport, and
     storage of data.
  *)
  stewards: dataGovernanceResponsibleParty list option;
  (**
     Data stewards are responsible for data content, context, and
     associated business rules.
  *)
  owners: dataGovernanceResponsibleParty list option;  (** Data owners are concerned with risk and appropriate access to data. *)
}

let create_dataGovernance ?custodians ?stewards ?owners () : dataGovernance =
  { custodians; stewards; owners }

let dataGovernance_of_yojson (x : Yojson.Safe.t) : dataGovernance =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let custodians =
      match assoc "custodians" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson dataGovernanceResponsibleParty_of_yojson) v)
    in
    let stewards =
      match assoc "stewards" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson dataGovernanceResponsibleParty_of_yojson) v)
    in
    let owners =
      match assoc "owners" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson dataGovernanceResponsibleParty_of_yojson) v)
    in
    { custodians; stewards; owners }
  | _ -> Atdml_runtime.Yojson.bad_type "dataGovernance" x

let yojson_of_dataGovernance (x : dataGovernance) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.custodians with None -> [] | Some v -> [("custodians", (Atdml_runtime.Yojson.yojson_of_list yojson_of_dataGovernanceResponsibleParty) v)]);
    (match x.stewards with None -> [] | Some v -> [("stewards", (Atdml_runtime.Yojson.yojson_of_list yojson_of_dataGovernanceResponsibleParty) v)]);
    (match x.owners with None -> [] | Some v -> [("owners", (Atdml_runtime.Yojson.yojson_of_list yojson_of_dataGovernanceResponsibleParty) v)]);
  ])

let dataGovernance_of_json s =
  dataGovernance_of_yojson (Yojson.Safe.from_string s)

let json_of_dataGovernance x =
  Yojson.Safe.to_string (yojson_of_dataGovernance x)

module DataGovernance = struct
  type nonrec t = dataGovernance
  let create = create_dataGovernance
  let of_yojson = dataGovernance_of_yojson
  let to_yojson = yojson_of_dataGovernance
  let of_json = dataGovernance_of_json
  let to_json = json_of_dataGovernance
end

(**
   Specifies the details and attributes related to a software license. It
   can either include a valid SPDX license identifier or a named license,
   along with additional properties such as license acknowledgment,
   comprehensive commercial licensing information, and the full text of
   the license.
*)
type license =
  | Jsonlicense_1 of json_
  | Jsonlicense_2 of json_

let license_of_yojson (x : Yojson.Safe.t) : license =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "Jsonlicense_1"; v] -> Jsonlicense_1 (json__of_yojson v)
  | `List [`String "Jsonlicense_2"; v] -> Jsonlicense_2 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "license" x

let yojson_of_license (x : license) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | Jsonlicense_1 v -> `List [`String "Jsonlicense_1"; yojson_of_json_ v]
    | Jsonlicense_2 v -> `List [`String "Jsonlicense_2"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let license_of_json s =
  license_of_yojson (Yojson.Safe.from_string s)

let json_of_license x =
  Yojson.Safe.to_string (yojson_of_license x)

module License = struct
  type nonrec t = license
  let of_yojson = license_of_yojson
  let to_yojson = yojson_of_license
  let of_json = license_of_json
  let to_json = json_of_license
end

type licenseChoiceLicenseChoiceItemsList = {
  license: license;
}

let create_licenseChoiceLicenseChoiceItemsList ~license () : licenseChoiceLicenseChoiceItemsList =
  { license }

let licenseChoiceLicenseChoiceItemsList_of_yojson (x : Yojson.Safe.t) : licenseChoiceLicenseChoiceItemsList =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let license =
      match assoc "license" with
      | Some v -> license_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "licenseChoiceLicenseChoiceItemsList" "license"
    in
    { license }
  | _ -> Atdml_runtime.Yojson.bad_type "licenseChoiceLicenseChoiceItemsList" x

let yojson_of_licenseChoiceLicenseChoiceItemsList (x : licenseChoiceLicenseChoiceItemsList) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("license", yojson_of_license x.license)];
  ])

let licenseChoiceLicenseChoiceItemsList_of_json s =
  licenseChoiceLicenseChoiceItemsList_of_yojson (Yojson.Safe.from_string s)

let json_of_licenseChoiceLicenseChoiceItemsList x =
  Yojson.Safe.to_string (yojson_of_licenseChoiceLicenseChoiceItemsList x)

module LicenseChoiceLicenseChoiceItemsList = struct
  type nonrec t = licenseChoiceLicenseChoiceItemsList
  let create = create_licenseChoiceLicenseChoiceItemsList
  let of_yojson = licenseChoiceLicenseChoiceItemsList_of_yojson
  let to_yojson = yojson_of_licenseChoiceLicenseChoiceItemsList
  let of_json = licenseChoiceLicenseChoiceItemsList_of_json
  let to_json = json_of_licenseChoiceLicenseChoiceItemsList
end

(**
   EITHER (list of SPDX licenses and/or named licenses) OR (tuple of one
   SPDX License Expression)
*)
type licenseChoice =
  | LicenseChoiceItemsList of licenseChoiceLicenseChoiceItemsList list
  | JsonList of json_ list

let licenseChoice_of_yojson (x : Yojson.Safe.t) : licenseChoice =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "LicenseChoiceItemsList"; v] -> LicenseChoiceItemsList ((Atdml_runtime.Yojson.list_of_yojson licenseChoiceLicenseChoiceItemsList_of_yojson) v)
  | `List [`String "JsonList"; v] -> JsonList ((Atdml_runtime.Yojson.list_of_yojson json__of_yojson) v)
  | _ -> Atdml_runtime.Yojson.bad_sum "licenseChoice" x

let yojson_of_licenseChoice (x : licenseChoice) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | LicenseChoiceItemsList v -> `List [`String "LicenseChoiceItemsList"; (Atdml_runtime.Yojson.yojson_of_list yojson_of_licenseChoiceLicenseChoiceItemsList) v]
    | JsonList v -> `List [`String "JsonList"; (Atdml_runtime.Yojson.yojson_of_list yojson_of_json_) v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let licenseChoice_of_json s =
  licenseChoice_of_yojson (Yojson.Safe.from_string s)

let json_of_licenseChoice x =
  Yojson.Safe.to_string (yojson_of_licenseChoice x)

module LicenseChoice = struct
  type nonrec t = licenseChoice
  let of_yojson = licenseChoice_of_yojson
  let to_yojson = yojson_of_licenseChoice
  let of_json = licenseChoice_of_json
  let to_json = json_of_licenseChoice
end

(**
   Defines a syntax for representing two character language code
   (ISO-639) followed by an optional two character country code. The
   language code must be lower case. If the country code is specified,
   the country code must be upper case. The language code and country
   code must be separated by a minus sign. Examples: en, en-US, fr, fr-CA
*)
type localeType = string

let create_localeType (x : string) : localeType = x


let localeType_of_yojson (x : Yojson.Safe.t) : localeType =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_localeType (x : localeType) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let localeType_of_json s =
  localeType_of_yojson (Yojson.Safe.from_string s)

let json_of_localeType x =
  Yojson.Safe.to_string (yojson_of_localeType x)

module LocaleType = struct
  type nonrec t = localeType
  let create = create_localeType
  let of_yojson = localeType_of_yojson
  let to_yojson = yojson_of_localeType
  let of_json = localeType_of_json
  let to_json = json_of_localeType
end

(**
   Learning types describing the learning problem or hybrid learning
   problem.
*)
type modelCardModelParametersApproachType =
  | Supervised
  | Unsupervised
  | Reinforcementlearning
  | Semisupervised
  | Selfsupervised

let modelCardModelParametersApproachType_of_yojson (x : Yojson.Safe.t) : modelCardModelParametersApproachType =
  match x with
  | `String "supervised" -> Supervised
  | `String "unsupervised" -> Unsupervised
  | `String "reinforcement-learning" -> Reinforcementlearning
  | `String "semi-supervised" -> Semisupervised
  | `String "self-supervised" -> Selfsupervised
  | _ -> Atdml_runtime.Yojson.bad_sum "modelCardModelParametersApproachType" x

let yojson_of_modelCardModelParametersApproachType (x : modelCardModelParametersApproachType) : Yojson.Safe.t =
  match x with
  | Supervised -> `String "supervised"
  | Unsupervised -> `String "unsupervised"
  | Reinforcementlearning -> `String "reinforcement-learning"
  | Semisupervised -> `String "semi-supervised"
  | Selfsupervised -> `String "self-supervised"

let modelCardModelParametersApproachType_of_json s =
  modelCardModelParametersApproachType_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardModelParametersApproachType x =
  Yojson.Safe.to_string (yojson_of_modelCardModelParametersApproachType x)

module ModelCardModelParametersApproachType = struct
  type nonrec t = modelCardModelParametersApproachType
  let of_yojson = modelCardModelParametersApproachType_of_yojson
  let to_yojson = yojson_of_modelCardModelParametersApproachType
  let of_json = modelCardModelParametersApproachType_of_json
  let to_json = json_of_modelCardModelParametersApproachType
end

(**
   The overall approach to learning used by the model for problem
   solving.
*)
type modelCardModelParametersApproach = {
  type_: modelCardModelParametersApproachType option;
  (**
     Learning types describing the learning problem or hybrid learning
     problem.
  *)
}

let create_modelCardModelParametersApproach ?type_ () : modelCardModelParametersApproach =
  { type_ }

let modelCardModelParametersApproach_of_yojson (x : Yojson.Safe.t) : modelCardModelParametersApproach =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (modelCardModelParametersApproachType_of_yojson v)
    in
    { type_ }
  | _ -> Atdml_runtime.Yojson.bad_type "modelCardModelParametersApproach" x

let yojson_of_modelCardModelParametersApproach (x : modelCardModelParametersApproach) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.type_ with None -> [] | Some v -> [("type", yojson_of_modelCardModelParametersApproachType v)]);
  ])

let modelCardModelParametersApproach_of_json s =
  modelCardModelParametersApproach_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardModelParametersApproach x =
  Yojson.Safe.to_string (yojson_of_modelCardModelParametersApproach x)

module ModelCardModelParametersApproach = struct
  type nonrec t = modelCardModelParametersApproach
  let create = create_modelCardModelParametersApproach
  let of_yojson = modelCardModelParametersApproach_of_yojson
  let to_yojson = yojson_of_modelCardModelParametersApproach
  let of_json = modelCardModelParametersApproach_of_json
  let to_json = json_of_modelCardModelParametersApproach
end

(** A note containing the locale and content. *)
type note = {
  locale: localeType option;
  text: attachment;
}

let create_note ?locale ~text () : note =
  { locale; text }

let note_of_yojson (x : Yojson.Safe.t) : note =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let locale =
      match assoc "locale" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (localeType_of_yojson v)
    in
    let text =
      match assoc "text" with
      | Some v -> attachment_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "note" "text"
    in
    { locale; text }
  | _ -> Atdml_runtime.Yojson.bad_type "note" x

let yojson_of_note (x : note) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.locale with None -> [] | Some v -> [("locale", yojson_of_localeType v)]);
    [("text", yojson_of_attachment x.text)];
  ])

let note_of_json s =
  note_of_yojson (Yojson.Safe.from_string s)

let json_of_note x =
  Yojson.Safe.to_string (yojson_of_note x)

module Note = struct
  type nonrec t = note
  let create = create_note
  let of_yojson = note_of_yojson
  let to_yojson = yojson_of_note
  let of_json = note_of_json
  let to_json = json_of_note
end

(**
   Specifies the purpose for the patch including the resolution of
   defects, security issues, or new behavior or functionality.
*)
type patchType =
  | Unofficial
  | Monkey
  | Backport
  | Cherrypick

let patchType_of_yojson (x : Yojson.Safe.t) : patchType =
  match x with
  | `String "unofficial" -> Unofficial
  | `String "monkey" -> Monkey
  | `String "backport" -> Backport
  | `String "cherry-pick" -> Cherrypick
  | _ -> Atdml_runtime.Yojson.bad_sum "patchType" x

let yojson_of_patchType (x : patchType) : Yojson.Safe.t =
  match x with
  | Unofficial -> `String "unofficial"
  | Monkey -> `String "monkey"
  | Backport -> `String "backport"
  | Cherrypick -> `String "cherry-pick"

let patchType_of_json s =
  patchType_of_yojson (Yojson.Safe.from_string s)

let json_of_patchType x =
  Yojson.Safe.to_string (yojson_of_patchType x)

module PatchType = struct
  type nonrec t = patchType
  let of_yojson = patchType_of_yojson
  let to_yojson = yojson_of_patchType
  let of_json = patchType_of_json
  let to_json = json_of_patchType
end

(** Specifies an individual patch *)
type patch = {
  type_: patchType;
  (**
     Specifies the purpose for the patch including the resolution of
     defects, security issues, or new behavior or functionality.
  *)
  diff: diff option;
  resolves: issue list option;  (** A collection of issues the patch resolves *)
}

let create_patch ~type_ ?diff ?resolves () : patch =
  { type_; diff; resolves }

let patch_of_yojson (x : Yojson.Safe.t) : patch =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | Some v -> patchType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "patch" "type"
    in
    let diff =
      match assoc "diff" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (diff_of_yojson v)
    in
    let resolves =
      match assoc "resolves" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson issue_of_yojson) v)
    in
    { type_; diff; resolves }
  | _ -> Atdml_runtime.Yojson.bad_type "patch" x

let yojson_of_patch (x : patch) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("type", yojson_of_patchType x.type_)];
    (match x.diff with None -> [] | Some v -> [("diff", yojson_of_diff v)]);
    (match x.resolves with None -> [] | Some v -> [("resolves", (Atdml_runtime.Yojson.yojson_of_list yojson_of_issue) v)]);
  ])

let patch_of_json s =
  patch_of_yojson (Yojson.Safe.from_string s)

let json_of_patch x =
  Yojson.Safe.to_string (yojson_of_patch x)

module Patch = struct
  type nonrec t = patch
  let create = create_patch
  let of_yojson = patch_of_yojson
  let to_yojson = yojson_of_patch
  let of_json = patch_of_json
  let to_json = json_of_patch
end

(** The confidence interval of the metric. *)
type performanceMetricConfidenceInterval = {
  lowerBound: string option;  (** The lower bound of the confidence interval. *)
  upperBound: string option;  (** The upper bound of the confidence interval. *)
}

let create_performanceMetricConfidenceInterval ?lowerBound ?upperBound () : performanceMetricConfidenceInterval =
  { lowerBound; upperBound }

let performanceMetricConfidenceInterval_of_yojson (x : Yojson.Safe.t) : performanceMetricConfidenceInterval =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let lowerBound =
      match assoc "lowerBound" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let upperBound =
      match assoc "upperBound" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { lowerBound; upperBound }
  | _ -> Atdml_runtime.Yojson.bad_type "performanceMetricConfidenceInterval" x

let yojson_of_performanceMetricConfidenceInterval (x : performanceMetricConfidenceInterval) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.lowerBound with None -> [] | Some v -> [("lowerBound", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.upperBound with None -> [] | Some v -> [("upperBound", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let performanceMetricConfidenceInterval_of_json s =
  performanceMetricConfidenceInterval_of_yojson (Yojson.Safe.from_string s)

let json_of_performanceMetricConfidenceInterval x =
  Yojson.Safe.to_string (yojson_of_performanceMetricConfidenceInterval x)

module PerformanceMetricConfidenceInterval = struct
  type nonrec t = performanceMetricConfidenceInterval
  let create = create_performanceMetricConfidenceInterval
  let of_yojson = performanceMetricConfidenceInterval_of_yojson
  let to_yojson = yojson_of_performanceMetricConfidenceInterval
  let of_json = performanceMetricConfidenceInterval_of_json
  let to_json = json_of_performanceMetricConfidenceInterval
end

type performanceMetric = {
  type_: string option;  (** The type of performance metric. *)
  value: string option;  (** The value of the performance metric. *)
  slice: string option;
  (**
     The name of the slice this metric was computed on. By default, assume
     this metric is not sliced.
  *)
  confidenceInterval: performanceMetricConfidenceInterval option;  (** The confidence interval of the metric. *)
}

let create_performanceMetric ?type_ ?value ?slice ?confidenceInterval () : performanceMetric =
  { type_; value; slice; confidenceInterval }

let performanceMetric_of_yojson (x : Yojson.Safe.t) : performanceMetric =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let value =
      match assoc "value" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let slice =
      match assoc "slice" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let confidenceInterval =
      match assoc "confidenceInterval" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (performanceMetricConfidenceInterval_of_yojson v)
    in
    { type_; value; slice; confidenceInterval }
  | _ -> Atdml_runtime.Yojson.bad_type "performanceMetric" x

let yojson_of_performanceMetric (x : performanceMetric) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.type_ with None -> [] | Some v -> [("type", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.value with None -> [] | Some v -> [("value", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.slice with None -> [] | Some v -> [("slice", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.confidenceInterval with None -> [] | Some v -> [("confidenceInterval", yojson_of_performanceMetricConfidenceInterval v)]);
  ])

let performanceMetric_of_json s =
  performanceMetric_of_yojson (Yojson.Safe.from_string s)

let json_of_performanceMetric x =
  Yojson.Safe.to_string (yojson_of_performanceMetric x)

module PerformanceMetric = struct
  type nonrec t = performanceMetric
  let create = create_performanceMetric
  let of_yojson = performanceMetric_of_yojson
  let to_yojson = yojson_of_performanceMetric
  let of_json = performanceMetric_of_json
  let to_json = json_of_performanceMetric
end

(** A quantitative analysis of the model *)
type modelCardQuantitativeAnalysis = {
  performanceMetrics: performanceMetric list option;
  (**
     The model performance metrics being reported. Examples may include
     accuracy, F1 score, precision, top-3 error rates, MSC, etc.
  *)
  graphics: graphicsCollection option;
}

let create_modelCardQuantitativeAnalysis ?performanceMetrics ?graphics () : modelCardQuantitativeAnalysis =
  { performanceMetrics; graphics }

let modelCardQuantitativeAnalysis_of_yojson (x : Yojson.Safe.t) : modelCardQuantitativeAnalysis =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let performanceMetrics =
      match assoc "performanceMetrics" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson performanceMetric_of_yojson) v)
    in
    let graphics =
      match assoc "graphics" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (graphicsCollection_of_yojson v)
    in
    { performanceMetrics; graphics }
  | _ -> Atdml_runtime.Yojson.bad_type "modelCardQuantitativeAnalysis" x

let yojson_of_modelCardQuantitativeAnalysis (x : modelCardQuantitativeAnalysis) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.performanceMetrics with None -> [] | Some v -> [("performanceMetrics", (Atdml_runtime.Yojson.yojson_of_list yojson_of_performanceMetric) v)]);
    (match x.graphics with None -> [] | Some v -> [("graphics", yojson_of_graphicsCollection v)]);
  ])

let modelCardQuantitativeAnalysis_of_json s =
  modelCardQuantitativeAnalysis_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardQuantitativeAnalysis x =
  Yojson.Safe.to_string (yojson_of_modelCardQuantitativeAnalysis x)

module ModelCardQuantitativeAnalysis = struct
  type nonrec t = modelCardQuantitativeAnalysis
  let create = create_modelCardQuantitativeAnalysis
  let of_yojson = modelCardQuantitativeAnalysis_of_yojson
  let to_yojson = yojson_of_modelCardQuantitativeAnalysis
  let of_json = modelCardQuantitativeAnalysis_of_json
  let to_json = json_of_modelCardQuantitativeAnalysis
end

(**
   Provides the ability to document properties in a name-value store.
   This provides flexibility to include data not officially supported in
   the standard without having to use additional namespaces or create
   extensions. Unlike key-value stores, properties support duplicate
   names, each potentially having different values. Property names of
   interest to the general public are encouraged to be registered in the
   \[CycloneDX Property
   Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
   Formal registration is optional.
*)
type property = {
  name: string;
  (**
     The name of the property. Duplicate names are allowed, each
     potentially having a different value.
  *)
  value: string option;  (** The value of the property. *)
}

let create_property ~name ?value () : property =
  { name; value }

let property_of_yojson (x : Yojson.Safe.t) : property =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "property" "name"
    in
    let value =
      match assoc "value" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { name; value }
  | _ -> Atdml_runtime.Yojson.bad_type "property" x

let yojson_of_property (x : property) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("name", Atdml_runtime.Yojson.yojson_of_string x.name)];
    (match x.value with None -> [] | Some v -> [("value", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let property_of_json s =
  property_of_yojson (Yojson.Safe.from_string s)

let json_of_property x =
  Yojson.Safe.to_string (yojson_of_property x)

module Property = struct
  type nonrec t = property
  let create = create_property
  let of_yojson = property_of_yojson
  let to_yojson = yojson_of_property
  let of_json = property_of_json
  let to_json = json_of_property
end

(**
   The contents or references to the contents of the data being
   described.
*)
type componentDataContents = {
  attachment: attachment option;
  url: string option;  (** The URL to where the data can be retrieved. *)
  properties: property list option;
  (**
     Provides the ability to document name-value parameters used for
     configuration.
  *)
}

let create_componentDataContents ?attachment ?url ?properties () : componentDataContents =
  { attachment; url; properties }

let componentDataContents_of_yojson (x : Yojson.Safe.t) : componentDataContents =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let attachment =
      match assoc "attachment" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (attachment_of_yojson v)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { attachment; url; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "componentDataContents" x

let yojson_of_componentDataContents (x : componentDataContents) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.attachment with None -> [] | Some v -> [("attachment", yojson_of_attachment v)]);
    (match x.url with None -> [] | Some v -> [("url", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let componentDataContents_of_json s =
  componentDataContents_of_yojson (Yojson.Safe.from_string s)

let json_of_componentDataContents x =
  Yojson.Safe.to_string (yojson_of_componentDataContents x)

module ComponentDataContents = struct
  type nonrec t = componentDataContents
  let create = create_componentDataContents
  let of_yojson = componentDataContents_of_yojson
  let to_yojson = yojson_of_componentDataContents
  let of_json = componentDataContents_of_json
  let to_json = json_of_componentDataContents
end

(**
   Descriptor for an element identified by the attribute 'bom-ref' in the
   same BOM document. In contrast to `bomLinkElementType`.
*)
type refLinkType = json_

let refLinkType_of_yojson (x : Yojson.Safe.t) : refLinkType =
  json__of_yojson x

let yojson_of_refLinkType (x : refLinkType) : Yojson.Safe.t =
  yojson_of_json_ x

let refLinkType_of_json s =
  refLinkType_of_yojson (Yojson.Safe.from_string s)

let json_of_refLinkType x =
  Yojson.Safe.to_string (yojson_of_refLinkType x)

module RefLinkType = struct
  type nonrec t = refLinkType
  let of_yojson = refLinkType_of_yojson
  let to_yojson = yojson_of_refLinkType
  let of_json = refLinkType_of_json
  let to_json = json_of_refLinkType
end

type componentIdentityEvidenceTools =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

let componentIdentityEvidenceTools_of_yojson (x : Yojson.Safe.t) : componentIdentityEvidenceTools =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "RefLinkType"; v] -> RefLinkType (refLinkType_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "componentIdentityEvidenceTools" x

let yojson_of_componentIdentityEvidenceTools (x : componentIdentityEvidenceTools) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | RefLinkType v -> `List [`String "RefLinkType"; yojson_of_refLinkType v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let componentIdentityEvidenceTools_of_json s =
  componentIdentityEvidenceTools_of_yojson (Yojson.Safe.from_string s)

let json_of_componentIdentityEvidenceTools x =
  Yojson.Safe.to_string (yojson_of_componentIdentityEvidenceTools x)

module ComponentIdentityEvidenceTools = struct
  type nonrec t = componentIdentityEvidenceTools
  let of_yojson = componentIdentityEvidenceTools_of_yojson
  let to_yojson = yojson_of_componentIdentityEvidenceTools
  let of_json = componentIdentityEvidenceTools_of_json
  let to_json = json_of_componentIdentityEvidenceTools
end

(** Evidence that substantiates the identity of a component. *)
type componentIdentityEvidence = {
  field: componentIdentityEvidenceField;  (** The identity field of the component which the evidence describes. *)
  confidence: float option;
  (**
     The overall confidence of the evidence from 0 - 1, where 1 is 100%
     confidence.
  *)
  concludedValue: string option;
  (**
     The value of the field (cpe, purl, etc) that has been concluded based
     on the aggregate of all methods (if available).
  *)
  methods: componentIdentityEvidenceMethods list option;  (** The methods used to extract and/or analyze the evidence. *)
  tools: componentIdentityEvidenceTools list option;
  (**
     The object in the BOM identified by its bom-ref. This is often a
     component or service but may be any object type supporting bom-refs.
     Tools used for analysis should already be defined in the BOM, either
     in the metadata/tools, components, or formulation.
  *)
}

let create_componentIdentityEvidence ~field ?confidence ?concludedValue ?methods ?tools () : componentIdentityEvidence =
  { field; confidence; concludedValue; methods; tools }

let componentIdentityEvidence_of_yojson (x : Yojson.Safe.t) : componentIdentityEvidence =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let field =
      match assoc "field" with
      | Some v -> componentIdentityEvidenceField_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "componentIdentityEvidence" "field"
    in
    let confidence =
      match assoc "confidence" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.float_of_yojson v)
    in
    let concludedValue =
      match assoc "concludedValue" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let methods =
      match assoc "methods" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson componentIdentityEvidenceMethods_of_yojson) v)
    in
    let tools =
      match assoc "tools" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson componentIdentityEvidenceTools_of_yojson) v)
    in
    { field; confidence; concludedValue; methods; tools }
  | _ -> Atdml_runtime.Yojson.bad_type "componentIdentityEvidence" x

let yojson_of_componentIdentityEvidence (x : componentIdentityEvidence) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("field", yojson_of_componentIdentityEvidenceField x.field)];
    (match x.confidence with None -> [] | Some v -> [("confidence", Atdml_runtime.Yojson.yojson_of_float v)]);
    (match x.concludedValue with None -> [] | Some v -> [("concludedValue", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.methods with None -> [] | Some v -> [("methods", (Atdml_runtime.Yojson.yojson_of_list yojson_of_componentIdentityEvidenceMethods) v)]);
    (match x.tools with None -> [] | Some v -> [("tools", (Atdml_runtime.Yojson.yojson_of_list yojson_of_componentIdentityEvidenceTools) v)]);
  ])

let componentIdentityEvidence_of_json s =
  componentIdentityEvidence_of_yojson (Yojson.Safe.from_string s)

let json_of_componentIdentityEvidence x =
  Yojson.Safe.to_string (yojson_of_componentIdentityEvidence x)

module ComponentIdentityEvidence = struct
  type nonrec t = componentIdentityEvidence
  let create = create_componentIdentityEvidence
  let of_yojson = componentIdentityEvidence_of_yojson
  let to_yojson = yojson_of_componentIdentityEvidence
  let of_json = componentIdentityEvidence_of_json
  let to_json = json_of_componentIdentityEvidence
end

(**
   Evidence that substantiates the identity of a component. The identity
   may be an object or an array of identity objects. Support for
   specifying identity as a single object was introduced in CycloneDX
   v1.5. Arrays were introduced in v1.6. It is recommended that all
   implementations use arrays, even if only one identity object is
   specified.
*)
type componentEvidenceIdentity =
  | ComponentIdentityEvidenceList of componentIdentityEvidence list
  | ComponentIdentityEvidence of componentIdentityEvidence

let componentEvidenceIdentity_of_yojson (x : Yojson.Safe.t) : componentEvidenceIdentity =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "ComponentIdentityEvidenceList"; v] -> ComponentIdentityEvidenceList ((Atdml_runtime.Yojson.list_of_yojson componentIdentityEvidence_of_yojson) v)
  | `List [`String "ComponentIdentityEvidence"; v] -> ComponentIdentityEvidence (componentIdentityEvidence_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "componentEvidenceIdentity" x

let yojson_of_componentEvidenceIdentity (x : componentEvidenceIdentity) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | ComponentIdentityEvidenceList v -> `List [`String "ComponentIdentityEvidenceList"; (Atdml_runtime.Yojson.yojson_of_list yojson_of_componentIdentityEvidence) v]
    | ComponentIdentityEvidence v -> `List [`String "ComponentIdentityEvidence"; yojson_of_componentIdentityEvidence v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let componentEvidenceIdentity_of_json s =
  componentEvidenceIdentity_of_yojson (Yojson.Safe.from_string s)

let json_of_componentEvidenceIdentity x =
  Yojson.Safe.to_string (yojson_of_componentEvidenceIdentity x)

module ComponentEvidenceIdentity = struct
  type nonrec t = componentEvidenceIdentity
  let of_yojson = componentEvidenceIdentity_of_yojson
  let to_yojson = yojson_of_componentEvidenceIdentity
  let of_json = componentEvidenceIdentity_of_json
  let to_json = json_of_componentEvidenceIdentity
end

(** References a data component by the components bom-ref attribute *)
type modelCardModelParametersDatasetsDataReferenceRef =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

let modelCardModelParametersDatasetsDataReferenceRef_of_yojson (x : Yojson.Safe.t) : modelCardModelParametersDatasetsDataReferenceRef =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "RefLinkType"; v] -> RefLinkType (refLinkType_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "modelCardModelParametersDatasetsDataReferenceRef" x

let yojson_of_modelCardModelParametersDatasetsDataReferenceRef (x : modelCardModelParametersDatasetsDataReferenceRef) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | RefLinkType v -> `List [`String "RefLinkType"; yojson_of_refLinkType v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let modelCardModelParametersDatasetsDataReferenceRef_of_json s =
  modelCardModelParametersDatasetsDataReferenceRef_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardModelParametersDatasetsDataReferenceRef x =
  Yojson.Safe.to_string (yojson_of_modelCardModelParametersDatasetsDataReferenceRef x)

module ModelCardModelParametersDatasetsDataReferenceRef = struct
  type nonrec t = modelCardModelParametersDatasetsDataReferenceRef
  let of_yojson = modelCardModelParametersDatasetsDataReferenceRef_of_yojson
  let to_yojson = yojson_of_modelCardModelParametersDatasetsDataReferenceRef
  let of_json = modelCardModelParametersDatasetsDataReferenceRef_of_json
  let to_json = json_of_modelCardModelParametersDatasetsDataReferenceRef
end

type modelCardModelParametersDatasetsDataReference = {
  ref: modelCardModelParametersDatasetsDataReferenceRef option;  (** References a data component by the components bom-ref attribute *)
}

let create_modelCardModelParametersDatasetsDataReference ?ref () : modelCardModelParametersDatasetsDataReference =
  { ref }

let modelCardModelParametersDatasetsDataReference_of_yojson (x : Yojson.Safe.t) : modelCardModelParametersDatasetsDataReference =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let ref =
      match assoc "ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (modelCardModelParametersDatasetsDataReferenceRef_of_yojson v)
    in
    { ref }
  | _ -> Atdml_runtime.Yojson.bad_type "modelCardModelParametersDatasetsDataReference" x

let yojson_of_modelCardModelParametersDatasetsDataReference (x : modelCardModelParametersDatasetsDataReference) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.ref with None -> [] | Some v -> [("ref", yojson_of_modelCardModelParametersDatasetsDataReferenceRef v)]);
  ])

let modelCardModelParametersDatasetsDataReference_of_json s =
  modelCardModelParametersDatasetsDataReference_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardModelParametersDatasetsDataReference x =
  Yojson.Safe.to_string (yojson_of_modelCardModelParametersDatasetsDataReference x)

module ModelCardModelParametersDatasetsDataReference = struct
  type nonrec t = modelCardModelParametersDatasetsDataReference
  let create = create_modelCardModelParametersDatasetsDataReference
  let of_yojson = modelCardModelParametersDatasetsDataReference_of_yojson
  let to_yojson = yojson_of_modelCardModelParametersDatasetsDataReference
  let of_json = modelCardModelParametersDatasetsDataReference_of_json
  let to_json = json_of_modelCardModelParametersDatasetsDataReference
end

(**
   Identifier for referable and therefore interlinkable elements. Value
   SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts
   with BOM-Links.
*)
type refType = string

let create_refType (x : string) : refType = x


let refType_of_yojson (x : Yojson.Safe.t) : refType =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_refType (x : refType) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let refType_of_json s =
  refType_of_yojson (Yojson.Safe.from_string s)

let json_of_refType x =
  Yojson.Safe.to_string (yojson_of_refType x)

module RefType = struct
  type nonrec t = refType
  let create = create_refType
  let of_yojson = refType_of_yojson
  let to_yojson = yojson_of_refType
  let of_json = refType_of_json
  let to_json = json_of_refType
end

(** Object representing a cipher suite *)
type cipherSuite = {
  name: string option;  (** A common name for the cipher suite. *)
  algorithms: refType list option;  (** A list of algorithms related to the cipher suite. *)
  identifiers: string list option;  (** A list of common identifiers for the cipher suite. *)
}

let create_cipherSuite ?name ?algorithms ?identifiers () : cipherSuite =
  { name; algorithms; identifiers }

let cipherSuite_of_yojson (x : Yojson.Safe.t) : cipherSuite =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let algorithms =
      match assoc "algorithms" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refType_of_yojson) v)
    in
    let identifiers =
      match assoc "identifiers" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    { name; algorithms; identifiers }
  | _ -> Atdml_runtime.Yojson.bad_type "cipherSuite" x

let yojson_of_cipherSuite (x : cipherSuite) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.algorithms with None -> [] | Some v -> [("algorithms", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refType) v)]);
    (match x.identifiers with None -> [] | Some v -> [("identifiers", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
  ])

let cipherSuite_of_json s =
  cipherSuite_of_yojson (Yojson.Safe.from_string s)

let json_of_cipherSuite x =
  Yojson.Safe.to_string (yojson_of_cipherSuite x)

module CipherSuite = struct
  type nonrec t = cipherSuite
  let create = create_cipherSuite
  let of_yojson = cipherSuite_of_yojson
  let to_yojson = yojson_of_cipherSuite
  let of_json = cipherSuite_of_json
  let to_json = json_of_cipherSuite
end

type componentData = {
  bomref: refType option;
  type_: componentDataType;  (** The general theme or subject matter of the data being specified. *)
  name: string option;  (** The name of the dataset. *)
  contents: componentDataContents option;
  (**
     The contents or references to the contents of the data being
     described.
  *)
  classification: dataClassification option;
  sensitiveData: string list option;  (** A description of any sensitive data in a dataset. *)
  graphics: graphicsCollection option;
  description: string option;
  (**
     A description of the dataset. Can describe size of dataset, whether
     it's used for source code, training, testing, or validation, etc.
  *)
  governance: dataGovernance option;
}

let create_componentData ?bomref ~type_ ?name ?contents ?classification ?sensitiveData ?graphics ?description ?governance () : componentData =
  { bomref; type_; name; contents; classification; sensitiveData; graphics; description; governance }

let componentData_of_yojson (x : Yojson.Safe.t) : componentData =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let type_ =
      match assoc "type" with
      | Some v -> componentDataType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "componentData" "type"
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let contents =
      match assoc "contents" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (componentDataContents_of_yojson v)
    in
    let classification =
      match assoc "classification" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (dataClassification_of_yojson v)
    in
    let sensitiveData =
      match assoc "sensitiveData" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let graphics =
      match assoc "graphics" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (graphicsCollection_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let governance =
      match assoc "governance" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (dataGovernance_of_yojson v)
    in
    { bomref; type_; name; contents; classification; sensitiveData; graphics; description; governance }
  | _ -> Atdml_runtime.Yojson.bad_type "componentData" x

let yojson_of_componentData (x : componentData) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    [("type", yojson_of_componentDataType x.type_)];
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.contents with None -> [] | Some v -> [("contents", yojson_of_componentDataContents v)]);
    (match x.classification with None -> [] | Some v -> [("classification", yojson_of_dataClassification v)]);
    (match x.sensitiveData with None -> [] | Some v -> [("sensitiveData", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.graphics with None -> [] | Some v -> [("graphics", yojson_of_graphicsCollection v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.governance with None -> [] | Some v -> [("governance", yojson_of_dataGovernance v)]);
  ])

let componentData_of_json s =
  componentData_of_yojson (Yojson.Safe.from_string s)

let json_of_componentData x =
  Yojson.Safe.to_string (yojson_of_componentData x)

module ComponentData = struct
  type nonrec t = componentData
  let create = create_componentData
  let of_yojson = componentData_of_yojson
  let to_yojson = yojson_of_componentData
  let of_json = componentData_of_json
  let to_json = json_of_componentData
end

type componentEvidenceOccurrences = {
  bomref: refType option;
  location: string;  (** The location or path to where the component was found. *)
  line: int option;  (** The line number where the component was found. *)
  offset: int option;  (** The offset where the component was found. *)
  symbol: string option;  (** The symbol name that was found associated with the component. *)
  additionalContext: string option;
  (**
     Any additional context of the detected component (e.g. a code
     snippet).
  *)
}

let create_componentEvidenceOccurrences ?bomref ~location ?line ?offset ?symbol ?additionalContext () : componentEvidenceOccurrences =
  { bomref; location; line; offset; symbol; additionalContext }

let componentEvidenceOccurrences_of_yojson (x : Yojson.Safe.t) : componentEvidenceOccurrences =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let location =
      match assoc "location" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "componentEvidenceOccurrences" "location"
    in
    let line =
      match assoc "line" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let offset =
      match assoc "offset" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let symbol =
      match assoc "symbol" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let additionalContext =
      match assoc "additionalContext" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { bomref; location; line; offset; symbol; additionalContext }
  | _ -> Atdml_runtime.Yojson.bad_type "componentEvidenceOccurrences" x

let yojson_of_componentEvidenceOccurrences (x : componentEvidenceOccurrences) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    [("location", Atdml_runtime.Yojson.yojson_of_string x.location)];
    (match x.line with None -> [] | Some v -> [("line", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.offset with None -> [] | Some v -> [("offset", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.symbol with None -> [] | Some v -> [("symbol", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.additionalContext with None -> [] | Some v -> [("additionalContext", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let componentEvidenceOccurrences_of_json s =
  componentEvidenceOccurrences_of_yojson (Yojson.Safe.from_string s)

let json_of_componentEvidenceOccurrences x =
  Yojson.Safe.to_string (yojson_of_componentEvidenceOccurrences x)

module ComponentEvidenceOccurrences = struct
  type nonrec t = componentEvidenceOccurrences
  let create = create_componentEvidenceOccurrences
  let of_yojson = componentEvidenceOccurrences_of_yojson
  let to_yojson = yojson_of_componentEvidenceOccurrences
  let of_json = componentEvidenceOccurrences_of_json
  let to_json = json_of_componentEvidenceOccurrences
end

(**
   Provides the ability to document evidence collected through various
   forms of extraction or analysis.
*)
type componentEvidence = {
  identity: componentEvidenceIdentity option;
  (**
     Evidence that substantiates the identity of a component. The identity
     may be an object or an array of identity objects. Support for
     specifying identity as a single object was introduced in CycloneDX
     v1.5. Arrays were introduced in v1.6. It is recommended that all
     implementations use arrays, even if only one identity object is
     specified.
  *)
  occurrences: componentEvidenceOccurrences list option;
  (**
     Evidence of individual instances of a component spread across multiple
     locations.
  *)
  callstack: componentEvidenceCallstack option;  (** Evidence of the components use through the callstack. *)
  licenses: licenseChoice option;
  copyright: copyright list option;
  (**
     Copyright evidence captures intellectual property assertions,
     providing evidence of possible ownership and legal protection.
  *)
}

let create_componentEvidence ?identity ?occurrences ?callstack ?licenses ?copyright () : componentEvidence =
  { identity; occurrences; callstack; licenses; copyright }

let componentEvidence_of_yojson (x : Yojson.Safe.t) : componentEvidence =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let identity =
      match assoc "identity" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (componentEvidenceIdentity_of_yojson v)
    in
    let occurrences =
      match assoc "occurrences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson componentEvidenceOccurrences_of_yojson) v)
    in
    let callstack =
      match assoc "callstack" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (componentEvidenceCallstack_of_yojson v)
    in
    let licenses =
      match assoc "licenses" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (licenseChoice_of_yojson v)
    in
    let copyright =
      match assoc "copyright" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson copyright_of_yojson) v)
    in
    { identity; occurrences; callstack; licenses; copyright }
  | _ -> Atdml_runtime.Yojson.bad_type "componentEvidence" x

let yojson_of_componentEvidence (x : componentEvidence) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.identity with None -> [] | Some v -> [("identity", yojson_of_componentEvidenceIdentity v)]);
    (match x.occurrences with None -> [] | Some v -> [("occurrences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_componentEvidenceOccurrences) v)]);
    (match x.callstack with None -> [] | Some v -> [("callstack", yojson_of_componentEvidenceCallstack v)]);
    (match x.licenses with None -> [] | Some v -> [("licenses", yojson_of_licenseChoice v)]);
    (match x.copyright with None -> [] | Some v -> [("copyright", (Atdml_runtime.Yojson.yojson_of_list yojson_of_copyright) v)]);
  ])

let componentEvidence_of_json s =
  componentEvidence_of_yojson (Yojson.Safe.from_string s)

let json_of_componentEvidence x =
  Yojson.Safe.to_string (yojson_of_componentEvidence x)

module ComponentEvidence = struct
  type nonrec t = componentEvidence
  let create = create_componentEvidence
  let of_yojson = componentEvidence_of_yojson
  let to_yojson = yojson_of_componentEvidence
  let of_json = componentEvidence_of_json
  let to_json = json_of_componentEvidence
end

(** Properties for cryptographic assets of asset type 'certificate' *)
type cryptoPropertiesCertificateProperties = {
  subjectName: string option;  (** The subject name for the certificate *)
  issuerName: string option;  (** The issuer name for the certificate *)
  notValidBefore: string option;
  (**
     The date and time according to ISO-8601 standard from which the
     certificate is valid
  *)
  notValidAfter: string option;
  (**
     The date and time according to ISO-8601 standard from which the
     certificate is not valid anymore
  *)
  signatureAlgorithmRef: refType option;
  subjectPublicKeyRef: refType option;
  certificateFormat: string option;  (** The format of the certificate *)
  certificateExtension: string option;  (** The file extension of the certificate *)
}

let create_cryptoPropertiesCertificateProperties ?subjectName ?issuerName ?notValidBefore ?notValidAfter ?signatureAlgorithmRef ?subjectPublicKeyRef ?certificateFormat ?certificateExtension () : cryptoPropertiesCertificateProperties =
  { subjectName; issuerName; notValidBefore; notValidAfter; signatureAlgorithmRef; subjectPublicKeyRef; certificateFormat; certificateExtension }

let cryptoPropertiesCertificateProperties_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesCertificateProperties =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let subjectName =
      match assoc "subjectName" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let issuerName =
      match assoc "issuerName" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let notValidBefore =
      match assoc "notValidBefore" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let notValidAfter =
      match assoc "notValidAfter" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let signatureAlgorithmRef =
      match assoc "signatureAlgorithmRef" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let subjectPublicKeyRef =
      match assoc "subjectPublicKeyRef" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let certificateFormat =
      match assoc "certificateFormat" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let certificateExtension =
      match assoc "certificateExtension" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { subjectName; issuerName; notValidBefore; notValidAfter; signatureAlgorithmRef; subjectPublicKeyRef; certificateFormat; certificateExtension }
  | _ -> Atdml_runtime.Yojson.bad_type "cryptoPropertiesCertificateProperties" x

let yojson_of_cryptoPropertiesCertificateProperties (x : cryptoPropertiesCertificateProperties) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.subjectName with None -> [] | Some v -> [("subjectName", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.issuerName with None -> [] | Some v -> [("issuerName", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.notValidBefore with None -> [] | Some v -> [("notValidBefore", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.notValidAfter with None -> [] | Some v -> [("notValidAfter", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.signatureAlgorithmRef with None -> [] | Some v -> [("signatureAlgorithmRef", yojson_of_refType v)]);
    (match x.subjectPublicKeyRef with None -> [] | Some v -> [("subjectPublicKeyRef", yojson_of_refType v)]);
    (match x.certificateFormat with None -> [] | Some v -> [("certificateFormat", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.certificateExtension with None -> [] | Some v -> [("certificateExtension", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let cryptoPropertiesCertificateProperties_of_json s =
  cryptoPropertiesCertificateProperties_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesCertificateProperties x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesCertificateProperties x)

module CryptoPropertiesCertificateProperties = struct
  type nonrec t = cryptoPropertiesCertificateProperties
  let create = create_cryptoPropertiesCertificateProperties
  let of_yojson = cryptoPropertiesCertificateProperties_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesCertificateProperties
  let of_json = cryptoPropertiesCertificateProperties_of_json
  let to_json = json_of_cryptoPropertiesCertificateProperties
end

type cryptoRefArray = refType list

let cryptoRefArray_of_yojson (x : Yojson.Safe.t) : cryptoRefArray =
  (Atdml_runtime.Yojson.list_of_yojson refType_of_yojson) x

let yojson_of_cryptoRefArray (x : cryptoRefArray) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_refType) x

let cryptoRefArray_of_json s =
  cryptoRefArray_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoRefArray x =
  Yojson.Safe.to_string (yojson_of_cryptoRefArray x)

module CryptoRefArray = struct
  type nonrec t = cryptoRefArray
  let of_yojson = cryptoRefArray_of_yojson
  let to_yojson = yojson_of_cryptoRefArray
  let of_json = cryptoRefArray_of_json
  let to_json = json_of_cryptoRefArray
end

(**
   The IKEv2 transform types supported (types 1-4), defined in \[RFC 7296
   section 3.3.2\](https://www.ietf.org/rfc/rfc7296.html#section-3.3.2),
   and additional properties.
*)
type cryptoPropertiesProtocolPropertiesIkev2TransformTypes = {
  encr: cryptoRefArray option;
  prf: cryptoRefArray option;
  integ: cryptoRefArray option;
  ke: cryptoRefArray option;
  esn: bool option;  (** Specifies if an Extended Sequence Number (ESN) is used. *)
  auth: cryptoRefArray option;
}

let create_cryptoPropertiesProtocolPropertiesIkev2TransformTypes ?encr ?prf ?integ ?ke ?esn ?auth () : cryptoPropertiesProtocolPropertiesIkev2TransformTypes =
  { encr; prf; integ; ke; esn; auth }

let cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesProtocolPropertiesIkev2TransformTypes =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let encr =
      match assoc "encr" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoRefArray_of_yojson v)
    in
    let prf =
      match assoc "prf" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoRefArray_of_yojson v)
    in
    let integ =
      match assoc "integ" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoRefArray_of_yojson v)
    in
    let ke =
      match assoc "ke" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoRefArray_of_yojson v)
    in
    let esn =
      match assoc "esn" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let auth =
      match assoc "auth" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoRefArray_of_yojson v)
    in
    { encr; prf; integ; ke; esn; auth }
  | _ -> Atdml_runtime.Yojson.bad_type "cryptoPropertiesProtocolPropertiesIkev2TransformTypes" x

let yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes (x : cryptoPropertiesProtocolPropertiesIkev2TransformTypes) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.encr with None -> [] | Some v -> [("encr", yojson_of_cryptoRefArray v)]);
    (match x.prf with None -> [] | Some v -> [("prf", yojson_of_cryptoRefArray v)]);
    (match x.integ with None -> [] | Some v -> [("integ", yojson_of_cryptoRefArray v)]);
    (match x.ke with None -> [] | Some v -> [("ke", yojson_of_cryptoRefArray v)]);
    (match x.esn with None -> [] | Some v -> [("esn", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.auth with None -> [] | Some v -> [("auth", yojson_of_cryptoRefArray v)]);
  ])

let cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_json s =
  cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes x)

module CryptoPropertiesProtocolPropertiesIkev2TransformTypes = struct
  type nonrec t = cryptoPropertiesProtocolPropertiesIkev2TransformTypes
  let create = create_cryptoPropertiesProtocolPropertiesIkev2TransformTypes
  let of_yojson = cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes
  let of_json = cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_json
  let to_json = json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes
end

(** Properties specific to cryptographic assets of type: `protocol`. *)
type cryptoPropertiesProtocolProperties = {
  type_: cryptoPropertiesProtocolPropertiesType option;  (** The concrete protocol type. *)
  version: string option;  (** The version of the protocol. *)
  cipherSuites: cipherSuite list option;  (** A list of cipher suites related to the protocol. *)
  ikev2TransformTypes: cryptoPropertiesProtocolPropertiesIkev2TransformTypes option;
  (**
     The IKEv2 transform types supported (types 1-4), defined in \[RFC 7296
     section 3.3.2\](https://www.ietf.org/rfc/rfc7296.html#section-3.3.2),
     and additional properties.
  *)
  cryptoRefArray: cryptoRefArray option;
}

let create_cryptoPropertiesProtocolProperties ?type_ ?version ?cipherSuites ?ikev2TransformTypes ?cryptoRefArray () : cryptoPropertiesProtocolProperties =
  { type_; version; cipherSuites; ikev2TransformTypes; cryptoRefArray }

let cryptoPropertiesProtocolProperties_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesProtocolProperties =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesProtocolPropertiesType_of_yojson v)
    in
    let version =
      match assoc "version" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let cipherSuites =
      match assoc "cipherSuites" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cipherSuite_of_yojson) v)
    in
    let ikev2TransformTypes =
      match assoc "ikev2TransformTypes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_yojson v)
    in
    let cryptoRefArray =
      match assoc "cryptoRefArray" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoRefArray_of_yojson v)
    in
    { type_; version; cipherSuites; ikev2TransformTypes; cryptoRefArray }
  | _ -> Atdml_runtime.Yojson.bad_type "cryptoPropertiesProtocolProperties" x

let yojson_of_cryptoPropertiesProtocolProperties (x : cryptoPropertiesProtocolProperties) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.type_ with None -> [] | Some v -> [("type", yojson_of_cryptoPropertiesProtocolPropertiesType v)]);
    (match x.version with None -> [] | Some v -> [("version", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.cipherSuites with None -> [] | Some v -> [("cipherSuites", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cipherSuite) v)]);
    (match x.ikev2TransformTypes with None -> [] | Some v -> [("ikev2TransformTypes", yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes v)]);
    (match x.cryptoRefArray with None -> [] | Some v -> [("cryptoRefArray", yojson_of_cryptoRefArray v)]);
  ])

let cryptoPropertiesProtocolProperties_of_json s =
  cryptoPropertiesProtocolProperties_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesProtocolProperties x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesProtocolProperties x)

module CryptoPropertiesProtocolProperties = struct
  type nonrec t = cryptoPropertiesProtocolProperties
  let create = create_cryptoPropertiesProtocolProperties
  let of_yojson = cryptoPropertiesProtocolProperties_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesProtocolProperties
  let of_json = cryptoPropertiesProtocolProperties_of_json
  let to_json = json_of_cryptoPropertiesProtocolProperties
end

type modelCardModelParametersDatasets =
  | ComponentData of componentData
  | DataReference of modelCardModelParametersDatasetsDataReference

let modelCardModelParametersDatasets_of_yojson (x : Yojson.Safe.t) : modelCardModelParametersDatasets =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "ComponentData"; v] -> ComponentData (componentData_of_yojson v)
  | `List [`String "DataReference"; v] -> DataReference (modelCardModelParametersDatasetsDataReference_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "modelCardModelParametersDatasets" x

let yojson_of_modelCardModelParametersDatasets (x : modelCardModelParametersDatasets) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | ComponentData v -> `List [`String "ComponentData"; yojson_of_componentData v]
    | DataReference v -> `List [`String "DataReference"; yojson_of_modelCardModelParametersDatasetsDataReference v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let modelCardModelParametersDatasets_of_json s =
  modelCardModelParametersDatasets_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardModelParametersDatasets x =
  Yojson.Safe.to_string (yojson_of_modelCardModelParametersDatasets x)

module ModelCardModelParametersDatasets = struct
  type nonrec t = modelCardModelParametersDatasets
  let of_yojson = modelCardModelParametersDatasets_of_yojson
  let to_yojson = yojson_of_modelCardModelParametersDatasets
  let of_json = modelCardModelParametersDatasets_of_json
  let to_json = json_of_modelCardModelParametersDatasets
end

(** Hyper-parameters for construction of the model. *)
type modelCardModelParameters = {
  approach: modelCardModelParametersApproach option;
  (**
     The overall approach to learning used by the model for problem
     solving.
  *)
  task: string option;
  (**
     Directly influences the input and/or output. Examples include
     classification, regression, clustering, etc.
  *)
  architectureFamily: string option;
  (**
     The model architecture family such as transformer network,
     convolutional neural network, residual neural network, LSTM neural
     network, etc.
  *)
  modelArchitecture: string option;
  (**
     The specific architecture of the model such as GPT-1, ResNet-50,
     YOLOv3, etc.
  *)
  datasets: modelCardModelParametersDatasets list option;  (** The datasets used to train and evaluate the model. *)
  inputs: inputOutputMLParameters list option;  (** The input format(s) of the model *)
  outputs: inputOutputMLParameters list option;  (** The output format(s) from the model *)
}

let create_modelCardModelParameters ?approach ?task ?architectureFamily ?modelArchitecture ?datasets ?inputs ?outputs () : modelCardModelParameters =
  { approach; task; architectureFamily; modelArchitecture; datasets; inputs; outputs }

let modelCardModelParameters_of_yojson (x : Yojson.Safe.t) : modelCardModelParameters =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let approach =
      match assoc "approach" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (modelCardModelParametersApproach_of_yojson v)
    in
    let task =
      match assoc "task" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let architectureFamily =
      match assoc "architectureFamily" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let modelArchitecture =
      match assoc "modelArchitecture" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let datasets =
      match assoc "datasets" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson modelCardModelParametersDatasets_of_yojson) v)
    in
    let inputs =
      match assoc "inputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson inputOutputMLParameters_of_yojson) v)
    in
    let outputs =
      match assoc "outputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson inputOutputMLParameters_of_yojson) v)
    in
    { approach; task; architectureFamily; modelArchitecture; datasets; inputs; outputs }
  | _ -> Atdml_runtime.Yojson.bad_type "modelCardModelParameters" x

let yojson_of_modelCardModelParameters (x : modelCardModelParameters) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.approach with None -> [] | Some v -> [("approach", yojson_of_modelCardModelParametersApproach v)]);
    (match x.task with None -> [] | Some v -> [("task", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.architectureFamily with None -> [] | Some v -> [("architectureFamily", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.modelArchitecture with None -> [] | Some v -> [("modelArchitecture", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.datasets with None -> [] | Some v -> [("datasets", (Atdml_runtime.Yojson.yojson_of_list yojson_of_modelCardModelParametersDatasets) v)]);
    (match x.inputs with None -> [] | Some v -> [("inputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_inputOutputMLParameters) v)]);
    (match x.outputs with None -> [] | Some v -> [("outputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_inputOutputMLParameters) v)]);
  ])

let modelCardModelParameters_of_json s =
  modelCardModelParameters_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardModelParameters x =
  Yojson.Safe.to_string (yojson_of_modelCardModelParameters x)

module ModelCardModelParameters = struct
  type nonrec t = modelCardModelParameters
  let create = create_modelCardModelParameters
  let of_yojson = modelCardModelParameters_of_yojson
  let to_yojson = yojson_of_modelCardModelParameters
  let of_json = modelCardModelParameters_of_json
  let to_json = json_of_modelCardModelParameters
end

type organizationalContact = {
  bomref: refType option;
  name: string option;  (** The name of a contact *)
  email: string option;  (** The email address of the contact. *)
  phone: string option;  (** The phone number of the contact. *)
}

let create_organizationalContact ?bomref ?name ?email ?phone () : organizationalContact =
  { bomref; name; email; phone }

let organizationalContact_of_yojson (x : Yojson.Safe.t) : organizationalContact =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let email =
      match assoc "email" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let phone =
      match assoc "phone" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { bomref; name; email; phone }
  | _ -> Atdml_runtime.Yojson.bad_type "organizationalContact" x

let yojson_of_organizationalContact (x : organizationalContact) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.email with None -> [] | Some v -> [("email", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.phone with None -> [] | Some v -> [("phone", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let organizationalContact_of_json s =
  organizationalContact_of_yojson (Yojson.Safe.from_string s)

let json_of_organizationalContact x =
  Yojson.Safe.to_string (yojson_of_organizationalContact x)

module OrganizationalContact = struct
  type nonrec t = organizationalContact
  let create = create_organizationalContact
  let of_yojson = organizationalContact_of_yojson
  let to_yojson = yojson_of_organizationalContact
  let of_json = organizationalContact_of_json
  let to_json = json_of_organizationalContact
end

(** An address used to identify a contactable location. *)
type postalAddress = {
  bomref: refType option;
  country: string option;  (** The country name or the two-letter ISO 3166-1 country code. *)
  region: string option;  (** The region or state in the country. *)
  locality: string option;  (** The locality or city within the country. *)
  postOfficeBoxNumber: string option;  (** The post office box number. *)
  postalCode: string option;  (** The postal code. *)
  streetAddress: string option;  (** The street address. *)
}

let create_postalAddress ?bomref ?country ?region ?locality ?postOfficeBoxNumber ?postalCode ?streetAddress () : postalAddress =
  { bomref; country; region; locality; postOfficeBoxNumber; postalCode; streetAddress }

let postalAddress_of_yojson (x : Yojson.Safe.t) : postalAddress =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let country =
      match assoc "country" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let region =
      match assoc "region" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let locality =
      match assoc "locality" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let postOfficeBoxNumber =
      match assoc "postOfficeBoxNumber" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let postalCode =
      match assoc "postalCode" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let streetAddress =
      match assoc "streetAddress" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { bomref; country; region; locality; postOfficeBoxNumber; postalCode; streetAddress }
  | _ -> Atdml_runtime.Yojson.bad_type "postalAddress" x

let yojson_of_postalAddress (x : postalAddress) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.country with None -> [] | Some v -> [("country", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.region with None -> [] | Some v -> [("region", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.locality with None -> [] | Some v -> [("locality", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.postOfficeBoxNumber with None -> [] | Some v -> [("postOfficeBoxNumber", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.postalCode with None -> [] | Some v -> [("postalCode", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.streetAddress with None -> [] | Some v -> [("streetAddress", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let postalAddress_of_json s =
  postalAddress_of_yojson (Yojson.Safe.from_string s)

let json_of_postalAddress x =
  Yojson.Safe.to_string (yojson_of_postalAddress x)

module PostalAddress = struct
  type nonrec t = postalAddress
  let create = create_postalAddress
  let of_yojson = postalAddress_of_yojson
  let to_yojson = yojson_of_postalAddress
  let of_json = postalAddress_of_json
  let to_json = json_of_postalAddress
end

type organizationalEntity = {
  bomref: refType option;
  name: string option;  (** The name of the organization *)
  address: postalAddress option;
  url: string list option;  (** The URL of the organization. Multiple URLs are allowed. *)
  contact: organizationalContact list option;  (** A contact at the organization. Multiple contacts are allowed. *)
}

let create_organizationalEntity ?bomref ?name ?address ?url ?contact () : organizationalEntity =
  { bomref; name; address; url; contact }

let organizationalEntity_of_yojson (x : Yojson.Safe.t) : organizationalEntity =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let address =
      match assoc "address" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (postalAddress_of_yojson v)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let contact =
      match assoc "contact" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson organizationalContact_of_yojson) v)
    in
    { bomref; name; address; url; contact }
  | _ -> Atdml_runtime.Yojson.bad_type "organizationalEntity" x

let yojson_of_organizationalEntity (x : organizationalEntity) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.address with None -> [] | Some v -> [("address", yojson_of_postalAddress v)]);
    (match x.url with None -> [] | Some v -> [("url", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.contact with None -> [] | Some v -> [("contact", (Atdml_runtime.Yojson.yojson_of_list yojson_of_organizationalContact) v)]);
  ])

let organizationalEntity_of_json s =
  organizationalEntity_of_yojson (Yojson.Safe.from_string s)

let json_of_organizationalEntity x =
  Yojson.Safe.to_string (yojson_of_organizationalEntity x)

module OrganizationalEntity = struct
  type nonrec t = organizationalEntity
  let create = create_organizationalEntity
  let of_yojson = organizationalEntity_of_yojson
  let to_yojson = yojson_of_organizationalEntity
  let of_json = organizationalEntity_of_json
  let to_json = json_of_organizationalEntity
end

(**
   Describes the physical provider of energy used for model development
   or operations.
*)
type energyProvider = {
  bomref: refType option;
  description: string option;  (** A description of the energy provider. *)
  organization: organizationalEntity;
  energySource: energyProviderEnergySource;  (** The energy source for the energy provider. *)
  energyProvided: energyMeasure;
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
}

let create_energyProvider ?bomref ?description ~organization ~energySource ~energyProvided ?externalReferences () : energyProvider =
  { bomref; description; organization; energySource; energyProvided; externalReferences }

let energyProvider_of_yojson (x : Yojson.Safe.t) : energyProvider =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let organization =
      match assoc "organization" with
      | Some v -> organizationalEntity_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "energyProvider" "organization"
    in
    let energySource =
      match assoc "energySource" with
      | Some v -> energyProviderEnergySource_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "energyProvider" "energySource"
    in
    let energyProvided =
      match assoc "energyProvided" with
      | Some v -> energyMeasure_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "energyProvider" "energyProvided"
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    { bomref; description; organization; energySource; energyProvided; externalReferences }
  | _ -> Atdml_runtime.Yojson.bad_type "energyProvider" x

let yojson_of_energyProvider (x : energyProvider) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("organization", yojson_of_organizationalEntity x.organization)];
    [("energySource", yojson_of_energyProviderEnergySource x.energySource)];
    [("energyProvided", yojson_of_energyMeasure x.energyProvided)];
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
  ])

let energyProvider_of_json s =
  energyProvider_of_yojson (Yojson.Safe.from_string s)

let json_of_energyProvider x =
  Yojson.Safe.to_string (yojson_of_energyProvider x)

module EnergyProvider = struct
  type nonrec t = energyProvider
  let create = create_energyProvider
  let of_yojson = energyProvider_of_yojson
  let to_yojson = yojson_of_energyProvider
  let of_json = energyProvider_of_json
  let to_json = json_of_energyProvider
end

(**
   Describes energy consumption information incurred for the specified
   lifecycle activity.
*)
type energyConsumption = {
  activity: energyConsumptionActivity;
  (**
     The type of activity that is part of a machine learning model
     development or operational lifecycle.
  *)
  energyProviders: energyProvider list;
  (**
     The provider(s) of the energy consumed by the associated model
     development lifecycle activity.
  *)
  activityEnergyCost: energyMeasure;
  co2CostEquivalent: co2Measure option;
  co2CostOffset: co2Measure option;
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_energyConsumption ~activity ~energyProviders ~activityEnergyCost ?co2CostEquivalent ?co2CostOffset ?properties () : energyConsumption =
  { activity; energyProviders; activityEnergyCost; co2CostEquivalent; co2CostOffset; properties }

let energyConsumption_of_yojson (x : Yojson.Safe.t) : energyConsumption =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let activity =
      match assoc "activity" with
      | Some v -> energyConsumptionActivity_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "energyConsumption" "activity"
    in
    let energyProviders =
      match assoc "energyProviders" with
      | Some v -> (Atdml_runtime.Yojson.list_of_yojson energyProvider_of_yojson) v
      | None -> Atdml_runtime.Yojson.missing_field "energyConsumption" "energyProviders"
    in
    let activityEnergyCost =
      match assoc "activityEnergyCost" with
      | Some v -> energyMeasure_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "energyConsumption" "activityEnergyCost"
    in
    let co2CostEquivalent =
      match assoc "co2CostEquivalent" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (co2Measure_of_yojson v)
    in
    let co2CostOffset =
      match assoc "co2CostOffset" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (co2Measure_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { activity; energyProviders; activityEnergyCost; co2CostEquivalent; co2CostOffset; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "energyConsumption" x

let yojson_of_energyConsumption (x : energyConsumption) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("activity", yojson_of_energyConsumptionActivity x.activity)];
    [("energyProviders", (Atdml_runtime.Yojson.yojson_of_list yojson_of_energyProvider) x.energyProviders)];
    [("activityEnergyCost", yojson_of_energyMeasure x.activityEnergyCost)];
    (match x.co2CostEquivalent with None -> [] | Some v -> [("co2CostEquivalent", yojson_of_co2Measure v)]);
    (match x.co2CostOffset with None -> [] | Some v -> [("co2CostOffset", yojson_of_co2Measure v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let energyConsumption_of_json s =
  energyConsumption_of_yojson (Yojson.Safe.from_string s)

let json_of_energyConsumption x =
  Yojson.Safe.to_string (yojson_of_energyConsumption x)

module EnergyConsumption = struct
  type nonrec t = energyConsumption
  let create = create_energyConsumption
  let of_yojson = energyConsumption_of_yojson
  let to_yojson = yojson_of_energyConsumption
  let of_json = energyConsumption_of_json
  let to_json = json_of_energyConsumption
end

(** Describes various environmental impact metrics. *)
type environmentalConsiderations = {
  energyConsumptions: energyConsumption list option;
  (**
     Describes energy consumption information incurred for one or more
     component lifecycle activities.
  *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_environmentalConsiderations ?energyConsumptions ?properties () : environmentalConsiderations =
  { energyConsumptions; properties }

let environmentalConsiderations_of_yojson (x : Yojson.Safe.t) : environmentalConsiderations =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let energyConsumptions =
      match assoc "energyConsumptions" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson energyConsumption_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { energyConsumptions; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "environmentalConsiderations" x

let yojson_of_environmentalConsiderations (x : environmentalConsiderations) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.energyConsumptions with None -> [] | Some v -> [("energyConsumptions", (Atdml_runtime.Yojson.yojson_of_list yojson_of_energyConsumption) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let environmentalConsiderations_of_json s =
  environmentalConsiderations_of_yojson (Yojson.Safe.from_string s)

let json_of_environmentalConsiderations x =
  Yojson.Safe.to_string (yojson_of_environmentalConsiderations x)

module EnvironmentalConsiderations = struct
  type nonrec t = environmentalConsiderations
  let create = create_environmentalConsiderations
  let of_yojson = environmentalConsiderations_of_yojson
  let to_yojson = yojson_of_environmentalConsiderations
  let of_json = environmentalConsiderations_of_json
  let to_json = json_of_environmentalConsiderations
end

(**
   The software versioning type. It is recommended that the release type
   use one of 'major', 'minor', 'patch', 'pre-release', or 'internal'.
   Representing all possible software release types is not practical, so
   standardizing on the recommended values, whenever possible, is
   strongly encouraged.

   * __major__ = A major release may contain significant changes or may
   introduce breaking changes. * __minor__ = A minor release, also known
   as an update, may contain a smaller number of changes than major
   releases. * __patch__ = Patch releases are typically unplanned and may
   resolve defects or important security issues. * __pre-release__ = A
   pre-release may include alpha, beta, or release candidates and
   typically have limited support. They provide the ability to preview a
   release prior to its general availability. * __internal__ = Internal
   releases are not for public consumption and are intended to be used
   exclusively by the project or manufacturer that produced it.
*)
type releaseType = string

let create_releaseType (x : string) : releaseType = x


let releaseType_of_yojson (x : Yojson.Safe.t) : releaseType =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_releaseType (x : releaseType) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let releaseType_of_json s =
  releaseType_of_yojson (Yojson.Safe.from_string s)

let json_of_releaseType x =
  Yojson.Safe.to_string (yojson_of_releaseType x)

module ReleaseType = struct
  type nonrec t = releaseType
  let create = create_releaseType
  let of_yojson = releaseType_of_yojson
  let to_yojson = yojson_of_releaseType
  let of_json = releaseType_of_json
  let to_json = json_of_releaseType
end

type risk = {
  name: string option;  (** The name of the risk. *)
  mitigationStrategy: string option;  (** Strategy used to address this risk. *)
}

let create_risk ?name ?mitigationStrategy () : risk =
  { name; mitigationStrategy }

let risk_of_yojson (x : Yojson.Safe.t) : risk =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let mitigationStrategy =
      match assoc "mitigationStrategy" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { name; mitigationStrategy }
  | _ -> Atdml_runtime.Yojson.bad_type "risk" x

let yojson_of_risk (x : risk) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.mitigationStrategy with None -> [] | Some v -> [("mitigationStrategy", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let risk_of_json s =
  risk_of_yojson (Yojson.Safe.from_string s)

let json_of_risk x =
  Yojson.Safe.to_string (yojson_of_risk x)

module Risk = struct
  type nonrec t = risk
  let create = create_risk
  let of_yojson = risk_of_yojson
  let to_yojson = yojson_of_risk
  let of_json = risk_of_json
  let to_json = json_of_risk
end

(**
   What considerations should be taken into account regarding the model's
   construction, training, and application?
*)
type modelCardConsiderations = {
  users: string list option;  (** Who are the intended users of the model? *)
  useCases: string list option;  (** What are the intended use cases of the model? *)
  technicalLimitations: string list option;
  (**
     What are the known technical limitations of the model? E.g. What
     kind(s) of data should the model be expected not to perform well on?
     What are the factors that might degrade model performance?
  *)
  performanceTradeoffs: string list option;  (** What are the known tradeoffs in accuracy/performance of the model? *)
  ethicalConsiderations: risk list option;  (** What are the ethical risks involved in the application of this model? *)
  environmentalConsiderations: environmentalConsiderations option;
  fairnessAssessments: fairnessAssessment list option;
  (**
     How does the model affect groups at risk of being systematically
     disadvantaged? What are the harms and benefits to the various affected
     groups?
  *)
}

let create_modelCardConsiderations ?users ?useCases ?technicalLimitations ?performanceTradeoffs ?ethicalConsiderations ?environmentalConsiderations ?fairnessAssessments () : modelCardConsiderations =
  { users; useCases; technicalLimitations; performanceTradeoffs; ethicalConsiderations; environmentalConsiderations; fairnessAssessments }

let modelCardConsiderations_of_yojson (x : Yojson.Safe.t) : modelCardConsiderations =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let users =
      match assoc "users" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let useCases =
      match assoc "useCases" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let technicalLimitations =
      match assoc "technicalLimitations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let performanceTradeoffs =
      match assoc "performanceTradeoffs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let ethicalConsiderations =
      match assoc "ethicalConsiderations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson risk_of_yojson) v)
    in
    let environmentalConsiderations =
      match assoc "environmentalConsiderations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (environmentalConsiderations_of_yojson v)
    in
    let fairnessAssessments =
      match assoc "fairnessAssessments" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson fairnessAssessment_of_yojson) v)
    in
    { users; useCases; technicalLimitations; performanceTradeoffs; ethicalConsiderations; environmentalConsiderations; fairnessAssessments }
  | _ -> Atdml_runtime.Yojson.bad_type "modelCardConsiderations" x

let yojson_of_modelCardConsiderations (x : modelCardConsiderations) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.users with None -> [] | Some v -> [("users", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.useCases with None -> [] | Some v -> [("useCases", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.technicalLimitations with None -> [] | Some v -> [("technicalLimitations", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.performanceTradeoffs with None -> [] | Some v -> [("performanceTradeoffs", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.ethicalConsiderations with None -> [] | Some v -> [("ethicalConsiderations", (Atdml_runtime.Yojson.yojson_of_list yojson_of_risk) v)]);
    (match x.environmentalConsiderations with None -> [] | Some v -> [("environmentalConsiderations", yojson_of_environmentalConsiderations v)]);
    (match x.fairnessAssessments with None -> [] | Some v -> [("fairnessAssessments", (Atdml_runtime.Yojson.yojson_of_list yojson_of_fairnessAssessment) v)]);
  ])

let modelCardConsiderations_of_json s =
  modelCardConsiderations_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCardConsiderations x =
  Yojson.Safe.to_string (yojson_of_modelCardConsiderations x)

module ModelCardConsiderations = struct
  type nonrec t = modelCardConsiderations
  let create = create_modelCardConsiderations
  let of_yojson = modelCardConsiderations_of_yojson
  let to_yojson = yojson_of_modelCardConsiderations
  let of_json = modelCardConsiderations_of_json
  let to_json = json_of_modelCardConsiderations
end

(**
   A model card describes the intended uses of a machine learning model
   and potential limitations, including biases and ethical
   considerations. Model cards typically contain the training parameters,
   which datasets were used to train the model, performance metrics, and
   other relevant data useful for ML transparency. This object SHOULD be
   specified for any component of type `machine-learning-model` and must
   not be specified for other component types.
*)
type modelCard = {
  bomref: refType option;
  modelParameters: modelCardModelParameters option;  (** Hyper-parameters for construction of the model. *)
  quantitativeAnalysis: modelCardQuantitativeAnalysis option;  (** A quantitative analysis of the model *)
  considerations: modelCardConsiderations option;
  (**
     What considerations should be taken into account regarding the model's
     construction, training, and application?
  *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_modelCard ?bomref ?modelParameters ?quantitativeAnalysis ?considerations ?properties () : modelCard =
  { bomref; modelParameters; quantitativeAnalysis; considerations; properties }

let modelCard_of_yojson (x : Yojson.Safe.t) : modelCard =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let modelParameters =
      match assoc "modelParameters" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (modelCardModelParameters_of_yojson v)
    in
    let quantitativeAnalysis =
      match assoc "quantitativeAnalysis" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (modelCardQuantitativeAnalysis_of_yojson v)
    in
    let considerations =
      match assoc "considerations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (modelCardConsiderations_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { bomref; modelParameters; quantitativeAnalysis; considerations; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "modelCard" x

let yojson_of_modelCard (x : modelCard) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.modelParameters with None -> [] | Some v -> [("modelParameters", yojson_of_modelCardModelParameters v)]);
    (match x.quantitativeAnalysis with None -> [] | Some v -> [("quantitativeAnalysis", yojson_of_modelCardQuantitativeAnalysis v)]);
    (match x.considerations with None -> [] | Some v -> [("considerations", yojson_of_modelCardConsiderations v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let modelCard_of_json s =
  modelCard_of_yojson (Yojson.Safe.from_string s)

let json_of_modelCard x =
  Yojson.Safe.to_string (yojson_of_modelCard x)

module ModelCard = struct
  type nonrec t = modelCard
  let create = create_modelCard
  let of_yojson = modelCard_of_yojson
  let to_yojson = yojson_of_modelCard
  let of_json = modelCard_of_json
  let to_json = json_of_modelCard
end

(** Specifies the mechanism by which the cryptographic asset is secured by *)
type securedBy = {
  mechanism: string option;
  (**
     Specifies the mechanism by which the cryptographic asset is secured
     by.
  *)
  algorithmRef: refType option;
}

let create_securedBy ?mechanism ?algorithmRef () : securedBy =
  { mechanism; algorithmRef }

let securedBy_of_yojson (x : Yojson.Safe.t) : securedBy =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let mechanism =
      match assoc "mechanism" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let algorithmRef =
      match assoc "algorithmRef" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    { mechanism; algorithmRef }
  | _ -> Atdml_runtime.Yojson.bad_type "securedBy" x

let yojson_of_securedBy (x : securedBy) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.mechanism with None -> [] | Some v -> [("mechanism", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.algorithmRef with None -> [] | Some v -> [("algorithmRef", yojson_of_refType v)]);
  ])

let securedBy_of_json s =
  securedBy_of_yojson (Yojson.Safe.from_string s)

let json_of_securedBy x =
  Yojson.Safe.to_string (yojson_of_securedBy x)

module SecuredBy = struct
  type nonrec t = securedBy
  let create = create_securedBy
  let of_yojson = securedBy_of_yojson
  let to_yojson = yojson_of_securedBy
  let of_json = securedBy_of_json
  let to_json = json_of_securedBy
end

(**
   Properties for cryptographic assets of asset type:
   `related-crypto-material`
*)
type cryptoPropertiesRelatedCryptoMaterialProperties = {
  type_: cryptoPropertiesRelatedCryptoMaterialPropertiesType option;  (** The type for the related cryptographic material *)
  id: string option;  (** The optional unique identifier for the related cryptographic material. *)
  state: cryptoPropertiesRelatedCryptoMaterialPropertiesState option;  (** The key state as defined by NIST SP 800-57. *)
  algorithmRef: refType option;
  creationDate: string option;
  (**
     The date and time (timestamp) when the related cryptographic material
     was created.
  *)
  activationDate: string option;
  (**
     The date and time (timestamp) when the related cryptographic material
     was activated.
  *)
  updateDate: string option;
  (**
     The date and time (timestamp) when the related cryptographic material
     was updated.
  *)
  expirationDate: string option;
  (**
     The date and time (timestamp) when the related cryptographic material
     expires.
  *)
  value: string option;  (** The associated value of the cryptographic material. *)
  size: int option;  (** The size of the cryptographic asset (in bits). *)
  format: string option;  (** The format of the related cryptographic material (e.g. P8, PEM, DER). *)
  securedBy: securedBy option;
}

let create_cryptoPropertiesRelatedCryptoMaterialProperties ?type_ ?id ?state ?algorithmRef ?creationDate ?activationDate ?updateDate ?expirationDate ?value ?size ?format ?securedBy () : cryptoPropertiesRelatedCryptoMaterialProperties =
  { type_; id; state; algorithmRef; creationDate; activationDate; updateDate; expirationDate; value; size; format; securedBy }

let cryptoPropertiesRelatedCryptoMaterialProperties_of_yojson (x : Yojson.Safe.t) : cryptoPropertiesRelatedCryptoMaterialProperties =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_yojson v)
    in
    let id =
      match assoc "id" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let state =
      match assoc "state" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_yojson v)
    in
    let algorithmRef =
      match assoc "algorithmRef" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let creationDate =
      match assoc "creationDate" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let activationDate =
      match assoc "activationDate" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let updateDate =
      match assoc "updateDate" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let expirationDate =
      match assoc "expirationDate" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let value =
      match assoc "value" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let size =
      match assoc "size" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let format =
      match assoc "format" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let securedBy =
      match assoc "securedBy" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (securedBy_of_yojson v)
    in
    { type_; id; state; algorithmRef; creationDate; activationDate; updateDate; expirationDate; value; size; format; securedBy }
  | _ -> Atdml_runtime.Yojson.bad_type "cryptoPropertiesRelatedCryptoMaterialProperties" x

let yojson_of_cryptoPropertiesRelatedCryptoMaterialProperties (x : cryptoPropertiesRelatedCryptoMaterialProperties) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.type_ with None -> [] | Some v -> [("type", yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType v)]);
    (match x.id with None -> [] | Some v -> [("id", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.state with None -> [] | Some v -> [("state", yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState v)]);
    (match x.algorithmRef with None -> [] | Some v -> [("algorithmRef", yojson_of_refType v)]);
    (match x.creationDate with None -> [] | Some v -> [("creationDate", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.activationDate with None -> [] | Some v -> [("activationDate", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.updateDate with None -> [] | Some v -> [("updateDate", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.expirationDate with None -> [] | Some v -> [("expirationDate", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.value with None -> [] | Some v -> [("value", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.size with None -> [] | Some v -> [("size", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.format with None -> [] | Some v -> [("format", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.securedBy with None -> [] | Some v -> [("securedBy", yojson_of_securedBy v)]);
  ])

let cryptoPropertiesRelatedCryptoMaterialProperties_of_json s =
  cryptoPropertiesRelatedCryptoMaterialProperties_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoPropertiesRelatedCryptoMaterialProperties x =
  Yojson.Safe.to_string (yojson_of_cryptoPropertiesRelatedCryptoMaterialProperties x)

module CryptoPropertiesRelatedCryptoMaterialProperties = struct
  type nonrec t = cryptoPropertiesRelatedCryptoMaterialProperties
  let create = create_cryptoPropertiesRelatedCryptoMaterialProperties
  let of_yojson = cryptoPropertiesRelatedCryptoMaterialProperties_of_yojson
  let to_yojson = yojson_of_cryptoPropertiesRelatedCryptoMaterialProperties
  let of_json = cryptoPropertiesRelatedCryptoMaterialProperties_of_json
  let to_json = json_of_cryptoPropertiesRelatedCryptoMaterialProperties
end

(**
   Cryptographic assets have properties that uniquely define them and
   that make them actionable for further reasoning. As an example, it
   makes a difference if one knows the algorithm family (e.g. AES) or the
   specific variant or instantiation (e.g. AES-128-GCM). This is because
   the security level and the algorithm primitive (authenticated
   encryption) are only defined by the definition of the algorithm
   variant. The presence of a weak cryptographic algorithm like SHA1 vs.
   HMAC-SHA1 also makes a difference.
*)
type cryptoProperties = {
  assetType: cryptoPropertiesAssetType;
  (**
     Cryptographic assets occur in several forms. Algorithms and protocols
     are most commonly implemented in specialized cryptographic libraries.
     They may, however, also be 'hardcoded' in software components.
     Certificates and related cryptographic material like keys, tokens,
     secrets or passwords are other cryptographic assets to be modelled.
  *)
  algorithmProperties: cryptoPropertiesAlgorithmProperties option;  (** Additional properties specific to a cryptographic algorithm. *)
  certificateProperties: cryptoPropertiesCertificateProperties option;  (** Properties for cryptographic assets of asset type 'certificate' *)
  relatedCryptoMaterialProperties: cryptoPropertiesRelatedCryptoMaterialProperties option;
  (**
     Properties for cryptographic assets of asset type:
     `related-crypto-material`
  *)
  protocolProperties: cryptoPropertiesProtocolProperties option;  (** Properties specific to cryptographic assets of type: `protocol`. *)
  oid: string option;  (** The object identifier (OID) of the cryptographic asset. *)
}

let create_cryptoProperties ~assetType ?algorithmProperties ?certificateProperties ?relatedCryptoMaterialProperties ?protocolProperties ?oid () : cryptoProperties =
  { assetType; algorithmProperties; certificateProperties; relatedCryptoMaterialProperties; protocolProperties; oid }

let cryptoProperties_of_yojson (x : Yojson.Safe.t) : cryptoProperties =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let assetType =
      match assoc "assetType" with
      | Some v -> cryptoPropertiesAssetType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "cryptoProperties" "assetType"
    in
    let algorithmProperties =
      match assoc "algorithmProperties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesAlgorithmProperties_of_yojson v)
    in
    let certificateProperties =
      match assoc "certificateProperties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesCertificateProperties_of_yojson v)
    in
    let relatedCryptoMaterialProperties =
      match assoc "relatedCryptoMaterialProperties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesRelatedCryptoMaterialProperties_of_yojson v)
    in
    let protocolProperties =
      match assoc "protocolProperties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoPropertiesProtocolProperties_of_yojson v)
    in
    let oid =
      match assoc "oid" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { assetType; algorithmProperties; certificateProperties; relatedCryptoMaterialProperties; protocolProperties; oid }
  | _ -> Atdml_runtime.Yojson.bad_type "cryptoProperties" x

let yojson_of_cryptoProperties (x : cryptoProperties) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("assetType", yojson_of_cryptoPropertiesAssetType x.assetType)];
    (match x.algorithmProperties with None -> [] | Some v -> [("algorithmProperties", yojson_of_cryptoPropertiesAlgorithmProperties v)]);
    (match x.certificateProperties with None -> [] | Some v -> [("certificateProperties", yojson_of_cryptoPropertiesCertificateProperties v)]);
    (match x.relatedCryptoMaterialProperties with None -> [] | Some v -> [("relatedCryptoMaterialProperties", yojson_of_cryptoPropertiesRelatedCryptoMaterialProperties v)]);
    (match x.protocolProperties with None -> [] | Some v -> [("protocolProperties", yojson_of_cryptoPropertiesProtocolProperties v)]);
    (match x.oid with None -> [] | Some v -> [("oid", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let cryptoProperties_of_json s =
  cryptoProperties_of_yojson (Yojson.Safe.from_string s)

let json_of_cryptoProperties x =
  Yojson.Safe.to_string (yojson_of_cryptoProperties x)

module CryptoProperties = struct
  type nonrec t = cryptoProperties
  let create = create_cryptoProperties
  let of_yojson = cryptoProperties_of_yojson
  let to_yojson = yojson_of_cryptoProperties
  let of_json = cryptoProperties_of_json
  let to_json = json_of_cryptoProperties
end

type serviceDataDestination =
  | String of string
  | BomLinkElementType of bomLinkElementType

let serviceDataDestination_of_yojson (x : Yojson.Safe.t) : serviceDataDestination =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "String"; v] -> String (Atdml_runtime.Yojson.string_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "serviceDataDestination" x

let yojson_of_serviceDataDestination (x : serviceDataDestination) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | String v -> `List [`String "String"; Atdml_runtime.Yojson.yojson_of_string v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let serviceDataDestination_of_json s =
  serviceDataDestination_of_yojson (Yojson.Safe.from_string s)

let json_of_serviceDataDestination x =
  Yojson.Safe.to_string (yojson_of_serviceDataDestination x)

module ServiceDataDestination = struct
  type nonrec t = serviceDataDestination
  let of_yojson = serviceDataDestination_of_yojson
  let to_yojson = yojson_of_serviceDataDestination
  let of_json = serviceDataDestination_of_json
  let to_json = json_of_serviceDataDestination
end

type serviceDataSource =
  | String of string
  | BomLinkElementType of bomLinkElementType

let serviceDataSource_of_yojson (x : Yojson.Safe.t) : serviceDataSource =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "String"; v] -> String (Atdml_runtime.Yojson.string_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "serviceDataSource" x

let yojson_of_serviceDataSource (x : serviceDataSource) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | String v -> `List [`String "String"; Atdml_runtime.Yojson.yojson_of_string v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let serviceDataSource_of_json s =
  serviceDataSource_of_yojson (Yojson.Safe.from_string s)

let json_of_serviceDataSource x =
  Yojson.Safe.to_string (yojson_of_serviceDataSource x)

module ServiceDataSource = struct
  type nonrec t = serviceDataSource
  let of_yojson = serviceDataSource_of_yojson
  let to_yojson = yojson_of_serviceDataSource
  let of_json = serviceDataSource_of_json
  let to_json = json_of_serviceDataSource
end

type serviceData = {
  flow: dataFlowDirection;
  classification: dataClassification;
  name: string option;  (** Name for the defined data *)
  description: string option;  (** Short description of the data content and usage *)
  governance: dataGovernance option;
  source: serviceDataSource list option;
  (**
     The URI, URL, or BOM-Link of the components or services the data came
     in from
  *)
  destination: serviceDataDestination list option;
  (**
     The URI, URL, or BOM-Link of the components or services the data is
     sent to
  *)
}

let create_serviceData ~flow ~classification ?name ?description ?governance ?source ?destination () : serviceData =
  { flow; classification; name; description; governance; source; destination }

let serviceData_of_yojson (x : Yojson.Safe.t) : serviceData =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let flow =
      match assoc "flow" with
      | Some v -> dataFlowDirection_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "serviceData" "flow"
    in
    let classification =
      match assoc "classification" with
      | Some v -> dataClassification_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "serviceData" "classification"
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let governance =
      match assoc "governance" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (dataGovernance_of_yojson v)
    in
    let source =
      match assoc "source" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson serviceDataSource_of_yojson) v)
    in
    let destination =
      match assoc "destination" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson serviceDataDestination_of_yojson) v)
    in
    { flow; classification; name; description; governance; source; destination }
  | _ -> Atdml_runtime.Yojson.bad_type "serviceData" x

let yojson_of_serviceData (x : serviceData) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("flow", yojson_of_dataFlowDirection x.flow)];
    [("classification", yojson_of_dataClassification x.classification)];
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.governance with None -> [] | Some v -> [("governance", yojson_of_dataGovernance v)]);
    (match x.source with None -> [] | Some v -> [("source", (Atdml_runtime.Yojson.yojson_of_list yojson_of_serviceDataSource) v)]);
    (match x.destination with None -> [] | Some v -> [("destination", (Atdml_runtime.Yojson.yojson_of_list yojson_of_serviceDataDestination) v)]);
  ])

let serviceData_of_json s =
  serviceData_of_yojson (Yojson.Safe.from_string s)

let json_of_serviceData x =
  Yojson.Safe.to_string (yojson_of_serviceData x)

module ServiceData = struct
  type nonrec t = serviceData
  let create = create_serviceData
  let of_yojson = serviceData_of_yojson
  let to_yojson = yojson_of_serviceData
  let of_json = serviceData_of_json
  let to_json = json_of_serviceData
end

(**
   Enveloped signature in \[JSON Signature Format
   (JSF)\](https://cyberphone.github.io/doc/security/jsf.html).
*)
type signature = json_

let signature_of_yojson (x : Yojson.Safe.t) : signature =
  json__of_yojson x

let yojson_of_signature (x : signature) : Yojson.Safe.t =
  yojson_of_json_ x

let signature_of_json s =
  signature_of_yojson (Yojson.Safe.from_string s)

let json_of_signature x =
  Yojson.Safe.to_string (yojson_of_signature x)

module Signature = struct
  type nonrec t = signature
  let of_yojson = signature_of_yojson
  let to_yojson = yojson_of_signature
  let of_json = signature_of_json
  let to_json = json_of_signature
end

(**
   Specifies metadata and content for ISO-IEC 19770-2 Software
   Identification (SWID) Tags.
*)
type swid = {
  tagId: string;  (** Maps to the tagId of a SoftwareIdentity. *)
  name: string;  (** Maps to the name of a SoftwareIdentity. *)
  version: string;  (** Maps to the version of a SoftwareIdentity. *)
  tagVersion: int;  (** Maps to the tagVersion of a SoftwareIdentity. *)
  patch: bool;  (** Maps to the patch of a SoftwareIdentity. *)
  text: attachment option;
  url: string option;  (** The URL to the SWID file. *)
}

let create_swid ~tagId ~name ?(version = "0.0") ?(tagVersion = 0) ?(patch = false) ?text ?url () : swid =
  { tagId; name; version; tagVersion; patch; text; url }

let swid_of_yojson (x : Yojson.Safe.t) : swid =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let tagId =
      match assoc "tagId" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "swid" "tagId"
    in
    let name =
      match assoc "name" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "swid" "name"
    in
    let version =
      match assoc "version" with
      | None -> "0.0"
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
    in
    let tagVersion =
      match assoc "tagVersion" with
      | None -> 0
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
    in
    let patch =
      match assoc "patch" with
      | None -> false
      | Some v -> Atdml_runtime.Yojson.bool_of_yojson v
    in
    let text =
      match assoc "text" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (attachment_of_yojson v)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { tagId; name; version; tagVersion; patch; text; url }
  | _ -> Atdml_runtime.Yojson.bad_type "swid" x

let yojson_of_swid (x : swid) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("tagId", Atdml_runtime.Yojson.yojson_of_string x.tagId)];
    [("name", Atdml_runtime.Yojson.yojson_of_string x.name)];
    [("version", Atdml_runtime.Yojson.yojson_of_string x.version)];
    [("tagVersion", Atdml_runtime.Yojson.yojson_of_int x.tagVersion)];
    [("patch", Atdml_runtime.Yojson.yojson_of_bool x.patch)];
    (match x.text with None -> [] | Some v -> [("text", yojson_of_attachment v)]);
    (match x.url with None -> [] | Some v -> [("url", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let swid_of_json s =
  swid_of_yojson (Yojson.Safe.from_string s)

let json_of_swid x =
  Yojson.Safe.to_string (yojson_of_swid x)

module Swid = struct
  type nonrec t = swid
  let create = create_swid
  let of_yojson = swid_of_yojson
  let to_yojson = yojson_of_swid
  let of_json = swid_of_json
  let to_json = json_of_swid
end

(**
   Textual strings that aid in discovery, search, and retrieval of the
   associated object. Tags often serve as a way to group or categorize
   similar or related objects by various attributes.
*)
type tags = string list

let tags_of_yojson (x : Yojson.Safe.t) : tags =
  (Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) x

let yojson_of_tags (x : tags) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) x

let tags_of_json s =
  tags_of_yojson (Yojson.Safe.from_string s)

let json_of_tags x =
  Yojson.Safe.to_string (yojson_of_tags x)

module Tags = struct
  type nonrec t = tags
  let of_yojson = tags_of_yojson
  let to_yojson = yojson_of_tags
  let of_json = tags_of_json
  let to_json = json_of_tags
end

type releaseNotes = {
  type_: releaseType;
  title: string option;  (** The title of the release. *)
  featuredImage: string option;
  (**
     The URL to an image that may be prominently displayed with the release
     note.
  *)
  socialImage: string option;
  (**
     The URL to an image that may be used in messaging on social media
     platforms.
  *)
  description: string option;  (** A short description of the release. *)
  timestamp: string option;  (** The date and time (timestamp) when the release note was created. *)
  aliases: string list option;
  (**
     One or more alternate names the release may be referred to. This may
     include unofficial terms used by development and marketing teams (e.g.
     code names).
  *)
  tags: tags option;
  resolves: issue list option;  (** A collection of issues that have been resolved. *)
  notes: note list option;
  (**
     Zero or more release notes containing the locale and content. Multiple
     note objects may be specified to support release notes in a wide
     variety of languages.
  *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_releaseNotes ~type_ ?title ?featuredImage ?socialImage ?description ?timestamp ?aliases ?tags ?resolves ?notes ?properties () : releaseNotes =
  { type_; title; featuredImage; socialImage; description; timestamp; aliases; tags; resolves; notes; properties }

let releaseNotes_of_yojson (x : Yojson.Safe.t) : releaseNotes =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | Some v -> releaseType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "releaseNotes" "type"
    in
    let title =
      match assoc "title" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let featuredImage =
      match assoc "featuredImage" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let socialImage =
      match assoc "socialImage" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let timestamp =
      match assoc "timestamp" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let aliases =
      match assoc "aliases" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let tags =
      match assoc "tags" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (tags_of_yojson v)
    in
    let resolves =
      match assoc "resolves" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson issue_of_yojson) v)
    in
    let notes =
      match assoc "notes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson note_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { type_; title; featuredImage; socialImage; description; timestamp; aliases; tags; resolves; notes; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "releaseNotes" x

let yojson_of_releaseNotes (x : releaseNotes) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("type", yojson_of_releaseType x.type_)];
    (match x.title with None -> [] | Some v -> [("title", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.featuredImage with None -> [] | Some v -> [("featuredImage", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.socialImage with None -> [] | Some v -> [("socialImage", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.timestamp with None -> [] | Some v -> [("timestamp", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.aliases with None -> [] | Some v -> [("aliases", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.tags with None -> [] | Some v -> [("tags", yojson_of_tags v)]);
    (match x.resolves with None -> [] | Some v -> [("resolves", (Atdml_runtime.Yojson.yojson_of_list yojson_of_issue) v)]);
    (match x.notes with None -> [] | Some v -> [("notes", (Atdml_runtime.Yojson.yojson_of_list yojson_of_note) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let releaseNotes_of_json s =
  releaseNotes_of_yojson (Yojson.Safe.from_string s)

let json_of_releaseNotes x =
  Yojson.Safe.to_string (yojson_of_releaseNotes x)

module ReleaseNotes = struct
  type nonrec t = releaseNotes
  let create = create_releaseNotes
  let of_yojson = releaseNotes_of_yojson
  let to_yojson = yojson_of_releaseNotes
  let of_json = releaseNotes_of_json
  let to_json = json_of_releaseNotes
end

(** A single disjunctive version identifier, for a component or service. *)
type version = string

let create_version (x : string) : version = x


let version_of_yojson (x : Yojson.Safe.t) : version =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_version (x : version) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let version_of_json s =
  version_of_yojson (Yojson.Safe.from_string s)

let json_of_version x =
  Yojson.Safe.to_string (yojson_of_version x)

module Version = struct
  type nonrec t = version
  let create = create_version
  let of_yojson = version_of_yojson
  let to_yojson = yojson_of_version
  let of_json = version_of_json
  let to_json = json_of_version
end

type service = {
  bomref: refType option;
  provider: organizationalEntity option;
  group: string option;
  (**
     The grouping name, namespace, or identifier. This will often be a
     shortened, single name of the company or project that produced the
     service or domain name. Whitespace and special characters should be
     avoided.
  *)
  name: string;
  (**
     The name of the service. This will often be a shortened, single name
     of the service.
  *)
  version: version option;
  description: string option;  (** Specifies a description for the service *)
  endpoints: string list option;  (** The endpoint URIs of the service. Multiple endpoints are allowed. *)
  authenticated: bool option;
  (**
     A boolean value indicating if the service requires authentication. A
     value of true indicates the service requires authentication prior to
     use. A value of false indicates the service does not require
     authentication.
  *)
  xtrustboundary: bool option;
  (**
     A boolean value indicating if use of the service crosses a trust zone
     or boundary. A value of true indicates that by using the service, a
     trust boundary is crossed. A value of false indicates that by using
     the service, a trust boundary is not crossed.
  *)
  trustZone: string option;  (** The name of the trust zone the service resides in. *)
  data: serviceData list option;
  (**
     Specifies information about the data including the directional flow of
     data and the data classification.
  *)
  licenses: licenseChoice option;
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
  services: service list option;
  (**
     A list of services included or deployed behind the parent service.
     This is not a dependency tree. It provides a way to specify a
     hierarchical representation of service assemblies.
  *)
  releaseNotes: releaseNotes option;
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
  tags: tags option;
  signature: signature option;
}

let create_service ?bomref ?provider ?group ~name ?version ?description ?endpoints ?authenticated ?xtrustboundary ?trustZone ?data ?licenses ?externalReferences ?services ?releaseNotes ?properties ?tags ?signature () : service =
  { bomref; provider; group; name; version; description; endpoints; authenticated; xtrustboundary; trustZone; data; licenses; externalReferences; services; releaseNotes; properties; tags; signature }

let rec service_of_yojson (x : Yojson.Safe.t) : service =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let provider =
      match assoc "provider" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalEntity_of_yojson v)
    in
    let group =
      match assoc "group" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let name =
      match assoc "name" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "service" "name"
    in
    let version =
      match assoc "version" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (version_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let endpoints =
      match assoc "endpoints" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let authenticated =
      match assoc "authenticated" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let xtrustboundary =
      match assoc "x-trust-boundary" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let trustZone =
      match assoc "trustZone" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let data =
      match assoc "data" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson serviceData_of_yojson) v)
    in
    let licenses =
      match assoc "licenses" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (licenseChoice_of_yojson v)
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    let services =
      match assoc "services" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson service_of_yojson) v)
    in
    let releaseNotes =
      match assoc "releaseNotes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (releaseNotes_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    let tags =
      match assoc "tags" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (tags_of_yojson v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { bomref; provider; group; name; version; description; endpoints; authenticated; xtrustboundary; trustZone; data; licenses; externalReferences; services; releaseNotes; properties; tags; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "service" x

let rec yojson_of_service (x : service) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.provider with None -> [] | Some v -> [("provider", yojson_of_organizationalEntity v)]);
    (match x.group with None -> [] | Some v -> [("group", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("name", Atdml_runtime.Yojson.yojson_of_string x.name)];
    (match x.version with None -> [] | Some v -> [("version", yojson_of_version v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.endpoints with None -> [] | Some v -> [("endpoints", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.authenticated with None -> [] | Some v -> [("authenticated", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.xtrustboundary with None -> [] | Some v -> [("x-trust-boundary", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.trustZone with None -> [] | Some v -> [("trustZone", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.data with None -> [] | Some v -> [("data", (Atdml_runtime.Yojson.yojson_of_list yojson_of_serviceData) v)]);
    (match x.licenses with None -> [] | Some v -> [("licenses", yojson_of_licenseChoice v)]);
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
    (match x.services with None -> [] | Some v -> [("services", (Atdml_runtime.Yojson.yojson_of_list yojson_of_service) v)]);
    (match x.releaseNotes with None -> [] | Some v -> [("releaseNotes", yojson_of_releaseNotes v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
    (match x.tags with None -> [] | Some v -> [("tags", yojson_of_tags v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let service_of_json s =
  service_of_yojson (Yojson.Safe.from_string s)

let json_of_service x =
  Yojson.Safe.to_string (yojson_of_service x)

module Service = struct
  type nonrec t = service
  let create = create_service
  let of_yojson = service_of_yojson
  let to_yojson = yojson_of_service
  let of_json = service_of_json
  let to_json = json_of_service
end

type component = {
  type_: componentType;
  (**
     Specifies the type of component. For software components, classify as
     application if no more specific appropriate classification is
     available or cannot be determined for the component.
  *)
  mimetype: string option;
  (**
     The optional mime-type of the component. When used on file components,
     the mime-type can provide additional context about the kind of file
     being represented, such as an image, font, or executable. Some library
     or framework components may also have an associated mime-type.
  *)
  bomref: refType option;
  supplier: organizationalEntity option;
  manufacturer: organizationalEntity option;
  authors: organizationalContact list option;
  (**
     The person(s) who created the component. Authors are common in
     components created through manual processes. Components created
     through automated means may have `\@.manufacturer` instead.
  *)
  author: string option;
  (**
     \[Deprecated\] This will be removed in a future version. Use
     `\@.authors` or `\@.manufacturer` instead. The person(s) or
     organization(s) that authored the component
  *)
  publisher: string option;  (** The person(s) or organization(s) that published the component *)
  group: string option;
  (**
     The grouping name or identifier. This will often be a shortened,
     single name of the company or project that produced the component, or
     the source package or domain name. Whitespace and special characters
     should be avoided. Examples include: apache, org.apache.commons, and
     apache.org.
  *)
  name: string;
  (**
     The name of the component. This will often be a shortened, single name
     of the component. Examples: commons-lang3 and jquery
  *)
  version: version option;
  description: string option;  (** Specifies a description for the component *)
  scope: componentScope;
  (**
     Specifies the scope of the component. If scope is not specified,
     'required' scope SHOULD be assumed by the consumer of the BOM.
  *)
  hashes: hash list option;  (** The hashes of the component. *)
  licenses: licenseChoice option;
  copyright: string option;
  (**
     A copyright notice informing users of the underlying claims to
     copyright ownership in a published work.
  *)
  cpe: string option;
  (**
     Asserts the identity of the component using CPE. The CPE must conform
     to the CPE 2.2 or 2.3 specification. See
     \[https://nvd.nist.gov/products/cpe\](https://nvd.nist.gov/products/cpe).
     Refer to `\@.evidence.identity` to optionally provide evidence that
     substantiates the assertion of the component's identity.
  *)
  purl: string option;
  (**
     Asserts the identity of the component using package-url (purl). The
     purl, if specified, must be valid and conform to the specification
     defined at:
     \[https://github.com/package-url/purl-spec\](https://github.com/package-url/purl-spec).
     Refer to `\@.evidence.identity` to optionally provide evidence that
     substantiates the assertion of the component's identity.
  *)
  omniborId: string list option;
  (**
     Asserts the identity of the component using the OmniBOR Artifact ID.
     The OmniBOR, if specified, must be valid and conform to the
     specification defined at:
     \[https://www.iana.org/assignments/uri-schemes/prov/gitoid\](https://www.iana.org/assignments/uri-schemes/prov/gitoid).
     Refer to `\@.evidence.identity` to optionally provide evidence that
     substantiates the assertion of the component's identity.
  *)
  swhid: string list option;
  (**
     Asserts the identity of the component using the Software Heritage
     persistent identifier (SWHID). The SWHID, if specified, must be valid
     and conform to the specification defined at:
     \[https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html\](https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html).
     Refer to `\@.evidence.identity` to optionally provide evidence that
     substantiates the assertion of the component's identity.
  *)
  swid: swid option;
  modified: bool option;
  (**
     \[Deprecated\] This will be removed in a future version. Use the
     pedigree element instead to supply information on exactly how the
     component was modified. A boolean value indicating if the component
     has been modified from the original. A value of true indicates the
     component is a derivative of the original. A value of false indicates
     the component has not been modified from the original.
  *)
  pedigree: componentPedigree option;
  (**
     Component pedigree is a way to document complex supply chain scenarios
     where components are created, distributed, modified, redistributed,
     combined with other components, etc. Pedigree supports viewing this
     complex chain from the beginning, the end, or anywhere in the middle.
     It also provides a way to document variants where the exact relation
     may not be known.
  *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
  components: component list option;
  (**
     A list of software and hardware components included in the parent
     component. This is not a dependency tree. It provides a way to specify
     a hierarchical representation of component assemblies, similar to
     system &#8594; subsystem &#8594; parts assembly in physical supply
     chains.
  *)
  evidence: componentEvidence option;
  releaseNotes: releaseNotes option;
  modelCard: modelCard option;
  data: componentData list option;
  (**
     This object SHOULD be specified for any component of type `data` and
     must not be specified for other component types.
  *)
  cryptoProperties: cryptoProperties option;
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
  tags: tags option;
  signature: signature option;
}

(**
   Component pedigree is a way to document complex supply chain scenarios
   where components are created, distributed, modified, redistributed,
   combined with other components, etc. Pedigree supports viewing this
   complex chain from the beginning, the end, or anywhere in the middle.
   It also provides a way to document variants where the exact relation
   may not be known.
*)
and componentPedigree = {
  ancestors: component list option;
  (**
     Describes zero or more components in which a component is derived
     from. This is commonly used to describe forks from existing projects
     where the forked version contains a ancestor node containing the
     original component it was forked from. For example, Component A is the
     original component. Component B is the component being used and
     documented in the BOM. However, Component B contains a pedigree node
     with a single ancestor documenting Component A - the original
     component from which Component B is derived from.
  *)
  descendants: component list option;
  (**
     Descendants are the exact opposite of ancestors. This provides a way
     to document all forks (and their forks) of an original or root
     component.
  *)
  variants: component list option;
  (**
     Variants describe relations where the relationship between the
     components is not known. For example, if Component A contains nearly
     identical code to Component B. They are both related, but it is
     unclear if one is derived from the other, or if they share a common
     ancestor.
  *)
  commits: commit list option;
  (**
     A list of zero or more commits which provide a trail describing how
     the component deviates from an ancestor, descendant, or variant.
  *)
  patches: patch list option;
  (**
     >A list of zero or more patches describing how the component deviates
     from an ancestor, descendant, or variant. Patches may be complementary
     to commits or may be used in place of commits.
  *)
  notes: string option;
  (**
     Notes, observations, and other non-structured commentary describing
     the components pedigree.
  *)
}

let create_component ~type_ ?mimetype ?bomref ?supplier ?manufacturer ?authors ?author ?publisher ?group ~name ?version ?description ?(scope = Required) ?hashes ?licenses ?copyright ?cpe ?purl ?omniborId ?swhid ?swid ?modified ?pedigree ?externalReferences ?components ?evidence ?releaseNotes ?modelCard ?data ?cryptoProperties ?properties ?tags ?signature () : component =
  { type_; mimetype; bomref; supplier; manufacturer; authors; author; publisher; group; name; version; description; scope; hashes; licenses; copyright; cpe; purl; omniborId; swhid; swid; modified; pedigree; externalReferences; components; evidence; releaseNotes; modelCard; data; cryptoProperties; properties; tags; signature }

let create_componentPedigree ?ancestors ?descendants ?variants ?commits ?patches ?notes () : componentPedigree =
  { ancestors; descendants; variants; commits; patches; notes }

let rec component_of_yojson (x : Yojson.Safe.t) : component =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let type_ =
      match assoc "type" with
      | Some v -> componentType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "component" "type"
    in
    let mimetype =
      match assoc "mime-type" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let supplier =
      match assoc "supplier" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalEntity_of_yojson v)
    in
    let manufacturer =
      match assoc "manufacturer" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalEntity_of_yojson v)
    in
    let authors =
      match assoc "authors" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson organizationalContact_of_yojson) v)
    in
    let author =
      match assoc "author" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let publisher =
      match assoc "publisher" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let group =
      match assoc "group" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let name =
      match assoc "name" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "component" "name"
    in
    let version =
      match assoc "version" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (version_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let scope =
      match assoc "scope" with
      | None -> Required
      | Some v -> componentScope_of_yojson v
    in
    let hashes =
      match assoc "hashes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson hash_of_yojson) v)
    in
    let licenses =
      match assoc "licenses" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (licenseChoice_of_yojson v)
    in
    let copyright =
      match assoc "copyright" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let cpe =
      match assoc "cpe" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let purl =
      match assoc "purl" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let omniborId =
      match assoc "omniborId" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let swhid =
      match assoc "swhid" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let swid =
      match assoc "swid" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (swid_of_yojson v)
    in
    let modified =
      match assoc "modified" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let pedigree =
      match assoc "pedigree" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (componentPedigree_of_yojson v)
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    let components =
      match assoc "components" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let evidence =
      match assoc "evidence" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (componentEvidence_of_yojson v)
    in
    let releaseNotes =
      match assoc "releaseNotes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (releaseNotes_of_yojson v)
    in
    let modelCard =
      match assoc "modelCard" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (modelCard_of_yojson v)
    in
    let data =
      match assoc "data" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson componentData_of_yojson) v)
    in
    let cryptoProperties =
      match assoc "cryptoProperties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cryptoProperties_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    let tags =
      match assoc "tags" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (tags_of_yojson v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { type_; mimetype; bomref; supplier; manufacturer; authors; author; publisher; group; name; version; description; scope; hashes; licenses; copyright; cpe; purl; omniborId; swhid; swid; modified; pedigree; externalReferences; components; evidence; releaseNotes; modelCard; data; cryptoProperties; properties; tags; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "component" x

and componentPedigree_of_yojson (x : Yojson.Safe.t) : componentPedigree =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let ancestors =
      match assoc "ancestors" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let descendants =
      match assoc "descendants" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let variants =
      match assoc "variants" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let commits =
      match assoc "commits" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson commit_of_yojson) v)
    in
    let patches =
      match assoc "patches" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson patch_of_yojson) v)
    in
    let notes =
      match assoc "notes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { ancestors; descendants; variants; commits; patches; notes }
  | _ -> Atdml_runtime.Yojson.bad_type "componentPedigree" x

let rec yojson_of_component (x : component) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("type", yojson_of_componentType x.type_)];
    (match x.mimetype with None -> [] | Some v -> [("mime-type", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.supplier with None -> [] | Some v -> [("supplier", yojson_of_organizationalEntity v)]);
    (match x.manufacturer with None -> [] | Some v -> [("manufacturer", yojson_of_organizationalEntity v)]);
    (match x.authors with None -> [] | Some v -> [("authors", (Atdml_runtime.Yojson.yojson_of_list yojson_of_organizationalContact) v)]);
    (match x.author with None -> [] | Some v -> [("author", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.publisher with None -> [] | Some v -> [("publisher", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.group with None -> [] | Some v -> [("group", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("name", Atdml_runtime.Yojson.yojson_of_string x.name)];
    (match x.version with None -> [] | Some v -> [("version", yojson_of_version v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("scope", yojson_of_componentScope x.scope)];
    (match x.hashes with None -> [] | Some v -> [("hashes", (Atdml_runtime.Yojson.yojson_of_list yojson_of_hash) v)]);
    (match x.licenses with None -> [] | Some v -> [("licenses", yojson_of_licenseChoice v)]);
    (match x.copyright with None -> [] | Some v -> [("copyright", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.cpe with None -> [] | Some v -> [("cpe", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.purl with None -> [] | Some v -> [("purl", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.omniborId with None -> [] | Some v -> [("omniborId", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.swhid with None -> [] | Some v -> [("swhid", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.swid with None -> [] | Some v -> [("swid", yojson_of_swid v)]);
    (match x.modified with None -> [] | Some v -> [("modified", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.pedigree with None -> [] | Some v -> [("pedigree", yojson_of_componentPedigree v)]);
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
    (match x.components with None -> [] | Some v -> [("components", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.evidence with None -> [] | Some v -> [("evidence", yojson_of_componentEvidence v)]);
    (match x.releaseNotes with None -> [] | Some v -> [("releaseNotes", yojson_of_releaseNotes v)]);
    (match x.modelCard with None -> [] | Some v -> [("modelCard", yojson_of_modelCard v)]);
    (match x.data with None -> [] | Some v -> [("data", (Atdml_runtime.Yojson.yojson_of_list yojson_of_componentData) v)]);
    (match x.cryptoProperties with None -> [] | Some v -> [("cryptoProperties", yojson_of_cryptoProperties v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
    (match x.tags with None -> [] | Some v -> [("tags", yojson_of_tags v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

and yojson_of_componentPedigree (x : componentPedigree) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.ancestors with None -> [] | Some v -> [("ancestors", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.descendants with None -> [] | Some v -> [("descendants", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.variants with None -> [] | Some v -> [("variants", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.commits with None -> [] | Some v -> [("commits", (Atdml_runtime.Yojson.yojson_of_list yojson_of_commit) v)]);
    (match x.patches with None -> [] | Some v -> [("patches", (Atdml_runtime.Yojson.yojson_of_list yojson_of_patch) v)]);
    (match x.notes with None -> [] | Some v -> [("notes", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let component_of_json s =
  component_of_yojson (Yojson.Safe.from_string s)

let json_of_component x =
  Yojson.Safe.to_string (yojson_of_component x)

let componentPedigree_of_json s =
  componentPedigree_of_yojson (Yojson.Safe.from_string s)

let json_of_componentPedigree x =
  Yojson.Safe.to_string (yojson_of_componentPedigree x)

module Component = struct
  type nonrec t = component
  let create = create_component
  let of_yojson = component_of_yojson
  let to_yojson = yojson_of_component
  let of_json = component_of_json
  let to_json = json_of_component
end

module ComponentPedigree = struct
  type nonrec t = componentPedigree
  let create = create_componentPedigree
  let of_yojson = componentPedigree_of_yojson
  let to_yojson = yojson_of_componentPedigree
  let of_json = componentPedigree_of_json
  let to_json = json_of_componentPedigree
end

(**
   Describes the read-write access control for the workspace relative to
   the owning resource instance.
*)
type workspaceAccessMode =
  | Readonly
  | Readwrite
  | Readwriteonce
  | Writeonce
  | Writeonly

let workspaceAccessMode_of_yojson (x : Yojson.Safe.t) : workspaceAccessMode =
  match x with
  | `String "read-only" -> Readonly
  | `String "read-write" -> Readwrite
  | `String "read-write-once" -> Readwriteonce
  | `String "write-once" -> Writeonce
  | `String "write-only" -> Writeonly
  | _ -> Atdml_runtime.Yojson.bad_sum "workspaceAccessMode" x

let yojson_of_workspaceAccessMode (x : workspaceAccessMode) : Yojson.Safe.t =
  match x with
  | Readonly -> `String "read-only"
  | Readwrite -> `String "read-write"
  | Readwriteonce -> `String "read-write-once"
  | Writeonce -> `String "write-once"
  | Writeonly -> `String "write-only"

let workspaceAccessMode_of_json s =
  workspaceAccessMode_of_yojson (Yojson.Safe.from_string s)

let json_of_workspaceAccessMode x =
  Yojson.Safe.to_string (yojson_of_workspaceAccessMode x)

module WorkspaceAccessMode = struct
  type nonrec t = workspaceAccessMode
  let of_yojson = workspaceAccessMode_of_yojson
  let to_yojson = yojson_of_workspaceAccessMode
  let of_json = workspaceAccessMode_of_json
  let to_json = json_of_workspaceAccessMode
end

(** The mode for the volume instance. *)
type volumeMode =
  | Filesystem
  | Block

let volumeMode_of_yojson (x : Yojson.Safe.t) : volumeMode =
  match x with
  | `String "filesystem" -> Filesystem
  | `String "block" -> Block
  | _ -> Atdml_runtime.Yojson.bad_sum "volumeMode" x

let yojson_of_volumeMode (x : volumeMode) : Yojson.Safe.t =
  match x with
  | Filesystem -> `String "filesystem"
  | Block -> `String "block"

let volumeMode_of_json s =
  volumeMode_of_yojson (Yojson.Safe.from_string s)

let json_of_volumeMode x =
  Yojson.Safe.to_string (yojson_of_volumeMode x)

module VolumeMode = struct
  type nonrec t = volumeMode
  let of_yojson = volumeMode_of_yojson
  let to_yojson = yojson_of_volumeMode
  let of_json = volumeMode_of_json
  let to_json = json_of_volumeMode
end

(**
   An identifiable, logical unit of data storage tied to a physical
   device.
*)
type volume = {
  uid: string option;
  (**
     The unique identifier for the volume instance within its deployment
     context.
  *)
  name: string option;  (** The name of the volume instance *)
  mode: volumeMode;  (** The mode for the volume instance. *)
  path: string option;  (** The underlying path created from the actual volume. *)
  sizeAllocated: string option;
  (**
     The allocated size of the volume accessible to the associated
     workspace. This should include the scalar size as well as IEC standard
     unit in either decimal or binary form.
  *)
  persistent: bool option;
  (**
     Indicates if the volume persists beyond the life of the resource it is
     associated with.
  *)
  remote: bool option;  (** Indicates if the volume is remotely (i.e., network) attached. *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_volume ?uid ?name ?(mode = Filesystem) ?path ?sizeAllocated ?persistent ?remote ?properties () : volume =
  { uid; name; mode; path; sizeAllocated; persistent; remote; properties }

let volume_of_yojson (x : Yojson.Safe.t) : volume =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let uid =
      match assoc "uid" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let mode =
      match assoc "mode" with
      | None -> Filesystem
      | Some v -> volumeMode_of_yojson v
    in
    let path =
      match assoc "path" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let sizeAllocated =
      match assoc "sizeAllocated" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let persistent =
      match assoc "persistent" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let remote =
      match assoc "remote" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { uid; name; mode; path; sizeAllocated; persistent; remote; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "volume" x

let yojson_of_volume (x : volume) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.uid with None -> [] | Some v -> [("uid", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("mode", yojson_of_volumeMode x.mode)];
    (match x.path with None -> [] | Some v -> [("path", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.sizeAllocated with None -> [] | Some v -> [("sizeAllocated", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.persistent with None -> [] | Some v -> [("persistent", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.remote with None -> [] | Some v -> [("remote", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let volume_of_json s =
  volume_of_yojson (Yojson.Safe.from_string s)

let json_of_volume x =
  Yojson.Safe.to_string (yojson_of_volume x)

module Volume = struct
  type nonrec t = volume
  let create = create_volume
  let of_yojson = volume_of_yojson
  let to_yojson = yojson_of_volume
  let of_json = volume_of_json
  let to_json = json_of_volume
end

(**
   A reference to a locally defined resource (e.g., a bom-ref) or an
   externally accessible resource.
*)
type resourceReferenceChoice =
  | JsonresourceReferenceChoice_1 of json_
  | JsonresourceReferenceChoice_2 of json_

let resourceReferenceChoice_of_yojson (x : Yojson.Safe.t) : resourceReferenceChoice =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "JsonresourceReferenceChoice_1"; v] -> JsonresourceReferenceChoice_1 (json__of_yojson v)
  | `List [`String "JsonresourceReferenceChoice_2"; v] -> JsonresourceReferenceChoice_2 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "resourceReferenceChoice" x

let yojson_of_resourceReferenceChoice (x : resourceReferenceChoice) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | JsonresourceReferenceChoice_1 v -> `List [`String "JsonresourceReferenceChoice_1"; yojson_of_json_ v]
    | JsonresourceReferenceChoice_2 v -> `List [`String "JsonresourceReferenceChoice_2"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let resourceReferenceChoice_of_json s =
  resourceReferenceChoice_of_yojson (Yojson.Safe.from_string s)

let json_of_resourceReferenceChoice x =
  Yojson.Safe.to_string (yojson_of_resourceReferenceChoice x)

module ResourceReferenceChoice = struct
  type nonrec t = resourceReferenceChoice
  let of_yojson = resourceReferenceChoice_of_yojson
  let to_yojson = yojson_of_resourceReferenceChoice
  let of_json = resourceReferenceChoice_of_json
  let to_json = json_of_resourceReferenceChoice
end

(** A named filesystem or data resource shareable by workflow tasks. *)
type workspace = {
  bomref: refType;
  uid: string;
  (**
     The unique identifier for the resource instance within its deployment
     context.
  *)
  name: string option;  (** The name of the resource instance. *)
  aliases: string list option;
  (**
     The names for the workspace as referenced by other workflow tasks.
     Effectively, a name mapping so other tasks can use their own local
     name in their steps.
  *)
  description: string option;  (** A description of the resource instance. *)
  resourceReferences: resourceReferenceChoice list option;
  (**
     References to component or service resources that are used to realize
     the resource instance.
  *)
  accessMode: workspaceAccessMode option;
  (**
     Describes the read-write access control for the workspace relative to
     the owning resource instance.
  *)
  mountPath: string option;
  (**
     A path to a location on disk where the workspace will be available to
     the associated task's steps.
  *)
  managedDataType: string option;  (** The name of a domain-specific data type the workspace represents. *)
  volumeRequest: string option;
  (**
     Identifies the reference to the request for a specific volume type and
     parameters.
  *)
  volume: volume option;
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_workspace ~bomref ~uid ?name ?aliases ?description ?resourceReferences ?accessMode ?mountPath ?managedDataType ?volumeRequest ?volume ?properties () : workspace =
  { bomref; uid; name; aliases; description; resourceReferences; accessMode; mountPath; managedDataType; volumeRequest; volume; properties }

let workspace_of_yojson (x : Yojson.Safe.t) : workspace =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | Some v -> refType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "workspace" "bom-ref"
    in
    let uid =
      match assoc "uid" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "workspace" "uid"
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let aliases =
      match assoc "aliases" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let resourceReferences =
      match assoc "resourceReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson resourceReferenceChoice_of_yojson) v)
    in
    let accessMode =
      match assoc "accessMode" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (workspaceAccessMode_of_yojson v)
    in
    let mountPath =
      match assoc "mountPath" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let managedDataType =
      match assoc "managedDataType" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let volumeRequest =
      match assoc "volumeRequest" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let volume =
      match assoc "volume" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (volume_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { bomref; uid; name; aliases; description; resourceReferences; accessMode; mountPath; managedDataType; volumeRequest; volume; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "workspace" x

let yojson_of_workspace (x : workspace) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("bom-ref", yojson_of_refType x.bomref)];
    [("uid", Atdml_runtime.Yojson.yojson_of_string x.uid)];
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.aliases with None -> [] | Some v -> [("aliases", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.resourceReferences with None -> [] | Some v -> [("resourceReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_resourceReferenceChoice) v)]);
    (match x.accessMode with None -> [] | Some v -> [("accessMode", yojson_of_workspaceAccessMode v)]);
    (match x.mountPath with None -> [] | Some v -> [("mountPath", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.managedDataType with None -> [] | Some v -> [("managedDataType", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.volumeRequest with None -> [] | Some v -> [("volumeRequest", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.volume with None -> [] | Some v -> [("volume", yojson_of_volume v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let workspace_of_json s =
  workspace_of_yojson (Yojson.Safe.from_string s)

let json_of_workspace x =
  Yojson.Safe.to_string (yojson_of_workspace x)

module Workspace = struct
  type nonrec t = workspace
  let create = create_workspace
  let of_yojson = workspace_of_yojson
  let to_yojson = yojson_of_workspace
  let of_json = workspace_of_json
  let to_json = json_of_workspace
end

(** The source type of event which caused the trigger to fire. *)
type triggerType =
  | Manual
  | Api
  | Webhook
  | Scheduled

let triggerType_of_yojson (x : Yojson.Safe.t) : triggerType =
  match x with
  | `String "manual" -> Manual
  | `String "api" -> Api
  | `String "webhook" -> Webhook
  | `String "scheduled" -> Scheduled
  | _ -> Atdml_runtime.Yojson.bad_sum "triggerType" x

let yojson_of_triggerType (x : triggerType) : Yojson.Safe.t =
  match x with
  | Manual -> `String "manual"
  | Api -> `String "api"
  | Webhook -> `String "webhook"
  | Scheduled -> `String "scheduled"

let triggerType_of_json s =
  triggerType_of_yojson (Yojson.Safe.from_string s)

let json_of_triggerType x =
  Yojson.Safe.to_string (yojson_of_triggerType x)

module TriggerType = struct
  type nonrec t = triggerType
  let of_yojson = triggerType_of_yojson
  let to_yojson = yojson_of_triggerType
  let of_json = triggerType_of_json
  let to_json = json_of_triggerType
end

type outputType =
  | JsonoutputType_1 of json_
  | JsonoutputType_2 of json_
  | JsonoutputType_3 of json_

let outputType_of_yojson (x : Yojson.Safe.t) : outputType =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "JsonoutputType_1"; v] -> JsonoutputType_1 (json__of_yojson v)
  | `List [`String "JsonoutputType_2"; v] -> JsonoutputType_2 (json__of_yojson v)
  | `List [`String "JsonoutputType_3"; v] -> JsonoutputType_3 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "outputType" x

let yojson_of_outputType (x : outputType) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | JsonoutputType_1 v -> `List [`String "JsonoutputType_1"; yojson_of_json_ v]
    | JsonoutputType_2 v -> `List [`String "JsonoutputType_2"; yojson_of_json_ v]
    | JsonoutputType_3 v -> `List [`String "JsonoutputType_3"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let outputType_of_json s =
  outputType_of_yojson (Yojson.Safe.from_string s)

let json_of_outputType x =
  Yojson.Safe.to_string (yojson_of_outputType x)

module OutputType = struct
  type nonrec t = outputType
  let of_yojson = outputType_of_yojson
  let to_yojson = yojson_of_outputType
  let of_json = outputType_of_json
  let to_json = json_of_outputType
end

(** Type that represents various input data types and formats. *)
type inputType =
  | JsoninputType_1 of json_
  | JsoninputType_2 of json_
  | JsoninputType_3 of json_
  | JsoninputType_4 of json_

let inputType_of_yojson (x : Yojson.Safe.t) : inputType =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "JsoninputType_1"; v] -> JsoninputType_1 (json__of_yojson v)
  | `List [`String "JsoninputType_2"; v] -> JsoninputType_2 (json__of_yojson v)
  | `List [`String "JsoninputType_3"; v] -> JsoninputType_3 (json__of_yojson v)
  | `List [`String "JsoninputType_4"; v] -> JsoninputType_4 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "inputType" x

let yojson_of_inputType (x : inputType) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | JsoninputType_1 v -> `List [`String "JsoninputType_1"; yojson_of_json_ v]
    | JsoninputType_2 v -> `List [`String "JsoninputType_2"; yojson_of_json_ v]
    | JsoninputType_3 v -> `List [`String "JsoninputType_3"; yojson_of_json_ v]
    | JsoninputType_4 v -> `List [`String "JsoninputType_4"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let inputType_of_json s =
  inputType_of_yojson (Yojson.Safe.from_string s)

let json_of_inputType x =
  Yojson.Safe.to_string (yojson_of_inputType x)

module InputType = struct
  type nonrec t = inputType
  let of_yojson = inputType_of_yojson
  let to_yojson = yojson_of_inputType
  let of_json = inputType_of_json
  let to_json = json_of_inputType
end

(** Represents something that happened that may trigger a response. *)
type event = {
  uid: string option;  (** The unique identifier of the event. *)
  description: string option;  (** A description of the event. *)
  timeReceived: string option;  (** The date and time (timestamp) when the event was received. *)
  data: attachment option;
  source: resourceReferenceChoice option;
  target: resourceReferenceChoice option;
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_event ?uid ?description ?timeReceived ?data ?source ?target ?properties () : event =
  { uid; description; timeReceived; data; source; target; properties }

let event_of_yojson (x : Yojson.Safe.t) : event =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let uid =
      match assoc "uid" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let timeReceived =
      match assoc "timeReceived" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let data =
      match assoc "data" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (attachment_of_yojson v)
    in
    let source =
      match assoc "source" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (resourceReferenceChoice_of_yojson v)
    in
    let target =
      match assoc "target" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (resourceReferenceChoice_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { uid; description; timeReceived; data; source; target; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "event" x

let yojson_of_event (x : event) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.uid with None -> [] | Some v -> [("uid", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.timeReceived with None -> [] | Some v -> [("timeReceived", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.data with None -> [] | Some v -> [("data", yojson_of_attachment v)]);
    (match x.source with None -> [] | Some v -> [("source", yojson_of_resourceReferenceChoice v)]);
    (match x.target with None -> [] | Some v -> [("target", yojson_of_resourceReferenceChoice v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let event_of_json s =
  event_of_yojson (Yojson.Safe.from_string s)

let json_of_event x =
  Yojson.Safe.to_string (yojson_of_event x)

module Event = struct
  type nonrec t = event
  let create = create_event
  let of_yojson = event_of_yojson
  let to_yojson = yojson_of_event
  let of_json = event_of_json
  let to_json = json_of_event
end

(** A condition that was used to determine a trigger should be activated. *)
type condition = {
  description: string option;  (** Describes the set of conditions which cause the trigger to activate. *)
  expression: string option;
  (**
     The logical expression that was evaluated that determined the trigger
     should be fired.
  *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_condition ?description ?expression ?properties () : condition =
  { description; expression; properties }

let condition_of_yojson (x : Yojson.Safe.t) : condition =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let expression =
      match assoc "expression" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { description; expression; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "condition" x

let yojson_of_condition (x : condition) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.expression with None -> [] | Some v -> [("expression", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let condition_of_json s =
  condition_of_yojson (Yojson.Safe.from_string s)

let json_of_condition x =
  Yojson.Safe.to_string (yojson_of_condition x)

module Condition = struct
  type nonrec t = condition
  let create = create_condition
  let of_yojson = condition_of_yojson
  let to_yojson = yojson_of_condition
  let of_json = condition_of_json
  let to_json = json_of_condition
end

(**
   Represents a resource that can conditionally activate (or fire) tasks
   based upon associated events and their data.
*)
type trigger = {
  bomref: refType;
  uid: string;
  (**
     The unique identifier for the resource instance within its deployment
     context.
  *)
  name: string option;  (** The name of the resource instance. *)
  description: string option;  (** A description of the resource instance. *)
  resourceReferences: resourceReferenceChoice list option;
  (**
     References to component or service resources that are used to realize
     the resource instance.
  *)
  type_: triggerType;  (** The source type of event which caused the trigger to fire. *)
  event: event option;
  conditions: condition list option;
  (**
     A list of conditions used to determine if a trigger should be
     activated.
  *)
  timeActivated: string option;  (** The date and time (timestamp) when the trigger was activated. *)
  inputs: inputType list option;
  (**
     Represents resources and data brought into a task at runtime by
     executor or task commands
  *)
  outputs: outputType list option;
  (**
     Represents resources and data output from a task at runtime by
     executor or task commands
  *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_trigger ~bomref ~uid ?name ?description ?resourceReferences ~type_ ?event ?conditions ?timeActivated ?inputs ?outputs ?properties () : trigger =
  { bomref; uid; name; description; resourceReferences; type_; event; conditions; timeActivated; inputs; outputs; properties }

let trigger_of_yojson (x : Yojson.Safe.t) : trigger =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | Some v -> refType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "trigger" "bom-ref"
    in
    let uid =
      match assoc "uid" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "trigger" "uid"
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let resourceReferences =
      match assoc "resourceReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson resourceReferenceChoice_of_yojson) v)
    in
    let type_ =
      match assoc "type" with
      | Some v -> triggerType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "trigger" "type"
    in
    let event =
      match assoc "event" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (event_of_yojson v)
    in
    let conditions =
      match assoc "conditions" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson condition_of_yojson) v)
    in
    let timeActivated =
      match assoc "timeActivated" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let inputs =
      match assoc "inputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson inputType_of_yojson) v)
    in
    let outputs =
      match assoc "outputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson outputType_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { bomref; uid; name; description; resourceReferences; type_; event; conditions; timeActivated; inputs; outputs; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "trigger" x

let yojson_of_trigger (x : trigger) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("bom-ref", yojson_of_refType x.bomref)];
    [("uid", Atdml_runtime.Yojson.yojson_of_string x.uid)];
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.resourceReferences with None -> [] | Some v -> [("resourceReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_resourceReferenceChoice) v)]);
    [("type", yojson_of_triggerType x.type_)];
    (match x.event with None -> [] | Some v -> [("event", yojson_of_event v)]);
    (match x.conditions with None -> [] | Some v -> [("conditions", (Atdml_runtime.Yojson.yojson_of_list yojson_of_condition) v)]);
    (match x.timeActivated with None -> [] | Some v -> [("timeActivated", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.inputs with None -> [] | Some v -> [("inputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_inputType) v)]);
    (match x.outputs with None -> [] | Some v -> [("outputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_outputType) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let trigger_of_json s =
  trigger_of_yojson (Yojson.Safe.from_string s)

let json_of_trigger x =
  Yojson.Safe.to_string (yojson_of_trigger x)

module Trigger = struct
  type nonrec t = trigger
  let create = create_trigger
  let of_yojson = trigger_of_yojson
  let to_yojson = yojson_of_trigger
  let of_json = trigger_of_json
  let to_json = json_of_trigger
end

type taskType =
  | Copy
  | Clone
  | Lint
  | Scan
  | Merge
  | Build
  | Test
  | Deliver
  | Deploy
  | Release
  | Clean
  | Other

let taskType_of_yojson (x : Yojson.Safe.t) : taskType =
  match x with
  | `String "copy" -> Copy
  | `String "clone" -> Clone
  | `String "lint" -> Lint
  | `String "scan" -> Scan
  | `String "merge" -> Merge
  | `String "build" -> Build
  | `String "test" -> Test
  | `String "deliver" -> Deliver
  | `String "deploy" -> Deploy
  | `String "release" -> Release
  | `String "clean" -> Clean
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "taskType" x

let yojson_of_taskType (x : taskType) : Yojson.Safe.t =
  match x with
  | Copy -> `String "copy"
  | Clone -> `String "clone"
  | Lint -> `String "lint"
  | Scan -> `String "scan"
  | Merge -> `String "merge"
  | Build -> `String "build"
  | Test -> `String "test"
  | Deliver -> `String "deliver"
  | Deploy -> `String "deploy"
  | Release -> `String "release"
  | Clean -> `String "clean"
  | Other -> `String "other"

let taskType_of_json s =
  taskType_of_yojson (Yojson.Safe.from_string s)

let json_of_taskType x =
  Yojson.Safe.to_string (yojson_of_taskType x)

module TaskType = struct
  type nonrec t = taskType
  let of_yojson = taskType_of_yojson
  let to_yojson = yojson_of_taskType
  let of_json = taskType_of_json
  let to_json = json_of_taskType
end

type command = {
  executed: string option;  (** A text representation of the executed command. *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_command ?executed ?properties () : command =
  { executed; properties }

let command_of_yojson (x : Yojson.Safe.t) : command =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let executed =
      match assoc "executed" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { executed; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "command" x

let yojson_of_command (x : command) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.executed with None -> [] | Some v -> [("executed", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let command_of_json s =
  command_of_yojson (Yojson.Safe.from_string s)

let json_of_command x =
  Yojson.Safe.to_string (yojson_of_command x)

module Command = struct
  type nonrec t = command
  let create = create_command
  let of_yojson = command_of_yojson
  let to_yojson = yojson_of_command
  let of_json = command_of_json
  let to_json = json_of_command
end

(**
   Executes specific commands or tools in order to accomplish its owning
   task as part of a sequence.
*)
type step = {
  name: string option;  (** A name for the step. *)
  description: string option;  (** A description of the step. *)
  commands: command list option;  (** Ordered list of commands or directives for the step *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_step ?name ?description ?commands ?properties () : step =
  { name; description; commands; properties }

let step_of_yojson (x : Yojson.Safe.t) : step =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let commands =
      match assoc "commands" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson command_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { name; description; commands; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "step" x

let yojson_of_step (x : step) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.commands with None -> [] | Some v -> [("commands", (Atdml_runtime.Yojson.yojson_of_list yojson_of_command) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let step_of_json s =
  step_of_yojson (Yojson.Safe.from_string s)

let json_of_step x =
  Yojson.Safe.to_string (yojson_of_step x)

module Step = struct
  type nonrec t = step
  let create = create_step
  let of_yojson = step_of_yojson
  let to_yojson = yojson_of_step
  let of_json = step_of_json
  let to_json = json_of_step
end

(**
   Defines the direct dependencies of a component, service, or the
   components provided/implemented by a given component. Components or
   services that do not have their own dependencies must be declared as
   empty elements within the graph. Components or services that are not
   represented in the dependency graph may have unknown dependencies. It
   is recommended that implementations assume this to be opaque and not
   an indicator of an object being dependency-free. It is recommended to
   leverage compositions to indicate unknown dependency graphs.
*)
type dependency = {
  ref: refLinkType;
  dependsOn: refLinkType list option;
  (**
     The bom-ref identifiers of the components or services that are
     dependencies of this dependency object.
  *)
  provides: refLinkType list option;
  (**
     The bom-ref identifiers of the components or services that define a
     given specification or standard, which are provided or implemented by
     this dependency object. For example, a cryptographic library which
     implements a cryptographic algorithm. A component which implements
     another component does not imply that the implementation is in use.
  *)
}

let create_dependency ~ref ?dependsOn ?provides () : dependency =
  { ref; dependsOn; provides }

let dependency_of_yojson (x : Yojson.Safe.t) : dependency =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let ref =
      match assoc "ref" with
      | Some v -> refLinkType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "dependency" "ref"
    in
    let dependsOn =
      match assoc "dependsOn" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    let provides =
      match assoc "provides" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    { ref; dependsOn; provides }
  | _ -> Atdml_runtime.Yojson.bad_type "dependency" x

let yojson_of_dependency (x : dependency) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("ref", yojson_of_refLinkType x.ref)];
    (match x.dependsOn with None -> [] | Some v -> [("dependsOn", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
    (match x.provides with None -> [] | Some v -> [("provides", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
  ])

let dependency_of_json s =
  dependency_of_yojson (Yojson.Safe.from_string s)

let json_of_dependency x =
  Yojson.Safe.to_string (yojson_of_dependency x)

module Dependency = struct
  type nonrec t = dependency
  let create = create_dependency
  let of_yojson = dependency_of_yojson
  let to_yojson = yojson_of_dependency
  let of_json = dependency_of_json
  let to_json = json_of_dependency
end

(**
   Describes the inputs, sequence of steps and resources used to
   accomplish a task and its output.
*)
type task = {
  bomref: refType;
  uid: string;
  (**
     The unique identifier for the resource instance within its deployment
     context.
  *)
  name: string option;  (** The name of the resource instance. *)
  description: string option;  (** A description of the resource instance. *)
  resourceReferences: resourceReferenceChoice list option;
  (**
     References to component or service resources that are used to realize
     the resource instance.
  *)
  taskTypes: taskType list;
  (**
     Indicates the types of activities performed by the set of workflow
     tasks.
  *)
  trigger: trigger option;
  steps: step list option;  (** The sequence of steps for the task. *)
  inputs: inputType list option;
  (**
     Represents resources and data brought into a task at runtime by
     executor or task commands
  *)
  outputs: outputType list option;
  (**
     Represents resources and data output from a task at runtime by
     executor or task commands
  *)
  timeStart: string option;  (** The date and time (timestamp) when the task started. *)
  timeEnd: string option;  (** The date and time (timestamp) when the task ended. *)
  workspaces: workspace list option;
  (**
     A set of named filesystem or data resource shareable by workflow
     tasks.
  *)
  runtimeTopology: dependency list option;  (** A graph of the component runtime topology for task's instance. *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_task ~bomref ~uid ?name ?description ?resourceReferences ~taskTypes ?trigger ?steps ?inputs ?outputs ?timeStart ?timeEnd ?workspaces ?runtimeTopology ?properties () : task =
  { bomref; uid; name; description; resourceReferences; taskTypes; trigger; steps; inputs; outputs; timeStart; timeEnd; workspaces; runtimeTopology; properties }

let task_of_yojson (x : Yojson.Safe.t) : task =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | Some v -> refType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "task" "bom-ref"
    in
    let uid =
      match assoc "uid" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "task" "uid"
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let resourceReferences =
      match assoc "resourceReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson resourceReferenceChoice_of_yojson) v)
    in
    let taskTypes =
      match assoc "taskTypes" with
      | Some v -> (Atdml_runtime.Yojson.list_of_yojson taskType_of_yojson) v
      | None -> Atdml_runtime.Yojson.missing_field "task" "taskTypes"
    in
    let trigger =
      match assoc "trigger" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (trigger_of_yojson v)
    in
    let steps =
      match assoc "steps" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson step_of_yojson) v)
    in
    let inputs =
      match assoc "inputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson inputType_of_yojson) v)
    in
    let outputs =
      match assoc "outputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson outputType_of_yojson) v)
    in
    let timeStart =
      match assoc "timeStart" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let timeEnd =
      match assoc "timeEnd" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let workspaces =
      match assoc "workspaces" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson workspace_of_yojson) v)
    in
    let runtimeTopology =
      match assoc "runtimeTopology" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson dependency_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { bomref; uid; name; description; resourceReferences; taskTypes; trigger; steps; inputs; outputs; timeStart; timeEnd; workspaces; runtimeTopology; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "task" x

let yojson_of_task (x : task) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("bom-ref", yojson_of_refType x.bomref)];
    [("uid", Atdml_runtime.Yojson.yojson_of_string x.uid)];
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.resourceReferences with None -> [] | Some v -> [("resourceReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_resourceReferenceChoice) v)]);
    [("taskTypes", (Atdml_runtime.Yojson.yojson_of_list yojson_of_taskType) x.taskTypes)];
    (match x.trigger with None -> [] | Some v -> [("trigger", yojson_of_trigger v)]);
    (match x.steps with None -> [] | Some v -> [("steps", (Atdml_runtime.Yojson.yojson_of_list yojson_of_step) v)]);
    (match x.inputs with None -> [] | Some v -> [("inputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_inputType) v)]);
    (match x.outputs with None -> [] | Some v -> [("outputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_outputType) v)]);
    (match x.timeStart with None -> [] | Some v -> [("timeStart", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.timeEnd with None -> [] | Some v -> [("timeEnd", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.workspaces with None -> [] | Some v -> [("workspaces", (Atdml_runtime.Yojson.yojson_of_list yojson_of_workspace) v)]);
    (match x.runtimeTopology with None -> [] | Some v -> [("runtimeTopology", (Atdml_runtime.Yojson.yojson_of_list yojson_of_dependency) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let task_of_json s =
  task_of_yojson (Yojson.Safe.from_string s)

let json_of_task x =
  Yojson.Safe.to_string (yojson_of_task x)

module Task = struct
  type nonrec t = task
  let create = create_task
  let of_yojson = task_of_yojson
  let to_yojson = yojson_of_task
  let of_json = task_of_json
  let to_json = json_of_task
end

(** A specialized orchestration task. *)
type workflow = {
  bomref: refType;
  uid: string;
  (**
     The unique identifier for the resource instance within its deployment
     context.
  *)
  name: string option;  (** The name of the resource instance. *)
  description: string option;  (** A description of the resource instance. *)
  resourceReferences: resourceReferenceChoice list option;
  (**
     References to component or service resources that are used to realize
     the resource instance.
  *)
  tasks: task list option;  (** The tasks that comprise the workflow. *)
  taskDependencies: dependency list option;  (** The graph of dependencies between tasks within the workflow. *)
  taskTypes: taskType list;
  (**
     Indicates the types of activities performed by the set of workflow
     tasks.
  *)
  trigger: trigger option;
  steps: step list option;  (** The sequence of steps for the task. *)
  inputs: inputType list option;
  (**
     Represents resources and data brought into a task at runtime by
     executor or task commands
  *)
  outputs: outputType list option;
  (**
     Represents resources and data output from a task at runtime by
     executor or task commands
  *)
  timeStart: string option;  (** The date and time (timestamp) when the task started. *)
  timeEnd: string option;  (** The date and time (timestamp) when the task ended. *)
  workspaces: workspace list option;
  (**
     A set of named filesystem or data resource shareable by workflow
     tasks.
  *)
  runtimeTopology: dependency list option;  (** A graph of the component runtime topology for workflow's instance. *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_workflow ~bomref ~uid ?name ?description ?resourceReferences ?tasks ?taskDependencies ~taskTypes ?trigger ?steps ?inputs ?outputs ?timeStart ?timeEnd ?workspaces ?runtimeTopology ?properties () : workflow =
  { bomref; uid; name; description; resourceReferences; tasks; taskDependencies; taskTypes; trigger; steps; inputs; outputs; timeStart; timeEnd; workspaces; runtimeTopology; properties }

let workflow_of_yojson (x : Yojson.Safe.t) : workflow =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | Some v -> refType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "workflow" "bom-ref"
    in
    let uid =
      match assoc "uid" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "workflow" "uid"
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let resourceReferences =
      match assoc "resourceReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson resourceReferenceChoice_of_yojson) v)
    in
    let tasks =
      match assoc "tasks" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson task_of_yojson) v)
    in
    let taskDependencies =
      match assoc "taskDependencies" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson dependency_of_yojson) v)
    in
    let taskTypes =
      match assoc "taskTypes" with
      | Some v -> (Atdml_runtime.Yojson.list_of_yojson taskType_of_yojson) v
      | None -> Atdml_runtime.Yojson.missing_field "workflow" "taskTypes"
    in
    let trigger =
      match assoc "trigger" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (trigger_of_yojson v)
    in
    let steps =
      match assoc "steps" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson step_of_yojson) v)
    in
    let inputs =
      match assoc "inputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson inputType_of_yojson) v)
    in
    let outputs =
      match assoc "outputs" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson outputType_of_yojson) v)
    in
    let timeStart =
      match assoc "timeStart" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let timeEnd =
      match assoc "timeEnd" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let workspaces =
      match assoc "workspaces" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson workspace_of_yojson) v)
    in
    let runtimeTopology =
      match assoc "runtimeTopology" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson dependency_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { bomref; uid; name; description; resourceReferences; tasks; taskDependencies; taskTypes; trigger; steps; inputs; outputs; timeStart; timeEnd; workspaces; runtimeTopology; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "workflow" x

let yojson_of_workflow (x : workflow) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("bom-ref", yojson_of_refType x.bomref)];
    [("uid", Atdml_runtime.Yojson.yojson_of_string x.uid)];
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.resourceReferences with None -> [] | Some v -> [("resourceReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_resourceReferenceChoice) v)]);
    (match x.tasks with None -> [] | Some v -> [("tasks", (Atdml_runtime.Yojson.yojson_of_list yojson_of_task) v)]);
    (match x.taskDependencies with None -> [] | Some v -> [("taskDependencies", (Atdml_runtime.Yojson.yojson_of_list yojson_of_dependency) v)]);
    [("taskTypes", (Atdml_runtime.Yojson.yojson_of_list yojson_of_taskType) x.taskTypes)];
    (match x.trigger with None -> [] | Some v -> [("trigger", yojson_of_trigger v)]);
    (match x.steps with None -> [] | Some v -> [("steps", (Atdml_runtime.Yojson.yojson_of_list yojson_of_step) v)]);
    (match x.inputs with None -> [] | Some v -> [("inputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_inputType) v)]);
    (match x.outputs with None -> [] | Some v -> [("outputs", (Atdml_runtime.Yojson.yojson_of_list yojson_of_outputType) v)]);
    (match x.timeStart with None -> [] | Some v -> [("timeStart", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.timeEnd with None -> [] | Some v -> [("timeEnd", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.workspaces with None -> [] | Some v -> [("workspaces", (Atdml_runtime.Yojson.yojson_of_list yojson_of_workspace) v)]);
    (match x.runtimeTopology with None -> [] | Some v -> [("runtimeTopology", (Atdml_runtime.Yojson.yojson_of_list yojson_of_dependency) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let workflow_of_json s =
  workflow_of_yojson (Yojson.Safe.from_string s)

let json_of_workflow x =
  Yojson.Safe.to_string (yojson_of_workflow x)

module Workflow = struct
  type nonrec t = workflow
  let create = create_workflow
  let of_yojson = workflow_of_yojson
  let to_yojson = yojson_of_workflow
  let of_json = workflow_of_json
  let to_json = json_of_workflow
end

(** The tool(s) used to identify, confirm, or score the vulnerability. *)
type vulnerabilityToolsTools = {
  components: component list option;  (** A list of software and hardware components used as tools. *)
  services: service list option;
  (**
     A list of services used as tools. This may include microservices,
     function-as-a-service, and other types of network or intra-process
     services.
  *)
}

let create_vulnerabilityToolsTools ?components ?services () : vulnerabilityToolsTools =
  { components; services }

let vulnerabilityToolsTools_of_yojson (x : Yojson.Safe.t) : vulnerabilityToolsTools =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let components =
      match assoc "components" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let services =
      match assoc "services" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson service_of_yojson) v)
    in
    { components; services }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerabilityToolsTools" x

let yojson_of_vulnerabilityToolsTools (x : vulnerabilityToolsTools) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.components with None -> [] | Some v -> [("components", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.services with None -> [] | Some v -> [("services", (Atdml_runtime.Yojson.yojson_of_list yojson_of_service) v)]);
  ])

let vulnerabilityToolsTools_of_json s =
  vulnerabilityToolsTools_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityToolsTools x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityToolsTools x)

module VulnerabilityToolsTools = struct
  type nonrec t = vulnerabilityToolsTools
  let create = create_vulnerabilityToolsTools
  let of_yojson = vulnerabilityToolsTools_of_yojson
  let to_yojson = yojson_of_vulnerabilityToolsTools
  let of_json = vulnerabilityToolsTools_of_json
  let to_json = json_of_vulnerabilityToolsTools
end

(**
   \[Deprecated\] This will be removed in a future version. Use component
   or service instead. Information about the automated or manual tool
   used
*)
type tool = {
  vendor: string option;  (** The name of the vendor who created the tool *)
  name: string option;  (** The name of the tool *)
  version: version option;
  hashes: hash list option;  (** The hashes of the tool (if applicable). *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant, but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
}

let create_tool ?vendor ?name ?version ?hashes ?externalReferences () : tool =
  { vendor; name; version; hashes; externalReferences }

let tool_of_yojson (x : Yojson.Safe.t) : tool =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let vendor =
      match assoc "vendor" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let version =
      match assoc "version" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (version_of_yojson v)
    in
    let hashes =
      match assoc "hashes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson hash_of_yojson) v)
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    { vendor; name; version; hashes; externalReferences }
  | _ -> Atdml_runtime.Yojson.bad_type "tool" x

let yojson_of_tool (x : tool) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.vendor with None -> [] | Some v -> [("vendor", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.version with None -> [] | Some v -> [("version", yojson_of_version v)]);
    (match x.hashes with None -> [] | Some v -> [("hashes", (Atdml_runtime.Yojson.yojson_of_list yojson_of_hash) v)]);
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
  ])

let tool_of_json s =
  tool_of_yojson (Yojson.Safe.from_string s)

let json_of_tool x =
  Yojson.Safe.to_string (yojson_of_tool x)

module Tool = struct
  type nonrec t = tool
  let create = create_tool
  let of_yojson = tool_of_yojson
  let to_yojson = yojson_of_tool
  let of_json = tool_of_json
  let to_json = json_of_tool
end

(** The tool(s) used to identify, confirm, or score the vulnerability. *)
type vulnerabilityTools =
  | Tools of vulnerabilityToolsTools
  | ToolList of tool list

let vulnerabilityTools_of_yojson (x : Yojson.Safe.t) : vulnerabilityTools =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "Tools"; v] -> Tools (vulnerabilityToolsTools_of_yojson v)
  | `List [`String "ToolList"; v] -> ToolList ((Atdml_runtime.Yojson.list_of_yojson tool_of_yojson) v)
  | _ -> Atdml_runtime.Yojson.bad_sum "vulnerabilityTools" x

let yojson_of_vulnerabilityTools (x : vulnerabilityTools) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | Tools v -> `List [`String "Tools"; yojson_of_vulnerabilityToolsTools v]
    | ToolList v -> `List [`String "ToolList"; (Atdml_runtime.Yojson.yojson_of_list yojson_of_tool) v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let vulnerabilityTools_of_json s =
  vulnerabilityTools_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityTools x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityTools x)

module VulnerabilityTools = struct
  type nonrec t = vulnerabilityTools
  let of_yojson = vulnerabilityTools_of_yojson
  let to_yojson = yojson_of_vulnerabilityTools
  let of_json = vulnerabilityTools_of_json
  let to_json = json_of_vulnerabilityTools
end

(**
   The source of vulnerability information. This is often the
   organization that published the vulnerability.
*)
type vulnerabilitySource = {
  url: string option;  (** The url of the vulnerability documentation as provided by the source. *)
  name: string option;  (** The name of the source. *)
}

let create_vulnerabilitySource ?url ?name () : vulnerabilitySource =
  { url; name }

let vulnerabilitySource_of_yojson (x : Yojson.Safe.t) : vulnerabilitySource =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { url; name }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerabilitySource" x

let yojson_of_vulnerabilitySource (x : vulnerabilitySource) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.url with None -> [] | Some v -> [("url", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let vulnerabilitySource_of_json s =
  vulnerabilitySource_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilitySource x =
  Yojson.Safe.to_string (yojson_of_vulnerabilitySource x)

module VulnerabilitySource = struct
  type nonrec t = vulnerabilitySource
  let create = create_vulnerabilitySource
  let of_yojson = vulnerabilitySource_of_yojson
  let to_yojson = yojson_of_vulnerabilitySource
  let of_json = vulnerabilitySource_of_json
  let to_json = json_of_vulnerabilitySource
end

type vulnerabilityReferences = {
  id: string;  (** An identifier that uniquely identifies the vulnerability. *)
  source: vulnerabilitySource;
}

let create_vulnerabilityReferences ~id ~source () : vulnerabilityReferences =
  { id; source }

let vulnerabilityReferences_of_yojson (x : Yojson.Safe.t) : vulnerabilityReferences =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let id =
      match assoc "id" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "vulnerabilityReferences" "id"
    in
    let source =
      match assoc "source" with
      | Some v -> vulnerabilitySource_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "vulnerabilityReferences" "source"
    in
    { id; source }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerabilityReferences" x

let yojson_of_vulnerabilityReferences (x : vulnerabilityReferences) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("id", Atdml_runtime.Yojson.yojson_of_string x.id)];
    [("source", yojson_of_vulnerabilitySource x.source)];
  ])

let vulnerabilityReferences_of_json s =
  vulnerabilityReferences_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityReferences x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityReferences x)

module VulnerabilityReferences = struct
  type nonrec t = vulnerabilityReferences
  let create = create_vulnerabilityReferences
  let of_yojson = vulnerabilityReferences_of_yojson
  let to_yojson = yojson_of_vulnerabilityReferences
  let of_json = vulnerabilityReferences_of_json
  let to_json = json_of_vulnerabilityReferences
end

(** Evidence used to reproduce the vulnerability. *)
type vulnerabilityProofOfConcept = {
  reproductionSteps: string option;  (** Precise steps to reproduce the vulnerability. *)
  environment: string option;  (** A description of the environment in which reproduction was possible. *)
  supportingMaterial: attachment list option;
  (**
     Supporting material that helps in reproducing or understanding how
     reproduction is possible. This may include screenshots, payloads, and
     PoC exploit code.
  *)
}

let create_vulnerabilityProofOfConcept ?reproductionSteps ?environment ?supportingMaterial () : vulnerabilityProofOfConcept =
  { reproductionSteps; environment; supportingMaterial }

let vulnerabilityProofOfConcept_of_yojson (x : Yojson.Safe.t) : vulnerabilityProofOfConcept =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let reproductionSteps =
      match assoc "reproductionSteps" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let environment =
      match assoc "environment" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let supportingMaterial =
      match assoc "supportingMaterial" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson attachment_of_yojson) v)
    in
    { reproductionSteps; environment; supportingMaterial }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerabilityProofOfConcept" x

let yojson_of_vulnerabilityProofOfConcept (x : vulnerabilityProofOfConcept) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.reproductionSteps with None -> [] | Some v -> [("reproductionSteps", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.environment with None -> [] | Some v -> [("environment", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.supportingMaterial with None -> [] | Some v -> [("supportingMaterial", (Atdml_runtime.Yojson.yojson_of_list yojson_of_attachment) v)]);
  ])

let vulnerabilityProofOfConcept_of_json s =
  vulnerabilityProofOfConcept_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityProofOfConcept x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityProofOfConcept x)

module VulnerabilityProofOfConcept = struct
  type nonrec t = vulnerabilityProofOfConcept
  let create = create_vulnerabilityProofOfConcept
  let of_yojson = vulnerabilityProofOfConcept_of_yojson
  let to_yojson = yojson_of_vulnerabilityProofOfConcept
  let of_json = vulnerabilityProofOfConcept_of_json
  let to_json = json_of_vulnerabilityProofOfConcept
end

(**
   Individuals or organizations credited with the discovery of the
   vulnerability.
*)
type vulnerabilityCredits = {
  organizations: organizationalEntity list option;  (** The organizations credited with vulnerability discovery. *)
  individuals: organizationalContact list option;
  (**
     The individuals, not associated with organizations, that are credited
     with vulnerability discovery.
  *)
}

let create_vulnerabilityCredits ?organizations ?individuals () : vulnerabilityCredits =
  { organizations; individuals }

let vulnerabilityCredits_of_yojson (x : Yojson.Safe.t) : vulnerabilityCredits =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let organizations =
      match assoc "organizations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson organizationalEntity_of_yojson) v)
    in
    let individuals =
      match assoc "individuals" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson organizationalContact_of_yojson) v)
    in
    { organizations; individuals }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerabilityCredits" x

let yojson_of_vulnerabilityCredits (x : vulnerabilityCredits) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.organizations with None -> [] | Some v -> [("organizations", (Atdml_runtime.Yojson.yojson_of_list yojson_of_organizationalEntity) v)]);
    (match x.individuals with None -> [] | Some v -> [("individuals", (Atdml_runtime.Yojson.yojson_of_list yojson_of_organizationalContact) v)]);
  ])

let vulnerabilityCredits_of_json s =
  vulnerabilityCredits_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityCredits x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityCredits x)

module VulnerabilityCredits = struct
  type nonrec t = vulnerabilityCredits
  let create = create_vulnerabilityCredits
  let of_yojson = vulnerabilityCredits_of_yojson
  let to_yojson = yojson_of_vulnerabilityCredits
  let of_json = vulnerabilityCredits_of_json
  let to_json = json_of_vulnerabilityCredits
end

type vulnerabilityAnalysisResponse =
  | Can_not_fix
  | Will_not_fix
  | Update
  | Rollback
  | Workaround_available

let vulnerabilityAnalysisResponse_of_yojson (x : Yojson.Safe.t) : vulnerabilityAnalysisResponse =
  match x with
  | `String "can_not_fix" -> Can_not_fix
  | `String "will_not_fix" -> Will_not_fix
  | `String "update" -> Update
  | `String "rollback" -> Rollback
  | `String "workaround_available" -> Workaround_available
  | _ -> Atdml_runtime.Yojson.bad_sum "vulnerabilityAnalysisResponse" x

let yojson_of_vulnerabilityAnalysisResponse (x : vulnerabilityAnalysisResponse) : Yojson.Safe.t =
  match x with
  | Can_not_fix -> `String "can_not_fix"
  | Will_not_fix -> `String "will_not_fix"
  | Update -> `String "update"
  | Rollback -> `String "rollback"
  | Workaround_available -> `String "workaround_available"

let vulnerabilityAnalysisResponse_of_json s =
  vulnerabilityAnalysisResponse_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityAnalysisResponse x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityAnalysisResponse x)

module VulnerabilityAnalysisResponse = struct
  type nonrec t = vulnerabilityAnalysisResponse
  let of_yojson = vulnerabilityAnalysisResponse_of_yojson
  let to_yojson = yojson_of_vulnerabilityAnalysisResponse
  let of_json = vulnerabilityAnalysisResponse_of_json
  let to_json = json_of_vulnerabilityAnalysisResponse
end

(**
   Declares the current state of an occurrence of a vulnerability, after
   automated or manual analysis.
*)
type impactAnalysisState =
  | Resolved
  | Resolved_with_pedigree
  | Exploitable
  | In_triage
  | False_positive
  | Not_affected

let impactAnalysisState_of_yojson (x : Yojson.Safe.t) : impactAnalysisState =
  match x with
  | `String "resolved" -> Resolved
  | `String "resolved_with_pedigree" -> Resolved_with_pedigree
  | `String "exploitable" -> Exploitable
  | `String "in_triage" -> In_triage
  | `String "false_positive" -> False_positive
  | `String "not_affected" -> Not_affected
  | _ -> Atdml_runtime.Yojson.bad_sum "impactAnalysisState" x

let yojson_of_impactAnalysisState (x : impactAnalysisState) : Yojson.Safe.t =
  match x with
  | Resolved -> `String "resolved"
  | Resolved_with_pedigree -> `String "resolved_with_pedigree"
  | Exploitable -> `String "exploitable"
  | In_triage -> `String "in_triage"
  | False_positive -> `String "false_positive"
  | Not_affected -> `String "not_affected"

let impactAnalysisState_of_json s =
  impactAnalysisState_of_yojson (Yojson.Safe.from_string s)

let json_of_impactAnalysisState x =
  Yojson.Safe.to_string (yojson_of_impactAnalysisState x)

module ImpactAnalysisState = struct
  type nonrec t = impactAnalysisState
  let of_yojson = impactAnalysisState_of_yojson
  let to_yojson = yojson_of_impactAnalysisState
  let of_json = impactAnalysisState_of_json
  let to_json = json_of_impactAnalysisState
end

(** The rationale of why the impact analysis state was asserted. *)
type impactAnalysisJustification =
  | Code_not_present
  | Code_not_reachable
  | Requires_configuration
  | Requires_dependency
  | Requires_environment
  | Protected_by_compiler
  | Protected_at_runtime
  | Protected_at_perimeter
  | Protected_by_mitigating_control

let impactAnalysisJustification_of_yojson (x : Yojson.Safe.t) : impactAnalysisJustification =
  match x with
  | `String "code_not_present" -> Code_not_present
  | `String "code_not_reachable" -> Code_not_reachable
  | `String "requires_configuration" -> Requires_configuration
  | `String "requires_dependency" -> Requires_dependency
  | `String "requires_environment" -> Requires_environment
  | `String "protected_by_compiler" -> Protected_by_compiler
  | `String "protected_at_runtime" -> Protected_at_runtime
  | `String "protected_at_perimeter" -> Protected_at_perimeter
  | `String "protected_by_mitigating_control" -> Protected_by_mitigating_control
  | _ -> Atdml_runtime.Yojson.bad_sum "impactAnalysisJustification" x

let yojson_of_impactAnalysisJustification (x : impactAnalysisJustification) : Yojson.Safe.t =
  match x with
  | Code_not_present -> `String "code_not_present"
  | Code_not_reachable -> `String "code_not_reachable"
  | Requires_configuration -> `String "requires_configuration"
  | Requires_dependency -> `String "requires_dependency"
  | Requires_environment -> `String "requires_environment"
  | Protected_by_compiler -> `String "protected_by_compiler"
  | Protected_at_runtime -> `String "protected_at_runtime"
  | Protected_at_perimeter -> `String "protected_at_perimeter"
  | Protected_by_mitigating_control -> `String "protected_by_mitigating_control"

let impactAnalysisJustification_of_json s =
  impactAnalysisJustification_of_yojson (Yojson.Safe.from_string s)

let json_of_impactAnalysisJustification x =
  Yojson.Safe.to_string (yojson_of_impactAnalysisJustification x)

module ImpactAnalysisJustification = struct
  type nonrec t = impactAnalysisJustification
  let of_yojson = impactAnalysisJustification_of_yojson
  let to_yojson = yojson_of_impactAnalysisJustification
  let of_json = impactAnalysisJustification_of_json
  let to_json = json_of_impactAnalysisJustification
end

(** An assessment of the impact and exploitability of the vulnerability. *)
type vulnerabilityAnalysis = {
  state: impactAnalysisState option;
  justification: impactAnalysisJustification option;
  response: vulnerabilityAnalysisResponse list option;
  (**
     A response to the vulnerability by the manufacturer, supplier, or
     project responsible for the affected component or service. More than
     one response is allowed. Responses are strongly encouraged for
     vulnerabilities where the analysis state is exploitable.
  *)
  detail: string option;
  (**
     Detailed description of the impact including methods used during
     assessment. If a vulnerability is not exploitable, this field should
     include specific details on why the component or service is not
     impacted by this vulnerability.
  *)
  firstIssued: string option;  (** The date and time (timestamp) when the analysis was first issued. *)
  lastUpdated: string option;  (** The date and time (timestamp) when the analysis was last updated. *)
}

let create_vulnerabilityAnalysis ?state ?justification ?response ?detail ?firstIssued ?lastUpdated () : vulnerabilityAnalysis =
  { state; justification; response; detail; firstIssued; lastUpdated }

let vulnerabilityAnalysis_of_yojson (x : Yojson.Safe.t) : vulnerabilityAnalysis =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let state =
      match assoc "state" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (impactAnalysisState_of_yojson v)
    in
    let justification =
      match assoc "justification" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (impactAnalysisJustification_of_yojson v)
    in
    let response =
      match assoc "response" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson vulnerabilityAnalysisResponse_of_yojson) v)
    in
    let detail =
      match assoc "detail" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let firstIssued =
      match assoc "firstIssued" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let lastUpdated =
      match assoc "lastUpdated" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { state; justification; response; detail; firstIssued; lastUpdated }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerabilityAnalysis" x

let yojson_of_vulnerabilityAnalysis (x : vulnerabilityAnalysis) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.state with None -> [] | Some v -> [("state", yojson_of_impactAnalysisState v)]);
    (match x.justification with None -> [] | Some v -> [("justification", yojson_of_impactAnalysisJustification v)]);
    (match x.response with None -> [] | Some v -> [("response", (Atdml_runtime.Yojson.yojson_of_list yojson_of_vulnerabilityAnalysisResponse) v)]);
    (match x.detail with None -> [] | Some v -> [("detail", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.firstIssued with None -> [] | Some v -> [("firstIssued", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.lastUpdated with None -> [] | Some v -> [("lastUpdated", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let vulnerabilityAnalysis_of_json s =
  vulnerabilityAnalysis_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityAnalysis x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityAnalysis x)

module VulnerabilityAnalysis = struct
  type nonrec t = vulnerabilityAnalysis
  let create = create_vulnerabilityAnalysis
  let of_yojson = vulnerabilityAnalysis_of_yojson
  let to_yojson = yojson_of_vulnerabilityAnalysis
  let of_json = vulnerabilityAnalysis_of_json
  let to_json = json_of_vulnerabilityAnalysis
end

type vulnerabilityAffectsVersions =
  | Jsonvulnerabilityaffectsversions_1 of json_
  | Jsonvulnerabilityaffectsversions_2 of json_

let vulnerabilityAffectsVersions_of_yojson (x : Yojson.Safe.t) : vulnerabilityAffectsVersions =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "Jsonvulnerabilityaffectsversions_1"; v] -> Jsonvulnerabilityaffectsversions_1 (json__of_yojson v)
  | `List [`String "Jsonvulnerabilityaffectsversions_2"; v] -> Jsonvulnerabilityaffectsversions_2 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "vulnerabilityAffectsVersions" x

let yojson_of_vulnerabilityAffectsVersions (x : vulnerabilityAffectsVersions) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | Jsonvulnerabilityaffectsversions_1 v -> `List [`String "Jsonvulnerabilityaffectsversions_1"; yojson_of_json_ v]
    | Jsonvulnerabilityaffectsversions_2 v -> `List [`String "Jsonvulnerabilityaffectsversions_2"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let vulnerabilityAffectsVersions_of_json s =
  vulnerabilityAffectsVersions_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityAffectsVersions x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityAffectsVersions x)

module VulnerabilityAffectsVersions = struct
  type nonrec t = vulnerabilityAffectsVersions
  let of_yojson = vulnerabilityAffectsVersions_of_yojson
  let to_yojson = yojson_of_vulnerabilityAffectsVersions
  let of_json = vulnerabilityAffectsVersions_of_json
  let to_json = json_of_vulnerabilityAffectsVersions
end

(** References a component or service by the objects bom-ref *)
type vulnerabilityAffectsRef =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

let vulnerabilityAffectsRef_of_yojson (x : Yojson.Safe.t) : vulnerabilityAffectsRef =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "RefLinkType"; v] -> RefLinkType (refLinkType_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "vulnerabilityAffectsRef" x

let yojson_of_vulnerabilityAffectsRef (x : vulnerabilityAffectsRef) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | RefLinkType v -> `List [`String "RefLinkType"; yojson_of_refLinkType v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let vulnerabilityAffectsRef_of_json s =
  vulnerabilityAffectsRef_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityAffectsRef x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityAffectsRef x)

module VulnerabilityAffectsRef = struct
  type nonrec t = vulnerabilityAffectsRef
  let of_yojson = vulnerabilityAffectsRef_of_yojson
  let to_yojson = yojson_of_vulnerabilityAffectsRef
  let of_json = vulnerabilityAffectsRef_of_json
  let to_json = json_of_vulnerabilityAffectsRef
end

type vulnerabilityAffects = {
  ref: vulnerabilityAffectsRef;  (** References a component or service by the objects bom-ref *)
  versions: vulnerabilityAffectsVersions list option;  (** Zero or more individual versions or range of versions. *)
}

let create_vulnerabilityAffects ~ref ?versions () : vulnerabilityAffects =
  { ref; versions }

let vulnerabilityAffects_of_yojson (x : Yojson.Safe.t) : vulnerabilityAffects =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let ref =
      match assoc "ref" with
      | Some v -> vulnerabilityAffectsRef_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "vulnerabilityAffects" "ref"
    in
    let versions =
      match assoc "versions" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson vulnerabilityAffectsVersions_of_yojson) v)
    in
    { ref; versions }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerabilityAffects" x

let yojson_of_vulnerabilityAffects (x : vulnerabilityAffects) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("ref", yojson_of_vulnerabilityAffectsRef x.ref)];
    (match x.versions with None -> [] | Some v -> [("versions", (Atdml_runtime.Yojson.yojson_of_list yojson_of_vulnerabilityAffectsVersions) v)]);
  ])

let vulnerabilityAffects_of_json s =
  vulnerabilityAffects_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerabilityAffects x =
  Yojson.Safe.to_string (yojson_of_vulnerabilityAffects x)

module VulnerabilityAffects = struct
  type nonrec t = vulnerabilityAffects
  let create = create_vulnerabilityAffects
  let of_yojson = vulnerabilityAffects_of_yojson
  let to_yojson = yojson_of_vulnerabilityAffects
  let of_json = vulnerabilityAffects_of_json
  let to_json = json_of_vulnerabilityAffects
end

(**
   Textual representation of the severity of the vulnerability adopted by
   the analysis method. If the analysis method uses values other than
   what is provided, the user is expected to translate appropriately.
*)
type severity =
  | Critical
  | High
  | Medium
  | Low
  | Info
  | None
  | Unknown

let severity_of_yojson (x : Yojson.Safe.t) : severity =
  match x with
  | `String "critical" -> Critical
  | `String "high" -> High
  | `String "medium" -> Medium
  | `String "low" -> Low
  | `String "info" -> Info
  | `String "none" -> None
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "severity" x

let yojson_of_severity (x : severity) : Yojson.Safe.t =
  match x with
  | Critical -> `String "critical"
  | High -> `String "high"
  | Medium -> `String "medium"
  | Low -> `String "low"
  | Info -> `String "info"
  | None -> `String "none"
  | Unknown -> `String "unknown"

let severity_of_json s =
  severity_of_yojson (Yojson.Safe.from_string s)

let json_of_severity x =
  Yojson.Safe.to_string (yojson_of_severity x)

module Severity = struct
  type nonrec t = severity
  let of_yojson = severity_of_yojson
  let to_yojson = yojson_of_severity
  let of_json = severity_of_json
  let to_json = json_of_severity
end

(** Specifies the severity or risk scoring methodology or standard used. *)
type scoreMethod =
  | CVSSv2
  | CVSSv3
  | CVSSv31
  | CVSSv4
  | OWASP
  | SSVC
  | Other

let scoreMethod_of_yojson (x : Yojson.Safe.t) : scoreMethod =
  match x with
  | `String "CVSSv2" -> CVSSv2
  | `String "CVSSv3" -> CVSSv3
  | `String "CVSSv31" -> CVSSv31
  | `String "CVSSv4" -> CVSSv4
  | `String "OWASP" -> OWASP
  | `String "SSVC" -> SSVC
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "scoreMethod" x

let yojson_of_scoreMethod (x : scoreMethod) : Yojson.Safe.t =
  match x with
  | CVSSv2 -> `String "CVSSv2"
  | CVSSv3 -> `String "CVSSv3"
  | CVSSv31 -> `String "CVSSv31"
  | CVSSv4 -> `String "CVSSv4"
  | OWASP -> `String "OWASP"
  | SSVC -> `String "SSVC"
  | Other -> `String "other"

let scoreMethod_of_json s =
  scoreMethod_of_yojson (Yojson.Safe.from_string s)

let json_of_scoreMethod x =
  Yojson.Safe.to_string (yojson_of_scoreMethod x)

module ScoreMethod = struct
  type nonrec t = scoreMethod
  let of_yojson = scoreMethod_of_yojson
  let to_yojson = yojson_of_scoreMethod
  let of_json = scoreMethod_of_json
  let to_json = json_of_scoreMethod
end

(** Defines the severity or risk ratings of a vulnerability. *)
type rating = {
  source: vulnerabilitySource option;
  score: float option;  (** The numerical score of the rating. *)
  severity: severity option;
  method_: scoreMethod option;
  vector: string option;
  (**
     Textual representation of the metric values used to score the
     vulnerability
  *)
  justification: string option;  (** An optional reason for rating the vulnerability as it was *)
}

let create_rating ?source ?score ?severity ?method_ ?vector ?justification () : rating =
  { source; score; severity; method_; vector; justification }

let rating_of_yojson (x : Yojson.Safe.t) : rating =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let source =
      match assoc "source" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (vulnerabilitySource_of_yojson v)
    in
    let score =
      match assoc "score" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.float_of_yojson v)
    in
    let severity =
      match assoc "severity" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (severity_of_yojson v)
    in
    let method_ =
      match assoc "method" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (scoreMethod_of_yojson v)
    in
    let vector =
      match assoc "vector" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let justification =
      match assoc "justification" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { source; score; severity; method_; vector; justification }
  | _ -> Atdml_runtime.Yojson.bad_type "rating" x

let yojson_of_rating (x : rating) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.source with None -> [] | Some v -> [("source", yojson_of_vulnerabilitySource v)]);
    (match x.score with None -> [] | Some v -> [("score", Atdml_runtime.Yojson.yojson_of_float v)]);
    (match x.severity with None -> [] | Some v -> [("severity", yojson_of_severity v)]);
    (match x.method_ with None -> [] | Some v -> [("method", yojson_of_scoreMethod v)]);
    (match x.vector with None -> [] | Some v -> [("vector", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.justification with None -> [] | Some v -> [("justification", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let rating_of_json s =
  rating_of_yojson (Yojson.Safe.from_string s)

let json_of_rating x =
  Yojson.Safe.to_string (yojson_of_rating x)

module Rating = struct
  type nonrec t = rating
  let create = create_rating
  let of_yojson = rating_of_yojson
  let to_yojson = yojson_of_rating
  let of_json = rating_of_json
  let to_json = json_of_rating
end

(**
   Integer representation of a Common Weaknesses Enumerations (CWE). For
   example 399 (of https://cwe.mitre.org/data/definitions/399.html)
*)
type cwe = int

let create_cwe (x : int) : cwe = x


let cwe_of_yojson (x : Yojson.Safe.t) : cwe =
  Atdml_runtime.Yojson.int_of_yojson x

let yojson_of_cwe (x : cwe) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_int x

let cwe_of_json s =
  cwe_of_yojson (Yojson.Safe.from_string s)

let json_of_cwe x =
  Yojson.Safe.to_string (yojson_of_cwe x)

module Cwe = struct
  type nonrec t = cwe
  let create = create_cwe
  let of_yojson = cwe_of_yojson
  let to_yojson = yojson_of_cwe
  let of_json = cwe_of_json
  let to_json = json_of_cwe
end

(**
   Title and location where advisory information can be obtained. An
   advisory is a notification of a threat to a component, service, or
   system.
*)
type advisory = {
  title: string option;  (** An optional name of the advisory. *)
  url: string;  (** Location where the advisory can be obtained. *)
}

let create_advisory ?title ~url () : advisory =
  { title; url }

let advisory_of_yojson (x : Yojson.Safe.t) : advisory =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let title =
      match assoc "title" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let url =
      match assoc "url" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "advisory" "url"
    in
    { title; url }
  | _ -> Atdml_runtime.Yojson.bad_type "advisory" x

let yojson_of_advisory (x : advisory) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.title with None -> [] | Some v -> [("title", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("url", Atdml_runtime.Yojson.yojson_of_string x.url)];
  ])

let advisory_of_json s =
  advisory_of_yojson (Yojson.Safe.from_string s)

let json_of_advisory x =
  Yojson.Safe.to_string (yojson_of_advisory x)

module Advisory = struct
  type nonrec t = advisory
  let create = create_advisory
  let of_yojson = advisory_of_yojson
  let to_yojson = yojson_of_advisory
  let of_json = advisory_of_json
  let to_json = json_of_advisory
end

(**
   Defines a weakness in a component or service that could be exploited
   or triggered by a threat source.
*)
type vulnerability = {
  bomref: refType option;
  id: string option;  (** The identifier that uniquely identifies the vulnerability. *)
  source: vulnerabilitySource option;
  references: vulnerabilityReferences list option;
  (**
     Zero or more pointers to vulnerabilities that are the equivalent of
     the vulnerability specified. Often times, the same vulnerability may
     exist in multiple sources of vulnerability intelligence, but have
     different identifiers. References provide a way to correlate
     vulnerabilities across multiple sources of vulnerability intelligence.
  *)
  ratings: rating list option;
  (**
     List of vulnerability ratings. Consumers SHOULD consider ratings in
     prioritization decisions; source ratings may differ and aid
     prioritization.
  *)
  cwes: cwe list option;
  (**
     List of Common Weaknesses Enumerations (CWEs) codes that describes
     this vulnerability.
  *)
  description: string option;  (** A description of the vulnerability as provided by the source. *)
  detail: string option;
  (**
     If available, an in-depth description of the vulnerability as provided
     by the source organization. Details often include information useful
     in understanding root cause.
  *)
  recommendation: string option;
  (**
     Recommendations of how the vulnerability can be remediated or
     mitigated.
  *)
  workaround: string option;
  (**
     A bypass, usually temporary, of the vulnerability that reduces its
     likelihood and/or impact. Workarounds often involve changes to
     configuration or deployments.
  *)
  proofOfConcept: vulnerabilityProofOfConcept option;  (** Evidence used to reproduce the vulnerability. *)
  advisories: advisory list option;  (** Published advisories of the vulnerability if provided. *)
  created: string option;
  (**
     The date and time (timestamp) when the vulnerability record was
     created in the vulnerability database.
  *)
  published: string option;
  (**
     The date and time (timestamp) when the vulnerability record was first
     published.
  *)
  updated: string option;
  (**
     The date and time (timestamp) when the vulnerability record was last
     updated.
  *)
  rejected: string option;
  (**
     The date and time (timestamp) when the vulnerability record was
     rejected (if applicable).
  *)
  credits: vulnerabilityCredits option;
  (**
     Individuals or organizations credited with the discovery of the
     vulnerability.
  *)
  tools: vulnerabilityTools option;  (** The tool(s) used to identify, confirm, or score the vulnerability. *)
  analysis: vulnerabilityAnalysis option;  (** An assessment of the impact and exploitability of the vulnerability. *)
  affects: vulnerabilityAffects list option;  (** The components or services that are affected by the vulnerability. *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_vulnerability ?bomref ?id ?source ?references ?ratings ?cwes ?description ?detail ?recommendation ?workaround ?proofOfConcept ?advisories ?created ?published ?updated ?rejected ?credits ?tools ?analysis ?affects ?properties () : vulnerability =
  { bomref; id; source; references; ratings; cwes; description; detail; recommendation; workaround; proofOfConcept; advisories; created; published; updated; rejected; credits; tools; analysis; affects; properties }

let vulnerability_of_yojson (x : Yojson.Safe.t) : vulnerability =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let id =
      match assoc "id" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let source =
      match assoc "source" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (vulnerabilitySource_of_yojson v)
    in
    let references =
      match assoc "references" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson vulnerabilityReferences_of_yojson) v)
    in
    let ratings =
      match assoc "ratings" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson rating_of_yojson) v)
    in
    let cwes =
      match assoc "cwes" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cwe_of_yojson) v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let detail =
      match assoc "detail" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let recommendation =
      match assoc "recommendation" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let workaround =
      match assoc "workaround" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let proofOfConcept =
      match assoc "proofOfConcept" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (vulnerabilityProofOfConcept_of_yojson v)
    in
    let advisories =
      match assoc "advisories" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson advisory_of_yojson) v)
    in
    let created =
      match assoc "created" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let published =
      match assoc "published" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let updated =
      match assoc "updated" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let rejected =
      match assoc "rejected" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let credits =
      match assoc "credits" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (vulnerabilityCredits_of_yojson v)
    in
    let tools =
      match assoc "tools" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (vulnerabilityTools_of_yojson v)
    in
    let analysis =
      match assoc "analysis" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (vulnerabilityAnalysis_of_yojson v)
    in
    let affects =
      match assoc "affects" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson vulnerabilityAffects_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { bomref; id; source; references; ratings; cwes; description; detail; recommendation; workaround; proofOfConcept; advisories; created; published; updated; rejected; credits; tools; analysis; affects; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "vulnerability" x

let yojson_of_vulnerability (x : vulnerability) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.id with None -> [] | Some v -> [("id", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.source with None -> [] | Some v -> [("source", yojson_of_vulnerabilitySource v)]);
    (match x.references with None -> [] | Some v -> [("references", (Atdml_runtime.Yojson.yojson_of_list yojson_of_vulnerabilityReferences) v)]);
    (match x.ratings with None -> [] | Some v -> [("ratings", (Atdml_runtime.Yojson.yojson_of_list yojson_of_rating) v)]);
    (match x.cwes with None -> [] | Some v -> [("cwes", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cwe) v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.detail with None -> [] | Some v -> [("detail", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.recommendation with None -> [] | Some v -> [("recommendation", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.workaround with None -> [] | Some v -> [("workaround", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.proofOfConcept with None -> [] | Some v -> [("proofOfConcept", yojson_of_vulnerabilityProofOfConcept v)]);
    (match x.advisories with None -> [] | Some v -> [("advisories", (Atdml_runtime.Yojson.yojson_of_list yojson_of_advisory) v)]);
    (match x.created with None -> [] | Some v -> [("created", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.published with None -> [] | Some v -> [("published", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.updated with None -> [] | Some v -> [("updated", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.rejected with None -> [] | Some v -> [("rejected", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.credits with None -> [] | Some v -> [("credits", yojson_of_vulnerabilityCredits v)]);
    (match x.tools with None -> [] | Some v -> [("tools", yojson_of_vulnerabilityTools v)]);
    (match x.analysis with None -> [] | Some v -> [("analysis", yojson_of_vulnerabilityAnalysis v)]);
    (match x.affects with None -> [] | Some v -> [("affects", (Atdml_runtime.Yojson.yojson_of_list yojson_of_vulnerabilityAffects) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let vulnerability_of_json s =
  vulnerability_of_yojson (Yojson.Safe.from_string s)

let json_of_vulnerability x =
  Yojson.Safe.to_string (yojson_of_vulnerability x)

module Vulnerability = struct
  type nonrec t = vulnerability
  let create = create_vulnerability
  let of_yojson = vulnerability_of_yojson
  let to_yojson = yojson_of_vulnerability
  let of_json = vulnerability_of_json
  let to_json = json_of_vulnerability
end

(**
   A version range specified in Package URL Version Range syntax (vers)
   which is defined at https://github.com/package-url/vers-spec
*)
type versionRange = string

let create_versionRange (x : string) : versionRange = x


let versionRange_of_yojson (x : Yojson.Safe.t) : versionRange =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_versionRange (x : versionRange) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let versionRange_of_json s =
  versionRange_of_yojson (Yojson.Safe.from_string s)

let json_of_versionRange x =
  Yojson.Safe.to_string (yojson_of_versionRange x)

module VersionRange = struct
  type nonrec t = versionRange
  let create = create_versionRange
  let of_yojson = versionRange_of_yojson
  let to_yojson = yojson_of_versionRange
  let of_json = versionRange_of_json
  let to_json = json_of_versionRange
end

type standardRequirements = {
  bomref: refType option;
  identifier: string option;
  (**
     The unique identifier used in the standard to identify a specific
     requirement. This should match what is in the standard and should not
     be the requirements bom-ref.
  *)
  title: string option;  (** The title of the requirement. *)
  text: string option;  (** The textual content of the requirement. *)
  descriptions: string list option;
  (**
     The supplemental text that provides additional guidance or context to
     the requirement, but is not directly part of the requirement.
  *)
  openCre: string list option;
  (**
     The Common Requirements Enumeration (CRE) identifier(s). CRE is a
     structured and standardized framework for uniting security standards
     and guidelines. CRE links each section of a resource to a shared topic
     identifier (a Common Requirement). Through this shared topic link, all
     resources map to each other. Use of CRE promotes clear and unambiguous
     communication among stakeholders.
  *)
  parent: refLinkType option;
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant, but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
}

let create_standardRequirements ?bomref ?identifier ?title ?text ?descriptions ?openCre ?parent ?properties ?externalReferences () : standardRequirements =
  { bomref; identifier; title; text; descriptions; openCre; parent; properties; externalReferences }

let standardRequirements_of_yojson (x : Yojson.Safe.t) : standardRequirements =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let identifier =
      match assoc "identifier" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let title =
      match assoc "title" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let text =
      match assoc "text" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let descriptions =
      match assoc "descriptions" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let openCre =
      match assoc "openCre" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let parent =
      match assoc "parent" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refLinkType_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    { bomref; identifier; title; text; descriptions; openCre; parent; properties; externalReferences }
  | _ -> Atdml_runtime.Yojson.bad_type "standardRequirements" x

let yojson_of_standardRequirements (x : standardRequirements) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.identifier with None -> [] | Some v -> [("identifier", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.title with None -> [] | Some v -> [("title", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.text with None -> [] | Some v -> [("text", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.descriptions with None -> [] | Some v -> [("descriptions", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.openCre with None -> [] | Some v -> [("openCre", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.parent with None -> [] | Some v -> [("parent", yojson_of_refLinkType v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
  ])

let standardRequirements_of_json s =
  standardRequirements_of_yojson (Yojson.Safe.from_string s)

let json_of_standardRequirements x =
  Yojson.Safe.to_string (yojson_of_standardRequirements x)

module StandardRequirements = struct
  type nonrec t = standardRequirements
  let create = create_standardRequirements
  let of_yojson = standardRequirements_of_yojson
  let to_yojson = yojson_of_standardRequirements
  let of_json = standardRequirements_of_json
  let to_json = json_of_standardRequirements
end

type standardLevels = {
  bomref: refType option;
  identifier: string option;  (** The identifier used in the standard to identify a specific level. *)
  title: string option;  (** The title of the level. *)
  description: string option;  (** The description of the level. *)
  requirements: refLinkType list option;  (** The list of requirement `bom-ref`s that comprise the level. *)
}

let create_standardLevels ?bomref ?identifier ?title ?description ?requirements () : standardLevels =
  { bomref; identifier; title; description; requirements }

let standardLevels_of_yojson (x : Yojson.Safe.t) : standardLevels =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let identifier =
      match assoc "identifier" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let title =
      match assoc "title" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let requirements =
      match assoc "requirements" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    { bomref; identifier; title; description; requirements }
  | _ -> Atdml_runtime.Yojson.bad_type "standardLevels" x

let yojson_of_standardLevels (x : standardLevels) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.identifier with None -> [] | Some v -> [("identifier", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.title with None -> [] | Some v -> [("title", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.requirements with None -> [] | Some v -> [("requirements", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
  ])

let standardLevels_of_json s =
  standardLevels_of_yojson (Yojson.Safe.from_string s)

let json_of_standardLevels x =
  Yojson.Safe.to_string (yojson_of_standardLevels x)

module StandardLevels = struct
  type nonrec t = standardLevels
  let create = create_standardLevels
  let of_yojson = standardLevels_of_yojson
  let to_yojson = yojson_of_standardLevels
  let of_json = standardLevels_of_json
  let to_json = json_of_standardLevels
end

(**
   A standard may consist of regulations, industry or
   organizational-specific standards, maturity models, best practices, or
   any other requirements which can be evaluated against or attested to.
*)
type standard = {
  bomref: refType option;
  name: string option;
  (**
     The name of the standard. This will often be a shortened, single name
     of the standard.
  *)
  version: string option;  (** The version of the standard. *)
  description: string option;  (** The description of the standard. *)
  owner: string option;
  (**
     The owner of the standard, often the entity responsible for its
     release.
  *)
  requirements: standardRequirements list option;  (** The list of requirements comprising the standard. *)
  levels: standardLevels list option;
  (**
     The list of levels associated with the standard. Some standards have
     different levels of compliance.
  *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
  signature: signature option;
}

let create_standard ?bomref ?name ?version ?description ?owner ?requirements ?levels ?externalReferences ?signature () : standard =
  { bomref; name; version; description; owner; requirements; levels; externalReferences; signature }

let standard_of_yojson (x : Yojson.Safe.t) : standard =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let version =
      match assoc "version" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let owner =
      match assoc "owner" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let requirements =
      match assoc "requirements" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson standardRequirements_of_yojson) v)
    in
    let levels =
      match assoc "levels" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson standardLevels_of_yojson) v)
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { bomref; name; version; description; owner; requirements; levels; externalReferences; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "standard" x

let yojson_of_standard (x : standard) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.version with None -> [] | Some v -> [("version", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.owner with None -> [] | Some v -> [("owner", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.requirements with None -> [] | Some v -> [("requirements", (Atdml_runtime.Yojson.yojson_of_list yojson_of_standardRequirements) v)]);
    (match x.levels with None -> [] | Some v -> [("levels", (Atdml_runtime.Yojson.yojson_of_list yojson_of_standardLevels) v)]);
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let standard_of_json s =
  standard_of_yojson (Yojson.Safe.from_string s)

let json_of_standard x =
  Yojson.Safe.to_string (yojson_of_standard x)

module Standard = struct
  type nonrec t = standard
  let create = create_standard
  let of_yojson = standard_of_yojson
  let to_yojson = yojson_of_standard
  let of_json = standard_of_json
  let to_json = json_of_standard
end

(** Deprecated definition. use definition `versionRange` instead. *)
type range = json_

let range_of_yojson (x : Yojson.Safe.t) : range =
  json__of_yojson x

let yojson_of_range (x : range) : Yojson.Safe.t =
  yojson_of_json_ x

let range_of_json s =
  range_of_yojson (Yojson.Safe.from_string s)

let json_of_range x =
  Yojson.Safe.to_string (yojson_of_range x)

module Range = struct
  type nonrec t = range
  let of_yojson = range_of_yojson
  let to_yojson = yojson_of_range
  let of_json = range_of_json
  let to_json = json_of_range
end

(** A representation of a functional parameter. *)
type parameter = {
  name: string option;  (** The name of the parameter. *)
  value: string option;  (** The value of the parameter. *)
  dataType: string option;  (** The data type of the parameter. *)
}

let create_parameter ?name ?value ?dataType () : parameter =
  { name; value; dataType }

let parameter_of_yojson (x : Yojson.Safe.t) : parameter =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let value =
      match assoc "value" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let dataType =
      match assoc "dataType" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { name; value; dataType }
  | _ -> Atdml_runtime.Yojson.bad_type "parameter" x

let yojson_of_parameter (x : parameter) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.value with None -> [] | Some v -> [("value", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.dataType with None -> [] | Some v -> [("dataType", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let parameter_of_json s =
  parameter_of_yojson (Yojson.Safe.from_string s)

let json_of_parameter x =
  Yojson.Safe.to_string (yojson_of_parameter x)

module Parameter = struct
  type nonrec t = parameter
  let create = create_parameter
  let of_yojson = parameter_of_yojson
  let to_yojson = yojson_of_parameter
  let of_json = parameter_of_json
  let to_json = json_of_parameter
end

(**
   The tool(s) used in the creation, enrichment, and validation of the
   BOM.
*)
type metadataToolsTools = {
  components: component list option;  (** A list of software and hardware components used as tools. *)
  services: service list option;
  (**
     A list of services used as tools. This may include microservices,
     function-as-a-service, and other types of network or intra-process
     services.
  *)
}

let create_metadataToolsTools ?components ?services () : metadataToolsTools =
  { components; services }

let metadataToolsTools_of_yojson (x : Yojson.Safe.t) : metadataToolsTools =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let components =
      match assoc "components" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let services =
      match assoc "services" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson service_of_yojson) v)
    in
    { components; services }
  | _ -> Atdml_runtime.Yojson.bad_type "metadataToolsTools" x

let yojson_of_metadataToolsTools (x : metadataToolsTools) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.components with None -> [] | Some v -> [("components", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.services with None -> [] | Some v -> [("services", (Atdml_runtime.Yojson.yojson_of_list yojson_of_service) v)]);
  ])

let metadataToolsTools_of_json s =
  metadataToolsTools_of_yojson (Yojson.Safe.from_string s)

let json_of_metadataToolsTools x =
  Yojson.Safe.to_string (yojson_of_metadataToolsTools x)

module MetadataToolsTools = struct
  type nonrec t = metadataToolsTools
  let create = create_metadataToolsTools
  let of_yojson = metadataToolsTools_of_yojson
  let to_yojson = yojson_of_metadataToolsTools
  let of_json = metadataToolsTools_of_json
  let to_json = json_of_metadataToolsTools
end

(**
   The tool(s) used in the creation, enrichment, and validation of the
   BOM.
*)
type metadataTools =
  | Tools of metadataToolsTools
  | ToolList of tool list

let metadataTools_of_yojson (x : Yojson.Safe.t) : metadataTools =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "Tools"; v] -> Tools (metadataToolsTools_of_yojson v)
  | `List [`String "ToolList"; v] -> ToolList ((Atdml_runtime.Yojson.list_of_yojson tool_of_yojson) v)
  | _ -> Atdml_runtime.Yojson.bad_sum "metadataTools" x

let yojson_of_metadataTools (x : metadataTools) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | Tools v -> `List [`String "Tools"; yojson_of_metadataToolsTools v]
    | ToolList v -> `List [`String "ToolList"; (Atdml_runtime.Yojson.yojson_of_list yojson_of_tool) v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let metadataTools_of_json s =
  metadataTools_of_yojson (Yojson.Safe.from_string s)

let json_of_metadataTools x =
  Yojson.Safe.to_string (yojson_of_metadataTools x)

module MetadataTools = struct
  type nonrec t = metadataTools
  let of_yojson = metadataTools_of_yojson
  let to_yojson = yojson_of_metadataTools
  let of_json = metadataTools_of_json
  let to_json = json_of_metadataTools
end

(** The product lifecycle(s) that this BOM represents. *)
type metadataLifecycles =
  | Jsonmetadatalifecycles_1 of json_
  | Jsonmetadatalifecycles_2 of json_

let metadataLifecycles_of_yojson (x : Yojson.Safe.t) : metadataLifecycles =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "Jsonmetadatalifecycles_1"; v] -> Jsonmetadatalifecycles_1 (json__of_yojson v)
  | `List [`String "Jsonmetadatalifecycles_2"; v] -> Jsonmetadatalifecycles_2 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "metadataLifecycles" x

let yojson_of_metadataLifecycles (x : metadataLifecycles) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | Jsonmetadatalifecycles_1 v -> `List [`String "Jsonmetadatalifecycles_1"; yojson_of_json_ v]
    | Jsonmetadatalifecycles_2 v -> `List [`String "Jsonmetadatalifecycles_2"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let metadataLifecycles_of_json s =
  metadataLifecycles_of_yojson (Yojson.Safe.from_string s)

let json_of_metadataLifecycles x =
  Yojson.Safe.to_string (yojson_of_metadataLifecycles x)

module MetadataLifecycles = struct
  type nonrec t = metadataLifecycles
  let of_yojson = metadataLifecycles_of_yojson
  let to_yojson = yojson_of_metadataLifecycles
  let of_json = metadataLifecycles_of_json
  let to_json = json_of_metadataLifecycles
end

type metadata = {
  timestamp: string option;  (** The date and time (timestamp) when the BOM was created. *)
  lifecycles: metadataLifecycles list option;
  (**
     Lifecycles communicate the stage(s) in which data in the BOM was
     captured. Different types of data may be available at various phases
     of a lifecycle, such as the Software Development Lifecycle (SDLC), IT
     Asset Management (ITAM), and Software Asset Management (SAM). Thus, a
     BOM may include data specific to or only obtainable in a given
     lifecycle.
  *)
  tools: metadataTools option;
  (**
     The tool(s) used in the creation, enrichment, and validation of the
     BOM.
  *)
  manufacturer: organizationalEntity option;
  authors: organizationalContact list option;
  (**
     The person(s) who created the BOM. Authors are common in BOMs created
     through manual processes. BOMs created through automated means may
     have `\@.manufacturer` instead.
  *)
  component: component option;
  manufacture: organizationalEntity option;
  supplier: organizationalEntity option;
  licenses: licenseChoice option;
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_metadata ?timestamp ?lifecycles ?tools ?manufacturer ?authors ?component ?manufacture ?supplier ?licenses ?properties () : metadata =
  { timestamp; lifecycles; tools; manufacturer; authors; component; manufacture; supplier; licenses; properties }

let metadata_of_yojson (x : Yojson.Safe.t) : metadata =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let timestamp =
      match assoc "timestamp" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let lifecycles =
      match assoc "lifecycles" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson metadataLifecycles_of_yojson) v)
    in
    let tools =
      match assoc "tools" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (metadataTools_of_yojson v)
    in
    let manufacturer =
      match assoc "manufacturer" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalEntity_of_yojson v)
    in
    let authors =
      match assoc "authors" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson organizationalContact_of_yojson) v)
    in
    let component =
      match assoc "component" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (component_of_yojson v)
    in
    let manufacture =
      match assoc "manufacture" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalEntity_of_yojson v)
    in
    let supplier =
      match assoc "supplier" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalEntity_of_yojson v)
    in
    let licenses =
      match assoc "licenses" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (licenseChoice_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { timestamp; lifecycles; tools; manufacturer; authors; component; manufacture; supplier; licenses; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "metadata" x

let yojson_of_metadata (x : metadata) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.timestamp with None -> [] | Some v -> [("timestamp", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.lifecycles with None -> [] | Some v -> [("lifecycles", (Atdml_runtime.Yojson.yojson_of_list yojson_of_metadataLifecycles) v)]);
    (match x.tools with None -> [] | Some v -> [("tools", yojson_of_metadataTools v)]);
    (match x.manufacturer with None -> [] | Some v -> [("manufacturer", yojson_of_organizationalEntity v)]);
    (match x.authors with None -> [] | Some v -> [("authors", (Atdml_runtime.Yojson.yojson_of_list yojson_of_organizationalContact) v)]);
    (match x.component with None -> [] | Some v -> [("component", yojson_of_component v)]);
    (match x.manufacture with None -> [] | Some v -> [("manufacture", yojson_of_organizationalEntity v)]);
    (match x.supplier with None -> [] | Some v -> [("supplier", yojson_of_organizationalEntity v)]);
    (match x.licenses with None -> [] | Some v -> [("licenses", yojson_of_licenseChoice v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let metadata_of_json s =
  metadata_of_yojson (Yojson.Safe.from_string s)

let json_of_metadata x =
  Yojson.Safe.to_string (yojson_of_metadata x)

module Metadata = struct
  type nonrec t = metadata
  let create = create_metadata
  let of_yojson = metadata_of_yojson
  let to_yojson = yojson_of_metadata
  let of_json = metadata_of_json
  let to_json = json_of_metadata
end

type licenseChoiceItems = {
  license: license;
}

let create_licenseChoiceItems ~license () : licenseChoiceItems =
  { license }

let licenseChoiceItems_of_yojson (x : Yojson.Safe.t) : licenseChoiceItems =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let license =
      match assoc "license" with
      | Some v -> license_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "licenseChoiceItems" "license"
    in
    { license }
  | _ -> Atdml_runtime.Yojson.bad_type "licenseChoiceItems" x

let yojson_of_licenseChoiceItems (x : licenseChoiceItems) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("license", yojson_of_license x.license)];
  ])

let licenseChoiceItems_of_json s =
  licenseChoiceItems_of_yojson (Yojson.Safe.from_string s)

let json_of_licenseChoiceItems x =
  Yojson.Safe.to_string (yojson_of_licenseChoiceItems x)

module LicenseChoiceItems = struct
  type nonrec t = licenseChoiceItems
  let create = create_licenseChoiceItems
  let of_yojson = licenseChoiceItems_of_yojson
  let to_yojson = yojson_of_licenseChoiceItems
  let of_json = licenseChoiceItems_of_json
  let to_json = json_of_licenseChoiceItems
end

(**
   Declared licenses and concluded licenses represent two different
   stages in the licensing process within software development. Declared
   licenses refer to the initial intention of the software authors
   regarding the licensing terms under which their code is released. On
   the other hand, concluded licenses are the result of a comprehensive
   analysis of the project's codebase to identify and confirm the actual
   licenses of the components used, which may differ from the initially
   declared licenses. While declared licenses provide an upfront
   indication of the licensing intentions, concluded licenses offer a
   more thorough understanding of the actual licensing within a project,
   facilitating proper compliance and risk management. Observed licenses
   are defined in `\@.evidence.licenses`. Observed licenses form the
   evidence necessary to substantiate a concluded license.
*)
type licenseAcknowledgementEnumeration =
  | Declared
  | Concluded

let licenseAcknowledgementEnumeration_of_yojson (x : Yojson.Safe.t) : licenseAcknowledgementEnumeration =
  match x with
  | `String "declared" -> Declared
  | `String "concluded" -> Concluded
  | _ -> Atdml_runtime.Yojson.bad_sum "licenseAcknowledgementEnumeration" x

let yojson_of_licenseAcknowledgementEnumeration (x : licenseAcknowledgementEnumeration) : Yojson.Safe.t =
  match x with
  | Declared -> `String "declared"
  | Concluded -> `String "concluded"

let licenseAcknowledgementEnumeration_of_json s =
  licenseAcknowledgementEnumeration_of_yojson (Yojson.Safe.from_string s)

let json_of_licenseAcknowledgementEnumeration x =
  Yojson.Safe.to_string (yojson_of_licenseAcknowledgementEnumeration x)

module LicenseAcknowledgementEnumeration = struct
  type nonrec t = licenseAcknowledgementEnumeration
  let of_yojson = licenseAcknowledgementEnumeration_of_yojson
  let to_yojson = yojson_of_licenseAcknowledgementEnumeration
  let of_json = licenseAcknowledgementEnumeration_of_json
  let to_json = json_of_licenseAcknowledgementEnumeration
end

type int64 = int

let create_int64 (x : int) : int64 = x


let int64_of_yojson (x : Yojson.Safe.t) : int64 =
  Atdml_runtime.Yojson.int_of_yojson x

let yojson_of_int64 (x : int64) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_int x

let int64_of_json s =
  int64_of_yojson (Yojson.Safe.from_string s)

let json_of_int64 x =
  Yojson.Safe.to_string (yojson_of_int64 x)

module Int64 = struct
  type nonrec t = int64
  let create = create_int64
  let of_yojson = int64_of_yojson
  let to_yojson = yojson_of_int64
  let of_json = int64_of_json
  let to_json = json_of_int64
end

(**
   Describes workflows and resources that captures rules and other
   aspects of how the associated BOM component or service was formed.
*)
type formula = {
  bomref: refType option;
  components: component list option;
  (**
     Transient components that are used in tasks that constitute one or
     more of this formula's workflows
  *)
  services: service list option;
  (**
     Transient services that are used in tasks that constitute one or more
     of this formula's workflows
  *)
  workflows: workflow list option;
  (**
     List of workflows that can be declared to accomplish specific
     orchestrated goals and independently triggered.
  *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
}

let create_formula ?bomref ?components ?services ?workflows ?properties () : formula =
  { bomref; components; services; workflows; properties }

let formula_of_yojson (x : Yojson.Safe.t) : formula =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let components =
      match assoc "components" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let services =
      match assoc "services" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson service_of_yojson) v)
    in
    let workflows =
      match assoc "workflows" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson workflow_of_yojson) v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    { bomref; components; services; workflows; properties }
  | _ -> Atdml_runtime.Yojson.bad_type "formula" x

let yojson_of_formula (x : formula) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.components with None -> [] | Some v -> [("components", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.services with None -> [] | Some v -> [("services", (Atdml_runtime.Yojson.yojson_of_list yojson_of_service) v)]);
    (match x.workflows with None -> [] | Some v -> [("workflows", (Atdml_runtime.Yojson.yojson_of_list yojson_of_workflow) v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
  ])

let formula_of_json s =
  formula_of_yojson (Yojson.Safe.from_string s)

let json_of_formula x =
  Yojson.Safe.to_string (yojson_of_formula x)

module Formula = struct
  type nonrec t = formula
  let create = create_formula
  let of_yojson = formula_of_yojson
  let to_yojson = yojson_of_formula
  let of_json = formula_of_json
  let to_json = json_of_formula
end

(**
   A collection of reusable objects that are defined and may be used
   elsewhere in the BOM.
*)
type cycloneDXBillofMaterialsStandardDefinitions = {
  standards: standard list option;
  (**
     The list of standards which may consist of regulations, industry or
     organizational-specific standards, maturity models, best practices, or
     any other requirements which can be evaluated against or attested to.
  *)
}

let create_cycloneDXBillofMaterialsStandardDefinitions ?standards () : cycloneDXBillofMaterialsStandardDefinitions =
  { standards }

let cycloneDXBillofMaterialsStandardDefinitions_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDefinitions =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let standards =
      match assoc "standards" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson standard_of_yojson) v)
    in
    { standards }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDefinitions" x

let yojson_of_cycloneDXBillofMaterialsStandardDefinitions (x : cycloneDXBillofMaterialsStandardDefinitions) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.standards with None -> [] | Some v -> [("standards", (Atdml_runtime.Yojson.yojson_of_list yojson_of_standard) v)]);
  ])

let cycloneDXBillofMaterialsStandardDefinitions_of_json s =
  cycloneDXBillofMaterialsStandardDefinitions_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDefinitions x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDefinitions x)

module CycloneDXBillofMaterialsStandardDefinitions = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDefinitions
  let create = create_cycloneDXBillofMaterialsStandardDefinitions
  let of_yojson = cycloneDXBillofMaterialsStandardDefinitions_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDefinitions
  let of_json = cycloneDXBillofMaterialsStandardDefinitions_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDefinitions
end

(** The list of targets which claims are made against. *)
type cycloneDXBillofMaterialsStandardDeclarationsTargets = {
  organizations: organizationalEntity list option;  (** The list of organizations which claims are made against. *)
  components: component list option;  (** The list of components which claims are made against. *)
  services: service list option;  (** The list of services which claims are made against. *)
}

let create_cycloneDXBillofMaterialsStandardDeclarationsTargets ?organizations ?components ?services () : cycloneDXBillofMaterialsStandardDeclarationsTargets =
  { organizations; components; services }

let cycloneDXBillofMaterialsStandardDeclarationsTargets_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsTargets =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let organizations =
      match assoc "organizations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson organizationalEntity_of_yojson) v)
    in
    let components =
      match assoc "components" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let services =
      match assoc "services" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson service_of_yojson) v)
    in
    { organizations; components; services }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsTargets" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsTargets (x : cycloneDXBillofMaterialsStandardDeclarationsTargets) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.organizations with None -> [] | Some v -> [("organizations", (Atdml_runtime.Yojson.yojson_of_list yojson_of_organizationalEntity) v)]);
    (match x.components with None -> [] | Some v -> [("components", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.services with None -> [] | Some v -> [("services", (Atdml_runtime.Yojson.yojson_of_list yojson_of_service) v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsTargets_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsTargets_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsTargets x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsTargets x)

module CycloneDXBillofMaterialsStandardDeclarationsTargets = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsTargets
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsTargets
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsTargets_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsTargets
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsTargets_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsTargets
end

(**
   The contents or references to the contents of the data being
   described.
*)
type cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents = {
  attachment: attachment option;
  url: string option;  (** The URL to where the data can be retrieved. *)
}

let create_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents ?attachment ?url () : cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents =
  { attachment; url }

let cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let attachment =
      match assoc "attachment" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (attachment_of_yojson v)
    in
    let url =
      match assoc "url" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { attachment; url }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents (x : cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.attachment with None -> [] | Some v -> [("attachment", yojson_of_attachment v)]);
    (match x.url with None -> [] | Some v -> [("url", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents x)

module CycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
end

type cycloneDXBillofMaterialsStandardDeclarationsEvidenceData = {
  name: string option;  (** The name of the data. *)
  contents: cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents option;
  (**
     The contents or references to the contents of the data being
     described.
  *)
  classification: dataClassification option;
  sensitiveData: string list option;  (** A description of any sensitive data included. *)
  governance: dataGovernance option;
}

let create_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData ?name ?contents ?classification ?sensitiveData ?governance () : cycloneDXBillofMaterialsStandardDeclarationsEvidenceData =
  { name; contents; classification; sensitiveData; governance }

let cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsEvidenceData =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let name =
      match assoc "name" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let contents =
      match assoc "contents" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_yojson v)
    in
    let classification =
      match assoc "classification" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (dataClassification_of_yojson v)
    in
    let sensitiveData =
      match assoc "sensitiveData" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let governance =
      match assoc "governance" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (dataGovernance_of_yojson v)
    in
    { name; contents; classification; sensitiveData; governance }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsEvidenceData" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData (x : cycloneDXBillofMaterialsStandardDeclarationsEvidenceData) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.name with None -> [] | Some v -> [("name", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.contents with None -> [] | Some v -> [("contents", yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents v)]);
    (match x.classification with None -> [] | Some v -> [("classification", yojson_of_dataClassification v)]);
    (match x.sensitiveData with None -> [] | Some v -> [("sensitiveData", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.governance with None -> [] | Some v -> [("governance", yojson_of_dataGovernance v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData x)

module CycloneDXBillofMaterialsStandardDeclarationsEvidenceData = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
end

type cycloneDXBillofMaterialsStandardDeclarationsEvidence = {
  bomref: refType option;
  propertyName: string option;
  (**
     The reference to the property name as defined in the \[CycloneDX
     Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy/).
  *)
  description: string option;
  (**
     The written description of what this evidence is and how it was
     created.
  *)
  data: cycloneDXBillofMaterialsStandardDeclarationsEvidenceData list option;  (** The output or analysis that supports claims. *)
  created: string option;  (** The date and time (timestamp) when the evidence was created. *)
  expires: string option;
  (**
     The optional date and time (timestamp) when the evidence is no longer
     valid.
  *)
  author: organizationalContact option;
  reviewer: organizationalContact option;
  signature: signature option;
}

let create_cycloneDXBillofMaterialsStandardDeclarationsEvidence ?bomref ?propertyName ?description ?data ?created ?expires ?author ?reviewer ?signature () : cycloneDXBillofMaterialsStandardDeclarationsEvidence =
  { bomref; propertyName; description; data; created; expires; author; reviewer; signature }

let cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsEvidence =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let propertyName =
      match assoc "propertyName" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let data =
      match assoc "data" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_yojson) v)
    in
    let created =
      match assoc "created" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let expires =
      match assoc "expires" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let author =
      match assoc "author" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalContact_of_yojson v)
    in
    let reviewer =
      match assoc "reviewer" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalContact_of_yojson v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { bomref; propertyName; description; data; created; expires; author; reviewer; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsEvidence" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence (x : cycloneDXBillofMaterialsStandardDeclarationsEvidence) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.propertyName with None -> [] | Some v -> [("propertyName", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.data with None -> [] | Some v -> [("data", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData) v)]);
    (match x.created with None -> [] | Some v -> [("created", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.expires with None -> [] | Some v -> [("expires", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.author with None -> [] | Some v -> [("author", yojson_of_organizationalContact v)]);
    (match x.reviewer with None -> [] | Some v -> [("reviewer", yojson_of_organizationalContact v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence x)

module CycloneDXBillofMaterialsStandardDeclarationsEvidence = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsEvidence
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsEvidence
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence
end

type cycloneDXBillofMaterialsStandardDeclarationsClaims = {
  bomref: refType option;
  target: refLinkType option;
  predicate: string option;  (** The specific statement or assertion about the target. *)
  mitigationStrategies: refLinkType list option;
  (**
     The list of `bom-ref` to the evidence provided describing the
     mitigation strategies. Each mitigation strategy should include an
     explanation of how any weaknesses in the evidence will be mitigated.
  *)
  reasoning: string option;
  (**
     The written explanation of why the evidence provided substantiates the
     claim.
  *)
  evidence: refLinkType list option;  (** The list of `bom-ref` to evidence that supports this claim. *)
  counterEvidence: refLinkType list option;  (** The list of `bom-ref` to counterEvidence that supports this claim. *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
  signature: signature option;
}

let create_cycloneDXBillofMaterialsStandardDeclarationsClaims ?bomref ?target ?predicate ?mitigationStrategies ?reasoning ?evidence ?counterEvidence ?externalReferences ?signature () : cycloneDXBillofMaterialsStandardDeclarationsClaims =
  { bomref; target; predicate; mitigationStrategies; reasoning; evidence; counterEvidence; externalReferences; signature }

let cycloneDXBillofMaterialsStandardDeclarationsClaims_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsClaims =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let target =
      match assoc "target" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refLinkType_of_yojson v)
    in
    let predicate =
      match assoc "predicate" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let mitigationStrategies =
      match assoc "mitigationStrategies" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    let reasoning =
      match assoc "reasoning" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let evidence =
      match assoc "evidence" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    let counterEvidence =
      match assoc "counterEvidence" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { bomref; target; predicate; mitigationStrategies; reasoning; evidence; counterEvidence; externalReferences; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsClaims" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsClaims (x : cycloneDXBillofMaterialsStandardDeclarationsClaims) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.target with None -> [] | Some v -> [("target", yojson_of_refLinkType v)]);
    (match x.predicate with None -> [] | Some v -> [("predicate", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.mitigationStrategies with None -> [] | Some v -> [("mitigationStrategies", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
    (match x.reasoning with None -> [] | Some v -> [("reasoning", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.evidence with None -> [] | Some v -> [("evidence", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
    (match x.counterEvidence with None -> [] | Some v -> [("counterEvidence", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsClaims_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsClaims_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsClaims x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsClaims x)

module CycloneDXBillofMaterialsStandardDeclarationsClaims = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsClaims
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsClaims
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsClaims_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsClaims
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsClaims_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsClaims
end

(** The conformance of the claim meeting a requirement. *)
type cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance = {
  score: float option;
  (**
     The conformance of the claim between and inclusive of 0 and 1, where 1
     is 100% conformance.
  *)
  rationale: string option;  (** The rationale for the conformance score. *)
  mitigationStrategies: refLinkType list option;
  (**
     The list of `bom-ref` to the evidence provided describing the
     mitigation strategies.
  *)
}

let create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance ?score ?rationale ?mitigationStrategies () : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance =
  { score; rationale; mitigationStrategies }

let cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let score =
      match assoc "score" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.float_of_yojson v)
    in
    let rationale =
      match assoc "rationale" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let mitigationStrategies =
      match assoc "mitigationStrategies" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    { score; rationale; mitigationStrategies }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance (x : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.score with None -> [] | Some v -> [("score", Atdml_runtime.Yojson.yojson_of_float v)]);
    (match x.rationale with None -> [] | Some v -> [("rationale", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.mitigationStrategies with None -> [] | Some v -> [("mitigationStrategies", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance x)

module CycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
end

(** The confidence of the claim meeting the requirement. *)
type cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence = {
  score: float option;
  (**
     The confidence of the claim between and inclusive of 0 and 1, where 1
     is 100% confidence.
  *)
  rationale: string option;  (** The rationale for the confidence score. *)
}

let create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence ?score ?rationale () : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence =
  { score; rationale }

let cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let score =
      match assoc "score" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.float_of_yojson v)
    in
    let rationale =
      match assoc "rationale" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { score; rationale }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence (x : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.score with None -> [] | Some v -> [("score", Atdml_runtime.Yojson.yojson_of_float v)]);
    (match x.rationale with None -> [] | Some v -> [("rationale", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence x)

module CycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
end

type cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap = {
  requirement: refLinkType option;
  claims: refLinkType list option;  (** The list of `bom-ref` to the claims being attested to. *)
  counterClaims: refLinkType list option;  (** The list of `bom-ref` to the counter claims being attested to. *)
  conformance: cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance option;  (** The conformance of the claim meeting a requirement. *)
  confidence: cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence option;  (** The confidence of the claim meeting the requirement. *)
}

let create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap ?requirement ?claims ?counterClaims ?conformance ?confidence () : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap =
  { requirement; claims; counterClaims; conformance; confidence }

let cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let requirement =
      match assoc "requirement" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refLinkType_of_yojson v)
    in
    let claims =
      match assoc "claims" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    let counterClaims =
      match assoc "counterClaims" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson refLinkType_of_yojson) v)
    in
    let conformance =
      match assoc "conformance" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_yojson v)
    in
    let confidence =
      match assoc "confidence" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_yojson v)
    in
    { requirement; claims; counterClaims; conformance; confidence }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap (x : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.requirement with None -> [] | Some v -> [("requirement", yojson_of_refLinkType v)]);
    (match x.claims with None -> [] | Some v -> [("claims", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
    (match x.counterClaims with None -> [] | Some v -> [("counterClaims", (Atdml_runtime.Yojson.yojson_of_list yojson_of_refLinkType) v)]);
    (match x.conformance with None -> [] | Some v -> [("conformance", yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance v)]);
    (match x.confidence with None -> [] | Some v -> [("confidence", yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap x)

module CycloneDXBillofMaterialsStandardDeclarationsAttestationsMap = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
end

type cycloneDXBillofMaterialsStandardDeclarationsAttestations = {
  summary: string option;  (** The short description explaining the main points of the attestation. *)
  assessor: refLinkType option;
  map: cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap list option;
  (**
     The grouping of requirements to claims and the attestors declared
     conformance and confidence thereof.
  *)
  signature: signature option;
}

let create_cycloneDXBillofMaterialsStandardDeclarationsAttestations ?summary ?assessor ?map ?signature () : cycloneDXBillofMaterialsStandardDeclarationsAttestations =
  { summary; assessor; map; signature }

let cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsAttestations =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let summary =
      match assoc "summary" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let assessor =
      match assoc "assessor" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refLinkType_of_yojson v)
    in
    let map =
      match assoc "map" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_yojson) v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { summary; assessor; map; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsAttestations" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations (x : cycloneDXBillofMaterialsStandardDeclarationsAttestations) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.summary with None -> [] | Some v -> [("summary", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.assessor with None -> [] | Some v -> [("assessor", yojson_of_refLinkType v)]);
    (match x.map with None -> [] | Some v -> [("map", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap) v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations x)

module CycloneDXBillofMaterialsStandardDeclarationsAttestations = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestations
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsAttestations
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations
end

(**
   The assessor who evaluates claims and determines conformance to
   requirements and confidence in that assessment.
*)
type cycloneDXBillofMaterialsStandardDeclarationsAssessors = {
  bomref: refType option;
  thirdParty: bool option;
  (**
     The boolean indicating if the assessor is outside the organization
     generating claims. A value of false indicates a self assessor.
  *)
  organization: organizationalEntity option;
}

let create_cycloneDXBillofMaterialsStandardDeclarationsAssessors ?bomref ?thirdParty ?organization () : cycloneDXBillofMaterialsStandardDeclarationsAssessors =
  { bomref; thirdParty; organization }

let cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsAssessors =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let thirdParty =
      match assoc "thirdParty" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let organization =
      match assoc "organization" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (organizationalEntity_of_yojson v)
    in
    { bomref; thirdParty; organization }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsAssessors" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors (x : cycloneDXBillofMaterialsStandardDeclarationsAssessors) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    (match x.thirdParty with None -> [] | Some v -> [("thirdParty", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.organization with None -> [] | Some v -> [("organization", yojson_of_organizationalEntity v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors x)

module CycloneDXBillofMaterialsStandardDeclarationsAssessors = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAssessors
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsAssessors
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors
end

type cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories =
  | JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_1 of json_
  | JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_2 of json_

let cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_1"; v] -> JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_1 (json__of_yojson v)
  | `List [`String "JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_2"; v] -> JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_2 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories (x : cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_1 v -> `List [`String "JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_1"; yojson_of_json_ v]
    | JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_2 v -> `List [`String "JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_2"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories x)

module CycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories
end

(**
   A concise statement affirmed by an individual regarding all
   declarations, often used for third-party auditor acceptance or
   recipient acknowledgment. It includes a list of authorized signatories
   who assert the validity of the document on behalf of the organization.
*)
type cycloneDXBillofMaterialsStandardDeclarationsAffirmation = {
  statement: string option;
  (**
     The brief statement affirmed by an individual regarding all
     declarations. *- Notes This could be an affirmation of acceptance by a
     third-party auditor or receiving individual of a file.
  *)
  signatories: cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories list option;
  (**
     The list of signatories authorized on behalf of an organization to
     assert validity of this document.
  *)
  signature: signature option;
}

let create_cycloneDXBillofMaterialsStandardDeclarationsAffirmation ?statement ?signatories ?signature () : cycloneDXBillofMaterialsStandardDeclarationsAffirmation =
  { statement; signatories; signature }

let cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarationsAffirmation =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let statement =
      match assoc "statement" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let signatories =
      match assoc "signatories" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_yojson) v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { statement; signatories; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarationsAffirmation" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation (x : cycloneDXBillofMaterialsStandardDeclarationsAffirmation) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.statement with None -> [] | Some v -> [("statement", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.signatories with None -> [] | Some v -> [("signatories", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories) v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_json s =
  cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation x)

module CycloneDXBillofMaterialsStandardDeclarationsAffirmation = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAffirmation
  let create = create_cycloneDXBillofMaterialsStandardDeclarationsAffirmation
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation
  let of_json = cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation
end

(**
   The list of declarations which describe the conformance to standards.
   Each declaration may include attestations, claims, and evidence.
*)
type cycloneDXBillofMaterialsStandardDeclarations = {
  assessors: cycloneDXBillofMaterialsStandardDeclarationsAssessors list option;
  (**
     The list of assessors evaluating claims and determining conformance to
     requirements and confidence in that assessment.
  *)
  attestations: cycloneDXBillofMaterialsStandardDeclarationsAttestations list option;
  (**
     The list of attestations asserted by an assessor that maps
     requirements to claims.
  *)
  claims: cycloneDXBillofMaterialsStandardDeclarationsClaims list option;  (** The list of claims. *)
  evidence: cycloneDXBillofMaterialsStandardDeclarationsEvidence list option;  (** The list of evidence *)
  targets: cycloneDXBillofMaterialsStandardDeclarationsTargets option;  (** The list of targets which claims are made against. *)
  affirmation: cycloneDXBillofMaterialsStandardDeclarationsAffirmation option;
  (**
     A concise statement affirmed by an individual regarding all
     declarations, often used for third-party auditor acceptance or
     recipient acknowledgment. It includes a list of authorized signatories
     who assert the validity of the document on behalf of the organization.
  *)
  signature: signature option;
}

let create_cycloneDXBillofMaterialsStandardDeclarations ?assessors ?attestations ?claims ?evidence ?targets ?affirmation ?signature () : cycloneDXBillofMaterialsStandardDeclarations =
  { assessors; attestations; claims; evidence; targets; affirmation; signature }

let cycloneDXBillofMaterialsStandardDeclarations_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardDeclarations =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let assessors =
      match assoc "assessors" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_yojson) v)
    in
    let attestations =
      match assoc "attestations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_yojson) v)
    in
    let claims =
      match assoc "claims" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cycloneDXBillofMaterialsStandardDeclarationsClaims_of_yojson) v)
    in
    let evidence =
      match assoc "evidence" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_yojson) v)
    in
    let targets =
      match assoc "targets" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cycloneDXBillofMaterialsStandardDeclarationsTargets_of_yojson v)
    in
    let affirmation =
      match assoc "affirmation" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_yojson v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { assessors; attestations; claims; evidence; targets; affirmation; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandardDeclarations" x

let yojson_of_cycloneDXBillofMaterialsStandardDeclarations (x : cycloneDXBillofMaterialsStandardDeclarations) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.assessors with None -> [] | Some v -> [("assessors", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors) v)]);
    (match x.attestations with None -> [] | Some v -> [("attestations", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations) v)]);
    (match x.claims with None -> [] | Some v -> [("claims", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cycloneDXBillofMaterialsStandardDeclarationsClaims) v)]);
    (match x.evidence with None -> [] | Some v -> [("evidence", (Atdml_runtime.Yojson.yojson_of_list yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence) v)]);
    (match x.targets with None -> [] | Some v -> [("targets", yojson_of_cycloneDXBillofMaterialsStandardDeclarationsTargets v)]);
    (match x.affirmation with None -> [] | Some v -> [("affirmation", yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let cycloneDXBillofMaterialsStandardDeclarations_of_json s =
  cycloneDXBillofMaterialsStandardDeclarations_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardDeclarations x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardDeclarations x)

module CycloneDXBillofMaterialsStandardDeclarations = struct
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarations
  let create = create_cycloneDXBillofMaterialsStandardDeclarations
  let of_yojson = cycloneDXBillofMaterialsStandardDeclarations_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardDeclarations
  let of_json = cycloneDXBillofMaterialsStandardDeclarations_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardDeclarations
end

(**
   Specifies the format of the BOM. This helps to identify the file as
   CycloneDX since BOMs do not have a filename convention, nor does JSON
   schema support namespaces. This value must be "CycloneDX".
*)
type cycloneDXBillofMaterialsStandardBomFormat =
  | CycloneDX

let cycloneDXBillofMaterialsStandardBomFormat_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandardBomFormat =
  match x with
  | `String "CycloneDX" -> CycloneDX
  | _ -> Atdml_runtime.Yojson.bad_sum "cycloneDXBillofMaterialsStandardBomFormat" x

let yojson_of_cycloneDXBillofMaterialsStandardBomFormat (x : cycloneDXBillofMaterialsStandardBomFormat) : Yojson.Safe.t =
  match x with
  | CycloneDX -> `String "CycloneDX"

let cycloneDXBillofMaterialsStandardBomFormat_of_json s =
  cycloneDXBillofMaterialsStandardBomFormat_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandardBomFormat x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandardBomFormat x)

module CycloneDXBillofMaterialsStandardBomFormat = struct
  type nonrec t = cycloneDXBillofMaterialsStandardBomFormat
  let of_yojson = cycloneDXBillofMaterialsStandardBomFormat_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandardBomFormat
  let of_json = cycloneDXBillofMaterialsStandardBomFormat_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandardBomFormat
end

type compositionsAssemblies =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

let compositionsAssemblies_of_yojson (x : Yojson.Safe.t) : compositionsAssemblies =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "RefLinkType"; v] -> RefLinkType (refLinkType_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "compositionsAssemblies" x

let yojson_of_compositionsAssemblies (x : compositionsAssemblies) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | RefLinkType v -> `List [`String "RefLinkType"; yojson_of_refLinkType v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let compositionsAssemblies_of_json s =
  compositionsAssemblies_of_yojson (Yojson.Safe.from_string s)

let json_of_compositionsAssemblies x =
  Yojson.Safe.to_string (yojson_of_compositionsAssemblies x)

module CompositionsAssemblies = struct
  type nonrec t = compositionsAssemblies
  let of_yojson = compositionsAssemblies_of_yojson
  let to_yojson = yojson_of_compositionsAssemblies
  let of_json = compositionsAssemblies_of_json
  let to_json = json_of_compositionsAssemblies
end

type aggregateType =
  | Complete
  | Incomplete
  | Incomplete_first_party_only
  | Incomplete_first_party_proprietary_only
  | Incomplete_first_party_opensource_only
  | Incomplete_third_party_only
  | Incomplete_third_party_proprietary_only
  | Incomplete_third_party_opensource_only
  | Unknown
  | Not_specified

let aggregateType_of_yojson (x : Yojson.Safe.t) : aggregateType =
  match x with
  | `String "complete" -> Complete
  | `String "incomplete" -> Incomplete
  | `String "incomplete_first_party_only" -> Incomplete_first_party_only
  | `String "incomplete_first_party_proprietary_only" -> Incomplete_first_party_proprietary_only
  | `String "incomplete_first_party_opensource_only" -> Incomplete_first_party_opensource_only
  | `String "incomplete_third_party_only" -> Incomplete_third_party_only
  | `String "incomplete_third_party_proprietary_only" -> Incomplete_third_party_proprietary_only
  | `String "incomplete_third_party_opensource_only" -> Incomplete_third_party_opensource_only
  | `String "unknown" -> Unknown
  | `String "not_specified" -> Not_specified
  | _ -> Atdml_runtime.Yojson.bad_sum "aggregateType" x

let yojson_of_aggregateType (x : aggregateType) : Yojson.Safe.t =
  match x with
  | Complete -> `String "complete"
  | Incomplete -> `String "incomplete"
  | Incomplete_first_party_only -> `String "incomplete_first_party_only"
  | Incomplete_first_party_proprietary_only -> `String "incomplete_first_party_proprietary_only"
  | Incomplete_first_party_opensource_only -> `String "incomplete_first_party_opensource_only"
  | Incomplete_third_party_only -> `String "incomplete_third_party_only"
  | Incomplete_third_party_proprietary_only -> `String "incomplete_third_party_proprietary_only"
  | Incomplete_third_party_opensource_only -> `String "incomplete_third_party_opensource_only"
  | Unknown -> `String "unknown"
  | Not_specified -> `String "not_specified"

let aggregateType_of_json s =
  aggregateType_of_yojson (Yojson.Safe.from_string s)

let json_of_aggregateType x =
  Yojson.Safe.to_string (yojson_of_aggregateType x)

module AggregateType = struct
  type nonrec t = aggregateType
  let of_yojson = aggregateType_of_yojson
  let to_yojson = yojson_of_aggregateType
  let of_json = aggregateType_of_json
  let to_json = json_of_aggregateType
end

type compositions = {
  bomref: refType option;
  aggregate: aggregateType;
  assemblies: compositionsAssemblies list option;
  (**
     The bom-ref identifiers of the components or services being described.
     Assemblies refer to nested relationships whereby a constituent part
     may include other constituent parts. References do not cascade to
     child parts. References are explicit for the specified constituent
     part only.
  *)
  dependencies: string list option;
  (**
     The bom-ref identifiers of the components or services being described.
     Dependencies refer to a relationship whereby an independent
     constituent part requires another independent constituent part.
     References do not cascade to transitive dependencies. References are
     explicit for the specified dependency only.
  *)
  vulnerabilities: string list option;  (** The bom-ref identifiers of the vulnerabilities being described. *)
  signature: signature option;
}

let create_compositions ?bomref ~aggregate ?assemblies ?dependencies ?vulnerabilities ?signature () : compositions =
  { bomref; aggregate; assemblies; dependencies; vulnerabilities; signature }

let compositions_of_yojson (x : Yojson.Safe.t) : compositions =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let aggregate =
      match assoc "aggregate" with
      | Some v -> aggregateType_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "compositions" "aggregate"
    in
    let assemblies =
      match assoc "assemblies" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson compositionsAssemblies_of_yojson) v)
    in
    let dependencies =
      match assoc "dependencies" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let vulnerabilities =
      match assoc "vulnerabilities" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { bomref; aggregate; assemblies; dependencies; vulnerabilities; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "compositions" x

let yojson_of_compositions (x : compositions) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    [("aggregate", yojson_of_aggregateType x.aggregate)];
    (match x.assemblies with None -> [] | Some v -> [("assemblies", (Atdml_runtime.Yojson.yojson_of_list yojson_of_compositionsAssemblies) v)]);
    (match x.dependencies with None -> [] | Some v -> [("dependencies", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.vulnerabilities with None -> [] | Some v -> [("vulnerabilities", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let compositions_of_json s =
  compositions_of_yojson (Yojson.Safe.from_string s)

let json_of_compositions x =
  Yojson.Safe.to_string (yojson_of_compositions x)

module Compositions = struct
  type nonrec t = compositions
  let create = create_compositions
  let of_yojson = compositions_of_yojson
  let to_yojson = yojson_of_compositions
  let of_json = compositions_of_json
  let to_json = json_of_compositions
end

type annotationsSubjects =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

let annotationsSubjects_of_yojson (x : Yojson.Safe.t) : annotationsSubjects =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "RefLinkType"; v] -> RefLinkType (refLinkType_of_yojson v)
  | `List [`String "BomLinkElementType"; v] -> BomLinkElementType (bomLinkElementType_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "annotationsSubjects" x

let yojson_of_annotationsSubjects (x : annotationsSubjects) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | RefLinkType v -> `List [`String "RefLinkType"; yojson_of_refLinkType v]
    | BomLinkElementType v -> `List [`String "BomLinkElementType"; yojson_of_bomLinkElementType v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let annotationsSubjects_of_json s =
  annotationsSubjects_of_yojson (Yojson.Safe.from_string s)

let json_of_annotationsSubjects x =
  Yojson.Safe.to_string (yojson_of_annotationsSubjects x)

module AnnotationsSubjects = struct
  type nonrec t = annotationsSubjects
  let of_yojson = annotationsSubjects_of_yojson
  let to_yojson = yojson_of_annotationsSubjects
  let of_json = annotationsSubjects_of_json
  let to_json = json_of_annotationsSubjects
end

(**
   The organization, person, component, or service which created the
   textual content of the annotation.
*)
type annotationsAnnotator =
  | Jsonannotationsannotator_1 of json_
  | Jsonannotationsannotator_2 of json_
  | Jsonannotationsannotator_3 of json_
  | Jsonannotationsannotator_4 of json_

let annotationsAnnotator_of_yojson (x : Yojson.Safe.t) : annotationsAnnotator =
  let x = Jsonschema2atd_runtime.Adapter.One_of.normalize x in
  match x with
  | `List [`String "Jsonannotationsannotator_1"; v] -> Jsonannotationsannotator_1 (json__of_yojson v)
  | `List [`String "Jsonannotationsannotator_2"; v] -> Jsonannotationsannotator_2 (json__of_yojson v)
  | `List [`String "Jsonannotationsannotator_3"; v] -> Jsonannotationsannotator_3 (json__of_yojson v)
  | `List [`String "Jsonannotationsannotator_4"; v] -> Jsonannotationsannotator_4 (json__of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "annotationsAnnotator" x

let yojson_of_annotationsAnnotator (x : annotationsAnnotator) : Yojson.Safe.t =
  let atdml_result =
    match x with
    | Jsonannotationsannotator_1 v -> `List [`String "Jsonannotationsannotator_1"; yojson_of_json_ v]
    | Jsonannotationsannotator_2 v -> `List [`String "Jsonannotationsannotator_2"; yojson_of_json_ v]
    | Jsonannotationsannotator_3 v -> `List [`String "Jsonannotationsannotator_3"; yojson_of_json_ v]
    | Jsonannotationsannotator_4 v -> `List [`String "Jsonannotationsannotator_4"; yojson_of_json_ v]
  in Jsonschema2atd_runtime.Adapter.One_of.restore atdml_result

let annotationsAnnotator_of_json s =
  annotationsAnnotator_of_yojson (Yojson.Safe.from_string s)

let json_of_annotationsAnnotator x =
  Yojson.Safe.to_string (yojson_of_annotationsAnnotator x)

module AnnotationsAnnotator = struct
  type nonrec t = annotationsAnnotator
  let of_yojson = annotationsAnnotator_of_yojson
  let to_yojson = yojson_of_annotationsAnnotator
  let of_json = annotationsAnnotator_of_json
  let to_json = json_of_annotationsAnnotator
end

(**
   A comment, note, explanation, or similar textual content which
   provides additional context to the object(s) being annotated.
*)
type annotations = {
  bomref: refType option;
  subjects: annotationsSubjects list;
  (**
     The object in the BOM identified by its bom-ref. This is often a
     component or service, but may be any object type supporting bom-refs.
  *)
  annotator: annotationsAnnotator;
  (**
     The organization, person, component, or service which created the
     textual content of the annotation.
  *)
  timestamp: string;  (** The date and time (timestamp) when the annotation was created. *)
  text: string;  (** The textual content of the annotation. *)
  signature: signature option;
}

let create_annotations ?bomref ~subjects ~annotator ~timestamp ~text ?signature () : annotations =
  { bomref; subjects; annotator; timestamp; text; signature }

let annotations_of_yojson (x : Yojson.Safe.t) : annotations =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let bomref =
      match assoc "bom-ref" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (refType_of_yojson v)
    in
    let subjects =
      match assoc "subjects" with
      | Some v -> (Atdml_runtime.Yojson.list_of_yojson annotationsSubjects_of_yojson) v
      | None -> Atdml_runtime.Yojson.missing_field "annotations" "subjects"
    in
    let annotator =
      match assoc "annotator" with
      | Some v -> annotationsAnnotator_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "annotations" "annotator"
    in
    let timestamp =
      match assoc "timestamp" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "annotations" "timestamp"
    in
    let text =
      match assoc "text" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "annotations" "text"
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { bomref; subjects; annotator; timestamp; text; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "annotations" x

let yojson_of_annotations (x : annotations) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.bomref with None -> [] | Some v -> [("bom-ref", yojson_of_refType v)]);
    [("subjects", (Atdml_runtime.Yojson.yojson_of_list yojson_of_annotationsSubjects) x.subjects)];
    [("annotator", yojson_of_annotationsAnnotator x.annotator)];
    [("timestamp", Atdml_runtime.Yojson.yojson_of_string x.timestamp)];
    [("text", Atdml_runtime.Yojson.yojson_of_string x.text)];
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let annotations_of_json s =
  annotations_of_yojson (Yojson.Safe.from_string s)

let json_of_annotations x =
  Yojson.Safe.to_string (yojson_of_annotations x)

module Annotations = struct
  type nonrec t = annotations
  let create = create_annotations
  let of_yojson = annotations_of_yojson
  let to_yojson = yojson_of_annotations
  let of_json = annotations_of_json
  let to_json = json_of_annotations
end

type cycloneDXBillofMaterialsStandard = {
  schema: string option;
  bomFormat: cycloneDXBillofMaterialsStandardBomFormat;
  (**
     Specifies the format of the BOM. This helps to identify the file as
     CycloneDX since BOMs do not have a filename convention, nor does JSON
     schema support namespaces. This value must be "CycloneDX".
  *)
  specVersion: string;  (** The version of the CycloneDX specification the BOM conforms to. *)
  serialNumber: string option;
  (**
     Every BOM generated SHOULD have a unique serial number, even if the
     contents of the BOM have not changed over time. If specified, the
     serial number must conform to \[RFC
     4122\](https://www.ietf.org/rfc/rfc4122.html). Use of serial numbers
     is recommended.
  *)
  version: int;
  (**
     Whenever an existing BOM is modified, either manually or through
     automated processes, the version of the BOM SHOULD be incremented by
     1. When a system is presented with multiple BOMs with identical serial
     numbers, the system SHOULD use the most recent version of the BOM. The
     default version is '1'.
  *)
  metadata: metadata option;
  components: component list option;  (** A list of software and hardware components. *)
  services: service list option;
  (**
     A list of services. This may include microservices,
     function-as-a-service, and other types of network or intra-process
     services.
  *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
  dependencies: dependency list option;
  (**
     Provides the ability to document dependency relationships including
     provided & implemented components.
  *)
  compositions: compositions list option;
  (**
     Compositions describe constituent parts (including components,
     services, and dependency relationships) and their completeness. The
     completeness of vulnerabilities expressed in a BOM may also be
     described.
  *)
  vulnerabilities: vulnerability list option;  (** Vulnerabilities identified in components or services. *)
  annotations: annotations list option;
  (**
     Comments made by people, organizations, or tools about any object with
     a bom-ref, such as components, services, vulnerabilities, or the BOM
     itself. Unlike inventory information, annotations may contain opinions
     or commentary from various stakeholders. Annotations may be inline
     (with inventory) or externalized via BOM-Link and may optionally be
     signed.
  *)
  formulation: formula list option;
  (**
     Describes how a component or service was manufactured or deployed.
     This is achieved through the use of formulas, workflows, tasks, and
     steps, which declare the precise steps to reproduce along with the
     observed formulas describing the steps which transpired in the
     manufacturing process.
  *)
  declarations: cycloneDXBillofMaterialsStandardDeclarations option;
  (**
     The list of declarations which describe the conformance to standards.
     Each declaration may include attestations, claims, and evidence.
  *)
  definitions: cycloneDXBillofMaterialsStandardDefinitions option;
  (**
     A collection of reusable objects that are defined and may be used
     elsewhere in the BOM.
  *)
  properties: property list option;
  (**
     Provides the ability to document properties in a name-value store.
     This provides flexibility to include data not officially supported in
     the standard without having to use additional namespaces or create
     extensions. Unlike key-value stores, properties support duplicate
     names, each potentially having different values. Property names of
     interest to the general public are encouraged to be registered in the
     \[CycloneDX Property
     Taxonomy\](https://github.com/CycloneDX/cyclonedx-property-taxonomy).
     Formal registration is optional.
  *)
  signature: signature option;
}

let create_cycloneDXBillofMaterialsStandard ?schema ~bomFormat ~specVersion ?serialNumber ?(version = 1) ?metadata ?components ?services ?externalReferences ?dependencies ?compositions ?vulnerabilities ?annotations ?formulation ?declarations ?definitions ?properties ?signature () : cycloneDXBillofMaterialsStandard =
  { schema; bomFormat; specVersion; serialNumber; version; metadata; components; services; externalReferences; dependencies; compositions; vulnerabilities; annotations; formulation; declarations; definitions; properties; signature }

let cycloneDXBillofMaterialsStandard_of_yojson (x : Yojson.Safe.t) : cycloneDXBillofMaterialsStandard =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let schema =
      match assoc "$schema" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let bomFormat =
      match assoc "bomFormat" with
      | Some v -> cycloneDXBillofMaterialsStandardBomFormat_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "cycloneDXBillofMaterialsStandard" "bomFormat"
    in
    let specVersion =
      match assoc "specVersion" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "cycloneDXBillofMaterialsStandard" "specVersion"
    in
    let serialNumber =
      match assoc "serialNumber" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let version =
      match assoc "version" with
      | None -> 1
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
    in
    let metadata =
      match assoc "metadata" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (metadata_of_yojson v)
    in
    let components =
      match assoc "components" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson component_of_yojson) v)
    in
    let services =
      match assoc "services" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson service_of_yojson) v)
    in
    let externalReferences =
      match assoc "externalReferences" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson externalReference_of_yojson) v)
    in
    let dependencies =
      match assoc "dependencies" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson dependency_of_yojson) v)
    in
    let compositions =
      match assoc "compositions" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson compositions_of_yojson) v)
    in
    let vulnerabilities =
      match assoc "vulnerabilities" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson vulnerability_of_yojson) v)
    in
    let annotations =
      match assoc "annotations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson annotations_of_yojson) v)
    in
    let formulation =
      match assoc "formulation" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson formula_of_yojson) v)
    in
    let declarations =
      match assoc "declarations" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cycloneDXBillofMaterialsStandardDeclarations_of_yojson v)
    in
    let definitions =
      match assoc "definitions" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (cycloneDXBillofMaterialsStandardDefinitions_of_yojson v)
    in
    let properties =
      match assoc "properties" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson property_of_yojson) v)
    in
    let signature =
      match assoc "signature" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (signature_of_yojson v)
    in
    { schema; bomFormat; specVersion; serialNumber; version; metadata; components; services; externalReferences; dependencies; compositions; vulnerabilities; annotations; formulation; declarations; definitions; properties; signature }
  | _ -> Atdml_runtime.Yojson.bad_type "cycloneDXBillofMaterialsStandard" x

let yojson_of_cycloneDXBillofMaterialsStandard (x : cycloneDXBillofMaterialsStandard) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.schema with None -> [] | Some v -> [("$schema", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("bomFormat", yojson_of_cycloneDXBillofMaterialsStandardBomFormat x.bomFormat)];
    [("specVersion", Atdml_runtime.Yojson.yojson_of_string x.specVersion)];
    (match x.serialNumber with None -> [] | Some v -> [("serialNumber", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("version", Atdml_runtime.Yojson.yojson_of_int x.version)];
    (match x.metadata with None -> [] | Some v -> [("metadata", yojson_of_metadata v)]);
    (match x.components with None -> [] | Some v -> [("components", (Atdml_runtime.Yojson.yojson_of_list yojson_of_component) v)]);
    (match x.services with None -> [] | Some v -> [("services", (Atdml_runtime.Yojson.yojson_of_list yojson_of_service) v)]);
    (match x.externalReferences with None -> [] | Some v -> [("externalReferences", (Atdml_runtime.Yojson.yojson_of_list yojson_of_externalReference) v)]);
    (match x.dependencies with None -> [] | Some v -> [("dependencies", (Atdml_runtime.Yojson.yojson_of_list yojson_of_dependency) v)]);
    (match x.compositions with None -> [] | Some v -> [("compositions", (Atdml_runtime.Yojson.yojson_of_list yojson_of_compositions) v)]);
    (match x.vulnerabilities with None -> [] | Some v -> [("vulnerabilities", (Atdml_runtime.Yojson.yojson_of_list yojson_of_vulnerability) v)]);
    (match x.annotations with None -> [] | Some v -> [("annotations", (Atdml_runtime.Yojson.yojson_of_list yojson_of_annotations) v)]);
    (match x.formulation with None -> [] | Some v -> [("formulation", (Atdml_runtime.Yojson.yojson_of_list yojson_of_formula) v)]);
    (match x.declarations with None -> [] | Some v -> [("declarations", yojson_of_cycloneDXBillofMaterialsStandardDeclarations v)]);
    (match x.definitions with None -> [] | Some v -> [("definitions", yojson_of_cycloneDXBillofMaterialsStandardDefinitions v)]);
    (match x.properties with None -> [] | Some v -> [("properties", (Atdml_runtime.Yojson.yojson_of_list yojson_of_property) v)]);
    (match x.signature with None -> [] | Some v -> [("signature", yojson_of_signature v)]);
  ])

let cycloneDXBillofMaterialsStandard_of_json s =
  cycloneDXBillofMaterialsStandard_of_yojson (Yojson.Safe.from_string s)

let json_of_cycloneDXBillofMaterialsStandard x =
  Yojson.Safe.to_string (yojson_of_cycloneDXBillofMaterialsStandard x)

module CycloneDXBillofMaterialsStandard = struct
  type nonrec t = cycloneDXBillofMaterialsStandard
  let create = create_cycloneDXBillofMaterialsStandard
  let of_yojson = cycloneDXBillofMaterialsStandard_of_yojson
  let to_yojson = yojson_of_cycloneDXBillofMaterialsStandard
  let of_json = cycloneDXBillofMaterialsStandard_of_json
  let to_json = json_of_cycloneDXBillofMaterialsStandard
end

(**
   The vulnerability status of a given version or range of versions of a
   product. The statuses 'affected' and 'unaffected' indicate that the
   version is affected or unaffected by the vulnerability. The status
   'unknown' indicates that it is unknown or unspecified whether the
   given version is affected. There can be many reasons for an 'unknown'
   status, including that an investigation has not been undertaken or
   that a vendor has not disclosed the status.
*)
type affectedStatus =
  | Affected
  | Unaffected
  | Unknown

let affectedStatus_of_yojson (x : Yojson.Safe.t) : affectedStatus =
  match x with
  | `String "affected" -> Affected
  | `String "unaffected" -> Unaffected
  | `String "unknown" -> Unknown
  | _ -> Atdml_runtime.Yojson.bad_sum "affectedStatus" x

let yojson_of_affectedStatus (x : affectedStatus) : Yojson.Safe.t =
  match x with
  | Affected -> `String "affected"
  | Unaffected -> `String "unaffected"
  | Unknown -> `String "unknown"

let affectedStatus_of_json s =
  affectedStatus_of_yojson (Yojson.Safe.from_string s)

let json_of_affectedStatus x =
  Yojson.Safe.to_string (yojson_of_affectedStatus x)

module AffectedStatus = struct
  type nonrec t = affectedStatus
  let of_yojson = affectedStatus_of_yojson
  let to_yojson = yojson_of_affectedStatus
  let of_json = affectedStatus_of_json
  let to_json = json_of_affectedStatus
end

