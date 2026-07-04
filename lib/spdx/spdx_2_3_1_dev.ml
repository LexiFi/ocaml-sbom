(* Auto-generated from "spdx_2_3_1_dev.atd" by atdml. *)
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
      Printf.ksprintf failwith "expected %s, got: %s" expected_type
        (Yojson.Safe.to_string x)

    let bad_sum type_name x =
      Printf.ksprintf failwith "invalid variant for type '%s': %s" type_name
        (Yojson.Safe.to_string x)

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
      | `List [ `String "Some"; x ] -> Some (f x)
      | x -> bad_type "option" x

    let yojson_of_option f = function
      | None -> `String "None"
      | Some x -> `List [ `String "Some"; f x ]

    let nullable_of_yojson f = function
      | `Null -> None
      | x -> Some (f x)

    let yojson_of_nullable f = function
      | None -> `Null
      | Some x -> f x

    let assoc_of_yojson f = function
      | `Assoc pairs -> List.map (fun (k, v) -> (k, f v)) pairs
      | x -> bad_type "object" x

    let yojson_of_assoc f xs = `Assoc (List.map (fun (k, v) -> (k, f v)) xs)
  end
end

type sPDX231devSnippetsRangesStartPointer = {
  reference : string;  (** SPDX ID for File *)
  offset : int option;  (** Byte offset in the file *)
  lineNumber : int option;  (** line number offset in the file *)
}

let create_sPDX231devSnippetsRangesStartPointer ~reference ?offset ?lineNumber
    () : sPDX231devSnippetsRangesStartPointer =
  { reference; offset; lineNumber }

let sPDX231devSnippetsRangesStartPointer_of_yojson (x : Yojson.Safe.t) :
    sPDX231devSnippetsRangesStartPointer =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let reference =
        match assoc_ "reference" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devSnippetsRangesStartPointer" "reference"
      in
      let offset =
        match assoc_ "offset" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.int_of_yojson v)
      in
      let lineNumber =
        match assoc_ "lineNumber" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.int_of_yojson v)
      in
      { reference; offset; lineNumber }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devSnippetsRangesStartPointer" x

let yojson_of_sPDX231devSnippetsRangesStartPointer
    (x : sPDX231devSnippetsRangesStartPointer) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("reference", Atdml_runtime.Yojson.yojson_of_string x.reference) ];
         (match x.offset with
         | None -> []
         | Some v -> [ ("offset", Atdml_runtime.Yojson.yojson_of_int v) ]);
         (match x.lineNumber with
         | None -> []
         | Some v -> [ ("lineNumber", Atdml_runtime.Yojson.yojson_of_int v) ]);
       ])

let sPDX231devSnippetsRangesStartPointer_of_json s =
  sPDX231devSnippetsRangesStartPointer_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devSnippetsRangesStartPointer x =
  Yojson.Safe.to_string (yojson_of_sPDX231devSnippetsRangesStartPointer x)

module SPDX231devSnippetsRangesStartPointer = struct
  type nonrec t = sPDX231devSnippetsRangesStartPointer

  let create = create_sPDX231devSnippetsRangesStartPointer
  let of_yojson = sPDX231devSnippetsRangesStartPointer_of_yojson
  let to_yojson = yojson_of_sPDX231devSnippetsRangesStartPointer
  let of_json = sPDX231devSnippetsRangesStartPointer_of_json
  let to_json = json_of_sPDX231devSnippetsRangesStartPointer
end

type sPDX231devSnippetsRangesEndPointer = {
  reference : string;  (** SPDX ID for File *)
  offset : int option;  (** Byte offset in the file *)
  lineNumber : int option;  (** line number offset in the file *)
}

let create_sPDX231devSnippetsRangesEndPointer ~reference ?offset ?lineNumber ()
    : sPDX231devSnippetsRangesEndPointer =
  { reference; offset; lineNumber }

let sPDX231devSnippetsRangesEndPointer_of_yojson (x : Yojson.Safe.t) :
    sPDX231devSnippetsRangesEndPointer =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let reference =
        match assoc_ "reference" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devSnippetsRangesEndPointer" "reference"
      in
      let offset =
        match assoc_ "offset" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.int_of_yojson v)
      in
      let lineNumber =
        match assoc_ "lineNumber" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.int_of_yojson v)
      in
      { reference; offset; lineNumber }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devSnippetsRangesEndPointer" x

let yojson_of_sPDX231devSnippetsRangesEndPointer
    (x : sPDX231devSnippetsRangesEndPointer) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("reference", Atdml_runtime.Yojson.yojson_of_string x.reference) ];
         (match x.offset with
         | None -> []
         | Some v -> [ ("offset", Atdml_runtime.Yojson.yojson_of_int v) ]);
         (match x.lineNumber with
         | None -> []
         | Some v -> [ ("lineNumber", Atdml_runtime.Yojson.yojson_of_int v) ]);
       ])

let sPDX231devSnippetsRangesEndPointer_of_json s =
  sPDX231devSnippetsRangesEndPointer_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devSnippetsRangesEndPointer x =
  Yojson.Safe.to_string (yojson_of_sPDX231devSnippetsRangesEndPointer x)

module SPDX231devSnippetsRangesEndPointer = struct
  type nonrec t = sPDX231devSnippetsRangesEndPointer

  let create = create_sPDX231devSnippetsRangesEndPointer
  let of_yojson = sPDX231devSnippetsRangesEndPointer_of_yojson
  let to_yojson = yojson_of_sPDX231devSnippetsRangesEndPointer
  let of_json = sPDX231devSnippetsRangesEndPointer_of_json
  let to_json = json_of_sPDX231devSnippetsRangesEndPointer
end

type sPDX231devSnippetsRanges = {
  endPointer : sPDX231devSnippetsRangesEndPointer;
  startPointer : sPDX231devSnippetsRangesStartPointer;
}

let create_sPDX231devSnippetsRanges ~endPointer ~startPointer () :
    sPDX231devSnippetsRanges =
  { endPointer; startPointer }

let sPDX231devSnippetsRanges_of_yojson (x : Yojson.Safe.t) :
    sPDX231devSnippetsRanges =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let endPointer =
        match assoc_ "endPointer" with
        | Some v -> sPDX231devSnippetsRangesEndPointer_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippetsRanges"
              "endPointer"
      in
      let startPointer =
        match assoc_ "startPointer" with
        | Some v -> sPDX231devSnippetsRangesStartPointer_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippetsRanges"
              "startPointer"
      in
      { endPointer; startPointer }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devSnippetsRanges" x

let yojson_of_sPDX231devSnippetsRanges (x : sPDX231devSnippetsRanges) :
    Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "endPointer",
             yojson_of_sPDX231devSnippetsRangesEndPointer x.endPointer );
         ];
         [
           ( "startPointer",
             yojson_of_sPDX231devSnippetsRangesStartPointer x.startPointer );
         ];
       ])

let sPDX231devSnippetsRanges_of_json s =
  sPDX231devSnippetsRanges_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devSnippetsRanges x =
  Yojson.Safe.to_string (yojson_of_sPDX231devSnippetsRanges x)

module SPDX231devSnippetsRanges = struct
  type nonrec t = sPDX231devSnippetsRanges

  let create = create_sPDX231devSnippetsRanges
  let of_yojson = sPDX231devSnippetsRanges_of_yojson
  let to_yojson = yojson_of_sPDX231devSnippetsRanges
  let of_json = sPDX231devSnippetsRanges_of_json
  let to_json = json_of_sPDX231devSnippetsRanges
end

(** Type of the annotation. *)
type sPDX231devSnippetsAnnotationsAnnotationType = OTHER | REVIEW

let sPDX231devSnippetsAnnotationsAnnotationType_of_yojson (x : Yojson.Safe.t) :
    sPDX231devSnippetsAnnotationsAnnotationType =
  match x with
  | `String "OTHER" -> OTHER
  | `String "REVIEW" -> REVIEW
  | _ ->
      Atdml_runtime.Yojson.bad_sum "sPDX231devSnippetsAnnotationsAnnotationType"
        x

let yojson_of_sPDX231devSnippetsAnnotationsAnnotationType
    (x : sPDX231devSnippetsAnnotationsAnnotationType) : Yojson.Safe.t =
  match x with
  | OTHER -> `String "OTHER"
  | REVIEW -> `String "REVIEW"

let sPDX231devSnippetsAnnotationsAnnotationType_of_json s =
  sPDX231devSnippetsAnnotationsAnnotationType_of_yojson
    (Yojson.Safe.from_string s)

let json_of_sPDX231devSnippetsAnnotationsAnnotationType x =
  Yojson.Safe.to_string
    (yojson_of_sPDX231devSnippetsAnnotationsAnnotationType x)

module SPDX231devSnippetsAnnotationsAnnotationType = struct
  type nonrec t = sPDX231devSnippetsAnnotationsAnnotationType

  let of_yojson = sPDX231devSnippetsAnnotationsAnnotationType_of_yojson
  let to_yojson = yojson_of_sPDX231devSnippetsAnnotationsAnnotationType
  let of_json = sPDX231devSnippetsAnnotationsAnnotationType_of_json
  let to_json = json_of_sPDX231devSnippetsAnnotationsAnnotationType
end

type sPDX231devSnippetsAnnotations = {
  annotationDate : string;
      (** Identify when the comment was made. This is to be specified according
          to the combined date and time in the UTC format, as specified in the
          ISO 8601 standard. *)
  annotationType : sPDX231devSnippetsAnnotationsAnnotationType;
      (** Type of the annotation. *)
  annotator : string;
      (** This field identifies the person, organization, or tool that has
          commented on a file, package, snippet, or the entire document. *)
  comment : string;
}
(** An Annotation is a comment on an SpdxItem by an agent. *)

let create_sPDX231devSnippetsAnnotations ~annotationDate ~annotationType
    ~annotator ~comment () : sPDX231devSnippetsAnnotations =
  { annotationDate; annotationType; annotator; comment }

let sPDX231devSnippetsAnnotations_of_yojson (x : Yojson.Safe.t) :
    sPDX231devSnippetsAnnotations =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let annotationDate =
        match assoc_ "annotationDate" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippetsAnnotations"
              "annotationDate"
      in
      let annotationType =
        match assoc_ "annotationType" with
        | Some v -> sPDX231devSnippetsAnnotationsAnnotationType_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippetsAnnotations"
              "annotationType"
      in
      let annotator =
        match assoc_ "annotator" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippetsAnnotations"
              "annotator"
      in
      let comment =
        match assoc_ "comment" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippetsAnnotations"
              "comment"
      in
      { annotationDate; annotationType; annotator; comment }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devSnippetsAnnotations" x

let yojson_of_sPDX231devSnippetsAnnotations (x : sPDX231devSnippetsAnnotations)
    : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "annotationDate",
             Atdml_runtime.Yojson.yojson_of_string x.annotationDate );
         ];
         [
           ( "annotationType",
             yojson_of_sPDX231devSnippetsAnnotationsAnnotationType
               x.annotationType );
         ];
         [ ("annotator", Atdml_runtime.Yojson.yojson_of_string x.annotator) ];
         [ ("comment", Atdml_runtime.Yojson.yojson_of_string x.comment) ];
       ])

let sPDX231devSnippetsAnnotations_of_json s =
  sPDX231devSnippetsAnnotations_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devSnippetsAnnotations x =
  Yojson.Safe.to_string (yojson_of_sPDX231devSnippetsAnnotations x)

module SPDX231devSnippetsAnnotations = struct
  type nonrec t = sPDX231devSnippetsAnnotations

  let create = create_sPDX231devSnippetsAnnotations
  let of_yojson = sPDX231devSnippetsAnnotations_of_yojson
  let to_yojson = yojson_of_sPDX231devSnippetsAnnotations
  let of_json = sPDX231devSnippetsAnnotations_of_json
  let to_json = json_of_sPDX231devSnippetsAnnotations
end

type sPDX231devSnippets = {
  sPDXID : string;
      (** Uniquely identify any element in an SPDX document which may be
          referenced by other elements. *)
  annotations : sPDX231devSnippetsAnnotations list option;
      (** Provide additional information about an SpdxElement. *)
  attributionTexts : string list option;
      (** This field provides a place for the SPDX data creator to record
          acknowledgements that may be required to be communicated in some
          contexts. This is not meant to include the actual complete license
          text (see licenseConcluded and licenseDeclared), and may or may not
          include copyright notices (see also copyrightText). The SPDX data
          creator may use this field to record other acknowledgements, such as
          particular clauses from license texts, which may be necessary or
          desirable to reproduce. *)
  comment : string option;
  copyrightText : string option;
      (** The text of copyright declarations recited in the package, file or
          snippet.

          If the copyrightText field is not present, it implies an equivalent
          meaning to NOASSERTION. *)
  licenseComments : string option;
      (** The licenseComments property allows the preparer of the SPDX document
          to describe why the licensing in spdx:licenseConcluded was chosen. *)
  licenseConcluded : string option;
      (** License expression for licenseConcluded. See SPDX Annex D for the
          license expression syntax. The licensing that the preparer of this
          SPDX document has concluded, based on the evidence, actually applies
          to the SPDX Item.

          If the licenseConcluded field is not present for an SPDX Item, it
          implies an equivalent meaning to NOASSERTION. *)
  licenseInfoInSnippets : string list option;
      (** Licensing information that was discovered directly in the subject
          snippet. This is also considered a declared license for the snippet.

          If the licenseInfoInSnippet field is not present for a snippet, it
          implies an equivalent meaning to NOASSERTION. *)
  name : string option;  (** Identify name of this SpdxElement. *)
  ranges : sPDX231devSnippetsRanges list;
      (** This field defines the byte range in the original host file (in X.2)
          that the snippet information applies to *)
  snippetFromFile : string;
      (** SPDX ID for File. File containing the SPDX element (e.g. the file
          containing a snippet). *)
}

let create_sPDX231devSnippets ~sPDXID ?annotations ?attributionTexts ?comment
    ?copyrightText ?licenseComments ?licenseConcluded ?licenseInfoInSnippets
    ?name ~ranges ~snippetFromFile () : sPDX231devSnippets =
  {
    sPDXID;
    annotations;
    attributionTexts;
    comment;
    copyrightText;
    licenseComments;
    licenseConcluded;
    licenseInfoInSnippets;
    name;
    ranges;
    snippetFromFile;
  }

let sPDX231devSnippets_of_yojson (x : Yojson.Safe.t) : sPDX231devSnippets =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let sPDXID =
        match assoc_ "SPDXID" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippets" "SPDXID"
      in
      let annotations =
        match assoc_ "annotations" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devSnippetsAnnotations_of_yojson)
                 v)
      in
      let attributionTexts =
        match assoc_ "attributionTexts" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let copyrightText =
        match assoc_ "copyrightText" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseComments =
        match assoc_ "licenseComments" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseConcluded =
        match assoc_ "licenseConcluded" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseInfoInSnippets =
        match assoc_ "licenseInfoInSnippets" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let name =
        match assoc_ "name" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let ranges =
        match assoc_ "ranges" with
        | Some v ->
            (Atdml_runtime.Yojson.list_of_yojson
               sPDX231devSnippetsRanges_of_yojson)
              v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippets" "ranges"
      in
      let snippetFromFile =
        match assoc_ "snippetFromFile" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devSnippets"
              "snippetFromFile"
      in
      {
        sPDXID;
        annotations;
        attributionTexts;
        comment;
        copyrightText;
        licenseComments;
        licenseConcluded;
        licenseInfoInSnippets;
        name;
        ranges;
        snippetFromFile;
      }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devSnippets" x

let yojson_of_sPDX231devSnippets (x : sPDX231devSnippets) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("SPDXID", Atdml_runtime.Yojson.yojson_of_string x.sPDXID) ];
         (match x.annotations with
         | None -> []
         | Some v ->
             [
               ( "annotations",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devSnippetsAnnotations)
                   v );
             ]);
         (match x.attributionTexts with
         | None -> []
         | Some v ->
             [
               ( "attributionTexts",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.copyrightText with
         | None -> []
         | Some v ->
             [ ("copyrightText", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseComments with
         | None -> []
         | Some v ->
             [ ("licenseComments", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseConcluded with
         | None -> []
         | Some v ->
             [ ("licenseConcluded", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseInfoInSnippets with
         | None -> []
         | Some v ->
             [
               ( "licenseInfoInSnippets",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         (match x.name with
         | None -> []
         | Some v -> [ ("name", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [
           ( "ranges",
             (Atdml_runtime.Yojson.yojson_of_list
                yojson_of_sPDX231devSnippetsRanges)
               x.ranges );
         ];
         [
           ( "snippetFromFile",
             Atdml_runtime.Yojson.yojson_of_string x.snippetFromFile );
         ];
       ])

let sPDX231devSnippets_of_json s =
  sPDX231devSnippets_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devSnippets x =
  Yojson.Safe.to_string (yojson_of_sPDX231devSnippets x)

module SPDX231devSnippets = struct
  type nonrec t = sPDX231devSnippets

  let create = create_sPDX231devSnippets
  let of_yojson = sPDX231devSnippets_of_yojson
  let to_yojson = yojson_of_sPDX231devSnippets
  let of_json = sPDX231devSnippets_of_json
  let to_json = json_of_sPDX231devSnippets
end

type sPDX231devRevieweds = {
  comment : string option;
  reviewDate : string;
      (** The date and time at which the SpdxDocument was reviewed. This value
          must be in UTC and have 'Z' as its timezone indicator. *)
  reviewer : string option;
      (** The name and, optionally, contact information of the person who
          performed the review. Values of this property must conform to the
          agent and tool syntax. The reviewer property is deprecated in favor of
          Annotation with an annotationType review. *)
}
(** This class has been deprecated in favor of an Annotation with an Annotation
    type of review. *)

let create_sPDX231devRevieweds ?comment ~reviewDate ?reviewer () :
    sPDX231devRevieweds =
  { comment; reviewDate; reviewer }

let sPDX231devRevieweds_of_yojson (x : Yojson.Safe.t) : sPDX231devRevieweds =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let reviewDate =
        match assoc_ "reviewDate" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devRevieweds"
              "reviewDate"
      in
      let reviewer =
        match assoc_ "reviewer" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      { comment; reviewDate; reviewer }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devRevieweds" x

let yojson_of_sPDX231devRevieweds (x : sPDX231devRevieweds) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [ ("reviewDate", Atdml_runtime.Yojson.yojson_of_string x.reviewDate) ];
         (match x.reviewer with
         | None -> []
         | Some v -> [ ("reviewer", Atdml_runtime.Yojson.yojson_of_string v) ]);
       ])

let sPDX231devRevieweds_of_json s =
  sPDX231devRevieweds_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devRevieweds x =
  Yojson.Safe.to_string (yojson_of_sPDX231devRevieweds x)

module SPDX231devRevieweds = struct
  type nonrec t = sPDX231devRevieweds

  let create = create_sPDX231devRevieweds
  let of_yojson = sPDX231devRevieweds_of_yojson
  let to_yojson = yojson_of_sPDX231devRevieweds
  let of_json = sPDX231devRevieweds_of_json
  let to_json = json_of_sPDX231devRevieweds
end

(** Describes the type of relationship between two SPDX elements. *)
type sPDX231devRelationshipsRelationshipType =
  | VARIANT_OF
  | COPY_OF
  | PATCH_FOR
  | TEST_DEPENDENCY_OF
  | CONTAINED_BY
  | DATA_FILE_OF
  | OPTIONAL_COMPONENT_OF
  | ANCESTOR_OF
  | GENERATES
  | CONTAINS
  | OPTIONAL_DEPENDENCY_OF
  | FILE_ADDED
  | REQUIREMENT_DESCRIPTION_FOR
  | DEV_DEPENDENCY_OF
  | DEPENDENCY_OF
  | BUILD_DEPENDENCY_OF
  | DESCRIBES
  | PREREQUISITE_FOR
  | HAS_PREREQUISITE
  | PROVIDED_DEPENDENCY_OF
  | DYNAMIC_LINK
  | DESCRIBED_BY
  | METAFILE_OF
  | DEPENDENCY_MANIFEST_OF
  | PATCH_APPLIED
  | RUNTIME_DEPENDENCY_OF
  | TEST_OF
  | TEST_TOOL_OF
  | DEPENDS_ON
  | SPECIFICATION_FOR
  | FILE_MODIFIED
  | DISTRIBUTION_ARTIFACT
  | AMENDS
  | DOCUMENTATION_OF
  | GENERATED_FROM
  | STATIC_LINK
  | OTHER
  | BUILD_TOOL_OF
  | TEST_CASE_OF
  | PACKAGE_OF
  | DESCENDANT_OF
  | FILE_DELETED
  | EXPANDED_FROM_ARCHIVE
  | DEV_TOOL_OF
  | EXAMPLE_OF

let sPDX231devRelationshipsRelationshipType_of_yojson (x : Yojson.Safe.t) :
    sPDX231devRelationshipsRelationshipType =
  match x with
  | `String "VARIANT_OF" -> VARIANT_OF
  | `String "COPY_OF" -> COPY_OF
  | `String "PATCH_FOR" -> PATCH_FOR
  | `String "TEST_DEPENDENCY_OF" -> TEST_DEPENDENCY_OF
  | `String "CONTAINED_BY" -> CONTAINED_BY
  | `String "DATA_FILE_OF" -> DATA_FILE_OF
  | `String "OPTIONAL_COMPONENT_OF" -> OPTIONAL_COMPONENT_OF
  | `String "ANCESTOR_OF" -> ANCESTOR_OF
  | `String "GENERATES" -> GENERATES
  | `String "CONTAINS" -> CONTAINS
  | `String "OPTIONAL_DEPENDENCY_OF" -> OPTIONAL_DEPENDENCY_OF
  | `String "FILE_ADDED" -> FILE_ADDED
  | `String "REQUIREMENT_DESCRIPTION_FOR" -> REQUIREMENT_DESCRIPTION_FOR
  | `String "DEV_DEPENDENCY_OF" -> DEV_DEPENDENCY_OF
  | `String "DEPENDENCY_OF" -> DEPENDENCY_OF
  | `String "BUILD_DEPENDENCY_OF" -> BUILD_DEPENDENCY_OF
  | `String "DESCRIBES" -> DESCRIBES
  | `String "PREREQUISITE_FOR" -> PREREQUISITE_FOR
  | `String "HAS_PREREQUISITE" -> HAS_PREREQUISITE
  | `String "PROVIDED_DEPENDENCY_OF" -> PROVIDED_DEPENDENCY_OF
  | `String "DYNAMIC_LINK" -> DYNAMIC_LINK
  | `String "DESCRIBED_BY" -> DESCRIBED_BY
  | `String "METAFILE_OF" -> METAFILE_OF
  | `String "DEPENDENCY_MANIFEST_OF" -> DEPENDENCY_MANIFEST_OF
  | `String "PATCH_APPLIED" -> PATCH_APPLIED
  | `String "RUNTIME_DEPENDENCY_OF" -> RUNTIME_DEPENDENCY_OF
  | `String "TEST_OF" -> TEST_OF
  | `String "TEST_TOOL_OF" -> TEST_TOOL_OF
  | `String "DEPENDS_ON" -> DEPENDS_ON
  | `String "SPECIFICATION_FOR" -> SPECIFICATION_FOR
  | `String "FILE_MODIFIED" -> FILE_MODIFIED
  | `String "DISTRIBUTION_ARTIFACT" -> DISTRIBUTION_ARTIFACT
  | `String "AMENDS" -> AMENDS
  | `String "DOCUMENTATION_OF" -> DOCUMENTATION_OF
  | `String "GENERATED_FROM" -> GENERATED_FROM
  | `String "STATIC_LINK" -> STATIC_LINK
  | `String "OTHER" -> OTHER
  | `String "BUILD_TOOL_OF" -> BUILD_TOOL_OF
  | `String "TEST_CASE_OF" -> TEST_CASE_OF
  | `String "PACKAGE_OF" -> PACKAGE_OF
  | `String "DESCENDANT_OF" -> DESCENDANT_OF
  | `String "FILE_DELETED" -> FILE_DELETED
  | `String "EXPANDED_FROM_ARCHIVE" -> EXPANDED_FROM_ARCHIVE
  | `String "DEV_TOOL_OF" -> DEV_TOOL_OF
  | `String "EXAMPLE_OF" -> EXAMPLE_OF
  | _ ->
      Atdml_runtime.Yojson.bad_sum "sPDX231devRelationshipsRelationshipType" x

let yojson_of_sPDX231devRelationshipsRelationshipType
    (x : sPDX231devRelationshipsRelationshipType) : Yojson.Safe.t =
  match x with
  | VARIANT_OF -> `String "VARIANT_OF"
  | COPY_OF -> `String "COPY_OF"
  | PATCH_FOR -> `String "PATCH_FOR"
  | TEST_DEPENDENCY_OF -> `String "TEST_DEPENDENCY_OF"
  | CONTAINED_BY -> `String "CONTAINED_BY"
  | DATA_FILE_OF -> `String "DATA_FILE_OF"
  | OPTIONAL_COMPONENT_OF -> `String "OPTIONAL_COMPONENT_OF"
  | ANCESTOR_OF -> `String "ANCESTOR_OF"
  | GENERATES -> `String "GENERATES"
  | CONTAINS -> `String "CONTAINS"
  | OPTIONAL_DEPENDENCY_OF -> `String "OPTIONAL_DEPENDENCY_OF"
  | FILE_ADDED -> `String "FILE_ADDED"
  | REQUIREMENT_DESCRIPTION_FOR -> `String "REQUIREMENT_DESCRIPTION_FOR"
  | DEV_DEPENDENCY_OF -> `String "DEV_DEPENDENCY_OF"
  | DEPENDENCY_OF -> `String "DEPENDENCY_OF"
  | BUILD_DEPENDENCY_OF -> `String "BUILD_DEPENDENCY_OF"
  | DESCRIBES -> `String "DESCRIBES"
  | PREREQUISITE_FOR -> `String "PREREQUISITE_FOR"
  | HAS_PREREQUISITE -> `String "HAS_PREREQUISITE"
  | PROVIDED_DEPENDENCY_OF -> `String "PROVIDED_DEPENDENCY_OF"
  | DYNAMIC_LINK -> `String "DYNAMIC_LINK"
  | DESCRIBED_BY -> `String "DESCRIBED_BY"
  | METAFILE_OF -> `String "METAFILE_OF"
  | DEPENDENCY_MANIFEST_OF -> `String "DEPENDENCY_MANIFEST_OF"
  | PATCH_APPLIED -> `String "PATCH_APPLIED"
  | RUNTIME_DEPENDENCY_OF -> `String "RUNTIME_DEPENDENCY_OF"
  | TEST_OF -> `String "TEST_OF"
  | TEST_TOOL_OF -> `String "TEST_TOOL_OF"
  | DEPENDS_ON -> `String "DEPENDS_ON"
  | SPECIFICATION_FOR -> `String "SPECIFICATION_FOR"
  | FILE_MODIFIED -> `String "FILE_MODIFIED"
  | DISTRIBUTION_ARTIFACT -> `String "DISTRIBUTION_ARTIFACT"
  | AMENDS -> `String "AMENDS"
  | DOCUMENTATION_OF -> `String "DOCUMENTATION_OF"
  | GENERATED_FROM -> `String "GENERATED_FROM"
  | STATIC_LINK -> `String "STATIC_LINK"
  | OTHER -> `String "OTHER"
  | BUILD_TOOL_OF -> `String "BUILD_TOOL_OF"
  | TEST_CASE_OF -> `String "TEST_CASE_OF"
  | PACKAGE_OF -> `String "PACKAGE_OF"
  | DESCENDANT_OF -> `String "DESCENDANT_OF"
  | FILE_DELETED -> `String "FILE_DELETED"
  | EXPANDED_FROM_ARCHIVE -> `String "EXPANDED_FROM_ARCHIVE"
  | DEV_TOOL_OF -> `String "DEV_TOOL_OF"
  | EXAMPLE_OF -> `String "EXAMPLE_OF"

let sPDX231devRelationshipsRelationshipType_of_json s =
  sPDX231devRelationshipsRelationshipType_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devRelationshipsRelationshipType x =
  Yojson.Safe.to_string (yojson_of_sPDX231devRelationshipsRelationshipType x)

module SPDX231devRelationshipsRelationshipType = struct
  type nonrec t = sPDX231devRelationshipsRelationshipType

  let of_yojson = sPDX231devRelationshipsRelationshipType_of_yojson
  let to_yojson = yojson_of_sPDX231devRelationshipsRelationshipType
  let of_json = sPDX231devRelationshipsRelationshipType_of_json
  let to_json = json_of_sPDX231devRelationshipsRelationshipType
end

type sPDX231devRelationships = {
  spdxElementId : string;  (** Id to which the SPDX element is related *)
  comment : string option;
  relatedSpdxElement : string;
      (** SPDX ID for SpdxElement. A related SpdxElement. *)
  relationshipType : sPDX231devRelationshipsRelationshipType;
      (** Describes the type of relationship between two SPDX elements. *)
}

let create_sPDX231devRelationships ~spdxElementId ?comment ~relatedSpdxElement
    ~relationshipType () : sPDX231devRelationships =
  { spdxElementId; comment; relatedSpdxElement; relationshipType }

let sPDX231devRelationships_of_yojson (x : Yojson.Safe.t) :
    sPDX231devRelationships =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let spdxElementId =
        match assoc_ "spdxElementId" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devRelationships"
              "spdxElementId"
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let relatedSpdxElement =
        match assoc_ "relatedSpdxElement" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devRelationships"
              "relatedSpdxElement"
      in
      let relationshipType =
        match assoc_ "relationshipType" with
        | Some v -> sPDX231devRelationshipsRelationshipType_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devRelationships"
              "relationshipType"
      in
      { spdxElementId; comment; relatedSpdxElement; relationshipType }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devRelationships" x

let yojson_of_sPDX231devRelationships (x : sPDX231devRelationships) :
    Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "spdxElementId",
             Atdml_runtime.Yojson.yojson_of_string x.spdxElementId );
         ];
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [
           ( "relatedSpdxElement",
             Atdml_runtime.Yojson.yojson_of_string x.relatedSpdxElement );
         ];
         [
           ( "relationshipType",
             yojson_of_sPDX231devRelationshipsRelationshipType
               x.relationshipType );
         ];
       ])

let sPDX231devRelationships_of_json s =
  sPDX231devRelationships_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devRelationships x =
  Yojson.Safe.to_string (yojson_of_sPDX231devRelationships x)

module SPDX231devRelationships = struct
  type nonrec t = sPDX231devRelationships

  let create = create_sPDX231devRelationships
  let of_yojson = sPDX231devRelationships_of_yojson
  let to_yojson = yojson_of_sPDX231devRelationships
  let of_json = sPDX231devRelationships_of_json
  let to_json = json_of_sPDX231devRelationships
end

(** This field provides information about the primary purpose of the identified
    package. Package Purpose is intrinsic to how the package is being used
    rather than the content of the package. *)
type sPDX231devPackagesPrimaryPackagePurpose =
  | OTHER
  | INSTALL
  | ARCHIVE
  | FIRMWARE
  | APPLICATION
  | FRAMEWORK
  | LIBRARY
  | CONTAINER
  | SOURCE
  | DEVICE
  | OPERATINGSYSTEM
  | FILE

let sPDX231devPackagesPrimaryPackagePurpose_of_yojson (x : Yojson.Safe.t) :
    sPDX231devPackagesPrimaryPackagePurpose =
  match x with
  | `String "OTHER" -> OTHER
  | `String "INSTALL" -> INSTALL
  | `String "ARCHIVE" -> ARCHIVE
  | `String "FIRMWARE" -> FIRMWARE
  | `String "APPLICATION" -> APPLICATION
  | `String "FRAMEWORK" -> FRAMEWORK
  | `String "LIBRARY" -> LIBRARY
  | `String "CONTAINER" -> CONTAINER
  | `String "SOURCE" -> SOURCE
  | `String "DEVICE" -> DEVICE
  | `String "OPERATING-SYSTEM" -> OPERATINGSYSTEM
  | `String "FILE" -> FILE
  | _ ->
      Atdml_runtime.Yojson.bad_sum "sPDX231devPackagesPrimaryPackagePurpose" x

let yojson_of_sPDX231devPackagesPrimaryPackagePurpose
    (x : sPDX231devPackagesPrimaryPackagePurpose) : Yojson.Safe.t =
  match x with
  | OTHER -> `String "OTHER"
  | INSTALL -> `String "INSTALL"
  | ARCHIVE -> `String "ARCHIVE"
  | FIRMWARE -> `String "FIRMWARE"
  | APPLICATION -> `String "APPLICATION"
  | FRAMEWORK -> `String "FRAMEWORK"
  | LIBRARY -> `String "LIBRARY"
  | CONTAINER -> `String "CONTAINER"
  | SOURCE -> `String "SOURCE"
  | DEVICE -> `String "DEVICE"
  | OPERATINGSYSTEM -> `String "OPERATING-SYSTEM"
  | FILE -> `String "FILE"

let sPDX231devPackagesPrimaryPackagePurpose_of_json s =
  sPDX231devPackagesPrimaryPackagePurpose_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesPrimaryPackagePurpose x =
  Yojson.Safe.to_string (yojson_of_sPDX231devPackagesPrimaryPackagePurpose x)

module SPDX231devPackagesPrimaryPackagePurpose = struct
  type nonrec t = sPDX231devPackagesPrimaryPackagePurpose

  let of_yojson = sPDX231devPackagesPrimaryPackagePurpose_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesPrimaryPackagePurpose
  let of_json = sPDX231devPackagesPrimaryPackagePurpose_of_json
  let to_json = json_of_sPDX231devPackagesPrimaryPackagePurpose
end

type sPDX231devPackagesPackageVerificationCode = {
  packageVerificationCodeExcludedFiles : string list option;
      (** A file that was excluded when calculating the package verification
          code. This is usually a file containing SPDX data regarding the
          package. If a package contains more than one SPDX file all SPDX files
          must be excluded from the package verification code. If this is not
          done it would be impossible to correctly calculate the verification
          codes in both files. *)
  packageVerificationCodeValue : string;
      (** The actual package verification code as a hex encoded value. *)
}
(** A manifest based verification code (the algorithm is defined in section 4.7
    of the full specification) of the SPDX Item. This allows consumers of this
    data and/or database to determine if an SPDX item they have in hand is
    identical to the SPDX item from which the data was produced. This algorithm
    works even if the SPDX document is included in the SPDX item. *)

let create_sPDX231devPackagesPackageVerificationCode
    ?packageVerificationCodeExcludedFiles ~packageVerificationCodeValue () :
    sPDX231devPackagesPackageVerificationCode =
  { packageVerificationCodeExcludedFiles; packageVerificationCodeValue }

let sPDX231devPackagesPackageVerificationCode_of_yojson (x : Yojson.Safe.t) :
    sPDX231devPackagesPackageVerificationCode =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let packageVerificationCodeExcludedFiles =
        match assoc_ "packageVerificationCodeExcludedFiles" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let packageVerificationCodeValue =
        match assoc_ "packageVerificationCodeValue" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devPackagesPackageVerificationCode"
              "packageVerificationCodeValue"
      in
      { packageVerificationCodeExcludedFiles; packageVerificationCodeValue }
  | _ ->
      Atdml_runtime.Yojson.bad_type "sPDX231devPackagesPackageVerificationCode"
        x

let yojson_of_sPDX231devPackagesPackageVerificationCode
    (x : sPDX231devPackagesPackageVerificationCode) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         (match x.packageVerificationCodeExcludedFiles with
         | None -> []
         | Some v ->
             [
               ( "packageVerificationCodeExcludedFiles",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         [
           ( "packageVerificationCodeValue",
             Atdml_runtime.Yojson.yojson_of_string
               x.packageVerificationCodeValue );
         ];
       ])

let sPDX231devPackagesPackageVerificationCode_of_json s =
  sPDX231devPackagesPackageVerificationCode_of_yojson
    (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesPackageVerificationCode x =
  Yojson.Safe.to_string (yojson_of_sPDX231devPackagesPackageVerificationCode x)

module SPDX231devPackagesPackageVerificationCode = struct
  type nonrec t = sPDX231devPackagesPackageVerificationCode

  let create = create_sPDX231devPackagesPackageVerificationCode
  let of_yojson = sPDX231devPackagesPackageVerificationCode_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesPackageVerificationCode
  let of_json = sPDX231devPackagesPackageVerificationCode_of_json
  let to_json = json_of_sPDX231devPackagesPackageVerificationCode
end

(** Category for the external reference *)
type sPDX231devPackagesExternalRefsReferenceCategory =
  | OTHER
  | PERSISTENTID
  | PERSISTENT_ID
  | SECURITY
  | PACKAGEMANAGER
  | PACKAGE_MANAGER

let sPDX231devPackagesExternalRefsReferenceCategory_of_yojson
    (x : Yojson.Safe.t) : sPDX231devPackagesExternalRefsReferenceCategory =
  match x with
  | `String "OTHER" -> OTHER
  | `String "PERSISTENT-ID" -> PERSISTENTID
  | `String "PERSISTENT_ID" -> PERSISTENT_ID
  | `String "SECURITY" -> SECURITY
  | `String "PACKAGE-MANAGER" -> PACKAGEMANAGER
  | `String "PACKAGE_MANAGER" -> PACKAGE_MANAGER
  | _ ->
      Atdml_runtime.Yojson.bad_sum
        "sPDX231devPackagesExternalRefsReferenceCategory" x

let yojson_of_sPDX231devPackagesExternalRefsReferenceCategory
    (x : sPDX231devPackagesExternalRefsReferenceCategory) : Yojson.Safe.t =
  match x with
  | OTHER -> `String "OTHER"
  | PERSISTENTID -> `String "PERSISTENT-ID"
  | PERSISTENT_ID -> `String "PERSISTENT_ID"
  | SECURITY -> `String "SECURITY"
  | PACKAGEMANAGER -> `String "PACKAGE-MANAGER"
  | PACKAGE_MANAGER -> `String "PACKAGE_MANAGER"

let sPDX231devPackagesExternalRefsReferenceCategory_of_json s =
  sPDX231devPackagesExternalRefsReferenceCategory_of_yojson
    (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesExternalRefsReferenceCategory x =
  Yojson.Safe.to_string
    (yojson_of_sPDX231devPackagesExternalRefsReferenceCategory x)

module SPDX231devPackagesExternalRefsReferenceCategory = struct
  type nonrec t = sPDX231devPackagesExternalRefsReferenceCategory

  let of_yojson = sPDX231devPackagesExternalRefsReferenceCategory_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesExternalRefsReferenceCategory
  let of_json = sPDX231devPackagesExternalRefsReferenceCategory_of_json
  let to_json = json_of_sPDX231devPackagesExternalRefsReferenceCategory
end

type sPDX231devPackagesExternalRefs = {
  comment : string option;
  referenceCategory : sPDX231devPackagesExternalRefsReferenceCategory;
      (** Category for the external reference *)
  referenceLocator : string;
      (** The unique string with no spaces necessary to access the
          package-specific information, metadata, or content within the target
          location. The format of the locator is subject to constraints defined
          by the <type>. *)
  referenceType : string;
      (** Type of the external reference. These are defined in an appendix in
          the SPDX specification. *)
}
(** An External Reference allows a Package to reference an external source of
    additional information, metadata, enumerations, asset identifiers, or
    downloadable content believed to be relevant to the Package. *)

let create_sPDX231devPackagesExternalRefs ?comment ~referenceCategory
    ~referenceLocator ~referenceType () : sPDX231devPackagesExternalRefs =
  { comment; referenceCategory; referenceLocator; referenceType }

let sPDX231devPackagesExternalRefs_of_yojson (x : Yojson.Safe.t) :
    sPDX231devPackagesExternalRefs =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let referenceCategory =
        match assoc_ "referenceCategory" with
        | Some v -> sPDX231devPackagesExternalRefsReferenceCategory_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesExternalRefs"
              "referenceCategory"
      in
      let referenceLocator =
        match assoc_ "referenceLocator" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesExternalRefs"
              "referenceLocator"
      in
      let referenceType =
        match assoc_ "referenceType" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesExternalRefs"
              "referenceType"
      in
      { comment; referenceCategory; referenceLocator; referenceType }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devPackagesExternalRefs" x

let yojson_of_sPDX231devPackagesExternalRefs
    (x : sPDX231devPackagesExternalRefs) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [
           ( "referenceCategory",
             yojson_of_sPDX231devPackagesExternalRefsReferenceCategory
               x.referenceCategory );
         ];
         [
           ( "referenceLocator",
             Atdml_runtime.Yojson.yojson_of_string x.referenceLocator );
         ];
         [
           ( "referenceType",
             Atdml_runtime.Yojson.yojson_of_string x.referenceType );
         ];
       ])

let sPDX231devPackagesExternalRefs_of_json s =
  sPDX231devPackagesExternalRefs_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesExternalRefs x =
  Yojson.Safe.to_string (yojson_of_sPDX231devPackagesExternalRefs x)

module SPDX231devPackagesExternalRefs = struct
  type nonrec t = sPDX231devPackagesExternalRefs

  let create = create_sPDX231devPackagesExternalRefs
  let of_yojson = sPDX231devPackagesExternalRefs_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesExternalRefs
  let of_json = sPDX231devPackagesExternalRefs_of_json
  let to_json = json_of_sPDX231devPackagesExternalRefs
end

(** Identifies the algorithm used to produce the subject Checksum. Currently,
    SHA-1 is the only supported algorithm. It is anticipated that other
    algorithms will be supported at a later time. *)
type sPDX231devPackagesChecksumsAlgorithm =
  | SHA1
  | BLAKE3
  | SHA3384
  | SHA256
  | SHA384
  | BLAKE2b512
  | BLAKE2b256
  | SHA3512
  | MD2
  | ADLER32
  | MD4
  | SHA3256
  | BLAKE2b384
  | SHA512
  | MD6
  | MD5
  | SHA224

let sPDX231devPackagesChecksumsAlgorithm_of_yojson (x : Yojson.Safe.t) :
    sPDX231devPackagesChecksumsAlgorithm =
  match x with
  | `String "SHA1" -> SHA1
  | `String "BLAKE3" -> BLAKE3
  | `String "SHA3-384" -> SHA3384
  | `String "SHA256" -> SHA256
  | `String "SHA384" -> SHA384
  | `String "BLAKE2b-512" -> BLAKE2b512
  | `String "BLAKE2b-256" -> BLAKE2b256
  | `String "SHA3-512" -> SHA3512
  | `String "MD2" -> MD2
  | `String "ADLER32" -> ADLER32
  | `String "MD4" -> MD4
  | `String "SHA3-256" -> SHA3256
  | `String "BLAKE2b-384" -> BLAKE2b384
  | `String "SHA512" -> SHA512
  | `String "MD6" -> MD6
  | `String "MD5" -> MD5
  | `String "SHA224" -> SHA224
  | _ -> Atdml_runtime.Yojson.bad_sum "sPDX231devPackagesChecksumsAlgorithm" x

let yojson_of_sPDX231devPackagesChecksumsAlgorithm
    (x : sPDX231devPackagesChecksumsAlgorithm) : Yojson.Safe.t =
  match x with
  | SHA1 -> `String "SHA1"
  | BLAKE3 -> `String "BLAKE3"
  | SHA3384 -> `String "SHA3-384"
  | SHA256 -> `String "SHA256"
  | SHA384 -> `String "SHA384"
  | BLAKE2b512 -> `String "BLAKE2b-512"
  | BLAKE2b256 -> `String "BLAKE2b-256"
  | SHA3512 -> `String "SHA3-512"
  | MD2 -> `String "MD2"
  | ADLER32 -> `String "ADLER32"
  | MD4 -> `String "MD4"
  | SHA3256 -> `String "SHA3-256"
  | BLAKE2b384 -> `String "BLAKE2b-384"
  | SHA512 -> `String "SHA512"
  | MD6 -> `String "MD6"
  | MD5 -> `String "MD5"
  | SHA224 -> `String "SHA224"

let sPDX231devPackagesChecksumsAlgorithm_of_json s =
  sPDX231devPackagesChecksumsAlgorithm_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesChecksumsAlgorithm x =
  Yojson.Safe.to_string (yojson_of_sPDX231devPackagesChecksumsAlgorithm x)

module SPDX231devPackagesChecksumsAlgorithm = struct
  type nonrec t = sPDX231devPackagesChecksumsAlgorithm

  let of_yojson = sPDX231devPackagesChecksumsAlgorithm_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesChecksumsAlgorithm
  let of_json = sPDX231devPackagesChecksumsAlgorithm_of_json
  let to_json = json_of_sPDX231devPackagesChecksumsAlgorithm
end

type sPDX231devPackagesChecksums = {
  algorithm : sPDX231devPackagesChecksumsAlgorithm;
      (** Identifies the algorithm used to produce the subject Checksum.
          Currently, SHA-1 is the only supported algorithm. It is anticipated
          that other algorithms will be supported at a later time. *)
  checksumValue : string;
      (** The checksumValue property provides a lower case hexadecimal encoded
          digest value produced using a specific algorithm. *)
}
(** A Checksum is value that allows the contents of a file to be authenticated.
    Even small changes to the content of the file will change its checksum. This
    class allows the results of a variety of checksum and cryptographic message
    digest algorithms to be represented. *)

let create_sPDX231devPackagesChecksums ~algorithm ~checksumValue () :
    sPDX231devPackagesChecksums =
  { algorithm; checksumValue }

let sPDX231devPackagesChecksums_of_yojson (x : Yojson.Safe.t) :
    sPDX231devPackagesChecksums =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let algorithm =
        match assoc_ "algorithm" with
        | Some v -> sPDX231devPackagesChecksumsAlgorithm_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesChecksums"
              "algorithm"
      in
      let checksumValue =
        match assoc_ "checksumValue" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesChecksums"
              "checksumValue"
      in
      { algorithm; checksumValue }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devPackagesChecksums" x

let yojson_of_sPDX231devPackagesChecksums (x : sPDX231devPackagesChecksums) :
    Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "algorithm",
             yojson_of_sPDX231devPackagesChecksumsAlgorithm x.algorithm );
         ];
         [
           ( "checksumValue",
             Atdml_runtime.Yojson.yojson_of_string x.checksumValue );
         ];
       ])

let sPDX231devPackagesChecksums_of_json s =
  sPDX231devPackagesChecksums_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesChecksums x =
  Yojson.Safe.to_string (yojson_of_sPDX231devPackagesChecksums x)

module SPDX231devPackagesChecksums = struct
  type nonrec t = sPDX231devPackagesChecksums

  let create = create_sPDX231devPackagesChecksums
  let of_yojson = sPDX231devPackagesChecksums_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesChecksums
  let of_json = sPDX231devPackagesChecksums_of_json
  let to_json = json_of_sPDX231devPackagesChecksums
end

(** Type of the annotation. *)
type sPDX231devPackagesAnnotationsAnnotationType = OTHER | REVIEW

let sPDX231devPackagesAnnotationsAnnotationType_of_yojson (x : Yojson.Safe.t) :
    sPDX231devPackagesAnnotationsAnnotationType =
  match x with
  | `String "OTHER" -> OTHER
  | `String "REVIEW" -> REVIEW
  | _ ->
      Atdml_runtime.Yojson.bad_sum "sPDX231devPackagesAnnotationsAnnotationType"
        x

let yojson_of_sPDX231devPackagesAnnotationsAnnotationType
    (x : sPDX231devPackagesAnnotationsAnnotationType) : Yojson.Safe.t =
  match x with
  | OTHER -> `String "OTHER"
  | REVIEW -> `String "REVIEW"

let sPDX231devPackagesAnnotationsAnnotationType_of_json s =
  sPDX231devPackagesAnnotationsAnnotationType_of_yojson
    (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesAnnotationsAnnotationType x =
  Yojson.Safe.to_string
    (yojson_of_sPDX231devPackagesAnnotationsAnnotationType x)

module SPDX231devPackagesAnnotationsAnnotationType = struct
  type nonrec t = sPDX231devPackagesAnnotationsAnnotationType

  let of_yojson = sPDX231devPackagesAnnotationsAnnotationType_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesAnnotationsAnnotationType
  let of_json = sPDX231devPackagesAnnotationsAnnotationType_of_json
  let to_json = json_of_sPDX231devPackagesAnnotationsAnnotationType
end

type sPDX231devPackagesAnnotations = {
  annotationDate : string;
      (** Identify when the comment was made. This is to be specified according
          to the combined date and time in the UTC format, as specified in the
          ISO 8601 standard. *)
  annotationType : sPDX231devPackagesAnnotationsAnnotationType;
      (** Type of the annotation. *)
  annotator : string;
      (** This field identifies the person, organization, or tool that has
          commented on a file, package, snippet, or the entire document. *)
  comment : string;
}
(** An Annotation is a comment on an SpdxItem by an agent. *)

let create_sPDX231devPackagesAnnotations ~annotationDate ~annotationType
    ~annotator ~comment () : sPDX231devPackagesAnnotations =
  { annotationDate; annotationType; annotator; comment }

let sPDX231devPackagesAnnotations_of_yojson (x : Yojson.Safe.t) :
    sPDX231devPackagesAnnotations =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let annotationDate =
        match assoc_ "annotationDate" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesAnnotations"
              "annotationDate"
      in
      let annotationType =
        match assoc_ "annotationType" with
        | Some v -> sPDX231devPackagesAnnotationsAnnotationType_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesAnnotations"
              "annotationType"
      in
      let annotator =
        match assoc_ "annotator" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesAnnotations"
              "annotator"
      in
      let comment =
        match assoc_ "comment" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackagesAnnotations"
              "comment"
      in
      { annotationDate; annotationType; annotator; comment }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devPackagesAnnotations" x

let yojson_of_sPDX231devPackagesAnnotations (x : sPDX231devPackagesAnnotations)
    : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "annotationDate",
             Atdml_runtime.Yojson.yojson_of_string x.annotationDate );
         ];
         [
           ( "annotationType",
             yojson_of_sPDX231devPackagesAnnotationsAnnotationType
               x.annotationType );
         ];
         [ ("annotator", Atdml_runtime.Yojson.yojson_of_string x.annotator) ];
         [ ("comment", Atdml_runtime.Yojson.yojson_of_string x.comment) ];
       ])

let sPDX231devPackagesAnnotations_of_json s =
  sPDX231devPackagesAnnotations_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devPackagesAnnotations x =
  Yojson.Safe.to_string (yojson_of_sPDX231devPackagesAnnotations x)

module SPDX231devPackagesAnnotations = struct
  type nonrec t = sPDX231devPackagesAnnotations

  let create = create_sPDX231devPackagesAnnotations
  let of_yojson = sPDX231devPackagesAnnotations_of_yojson
  let to_yojson = yojson_of_sPDX231devPackagesAnnotations
  let of_json = sPDX231devPackagesAnnotations_of_json
  let to_json = json_of_sPDX231devPackagesAnnotations
end

type sPDX231devPackages = {
  sPDXID : string;
      (** Uniquely identify any element in an SPDX document which may be
          referenced by other elements. *)
  annotations : sPDX231devPackagesAnnotations list option;
      (** Provide additional information about an SpdxElement. *)
  attributionTexts : string list option;
      (** This field provides a place for the SPDX data creator to record
          acknowledgements that may be required to be communicated in some
          contexts. This is not meant to include the actual complete license
          text (see licenseConcluded and licenseDeclared), and may or may not
          include copyright notices (see also copyrightText). The SPDX data
          creator may use this field to record other acknowledgements, such as
          particular clauses from license texts, which may be necessary or
          desirable to reproduce. *)
  builtDate : string option;
      (** This field provides a place for recording the actual date the package
          was built. *)
  checksums : sPDX231devPackagesChecksums list option;
      (** The checksum property provides a mechanism that can be used to verify
          that the contents of a File or Package have not changed. *)
  comment : string option;
  copyrightText : string option;
      (** The text of copyright declarations recited in the package, file or
          snippet.

          If the copyrightText field is not present, it implies an equivalent
          meaning to NOASSERTION. *)
  description : string option;
      (** Provides a detailed description of the package. *)
  downloadLocation : string;
      (** The URI at which this package is available for download. Private
          (i.e., not publicly reachable) URIs are acceptable as values of this
          property. The values http://spdx.org/rdf/terms#none and
          http://spdx.org/rdf/terms#noassertion may be used to specify that the
          package is not downloadable or that no attempt was made to determine
          its download location, respectively. *)
  externalRefs : sPDX231devPackagesExternalRefs list option;
      (** An External Reference allows a Package to reference an external source
          of additional information, metadata, enumerations, asset identifiers,
          or downloadable content believed to be relevant to the Package. *)
  filesAnalyzed : bool option;
      (** Indicates whether the file content of this package has been available
          for or subjected to analysis when creating the SPDX document. If false
          indicates packages that represent metadata or URI references to a
          project, product, artifact, distribution or a component. If set to
          false, the package must not contain any files. *)
  hasFiles : string list option;
      (** DEPRECATED: use relationships instead of this field. Indicates that a
          particular file belongs to a package. *)
  homepage : string option;
  licenseComments : string option;
      (** The licenseComments property allows the preparer of the SPDX document
          to describe why the licensing in spdx:licenseConcluded was chosen. *)
  licenseConcluded : string option;
      (** License expression for licenseConcluded. See SPDX Annex D for the
          license expression syntax. The licensing that the preparer of this
          SPDX document has concluded, based on the evidence, actually applies
          to the SPDX Item.

          If the licenseConcluded field is not present for an SPDX Item, it
          implies an equivalent meaning to NOASSERTION. *)
  licenseDeclared : string option;
      (** License expression for licenseDeclared. See SPDX Annex D for the
          license expression syntax. The licensing that the creators of the
          software in the package, or the packager, have declared. Declarations
          by the original software creator should be preferred, if they exist.
      *)
  licenseInfoFromFiles : string list option;
      (** The licensing information that was discovered directly within the
          package. There will be an instance of this property for each distinct
          value of all licenseInfoInFile properties of all files contained in
          the package.

          If the licenseInfoFromFiles field is not present for a package and
          filesAnalyzed property for that same package is true or omitted, it
          implies an equivalent meaning to NOASSERTION. *)
  name : string;  (** Identify name of this SpdxElement. *)
  originator : string option;
      (** The name and, optionally, contact information of the person or
          organization that originally created the package. Values of this
          property must conform to the agent and tool syntax. *)
  packageFileName : string option;
      (** The base name of the package file name. For example,
          zlib-1.2.5.tar.gz. *)
  packageVerificationCode : sPDX231devPackagesPackageVerificationCode option;
      (** A manifest based verification code (the algorithm is defined in
          section 4.7 of the full specification) of the SPDX Item. This allows
          consumers of this data and/or database to determine if an SPDX item
          they have in hand is identical to the SPDX item from which the data
          was produced. This algorithm works even if the SPDX document is
          included in the SPDX item. *)
  primaryPackagePurpose : sPDX231devPackagesPrimaryPackagePurpose option;
      (** This field provides information about the primary purpose of the
          identified package. Package Purpose is intrinsic to how the package is
          being used rather than the content of the package. *)
  releaseDate : string option;
      (** This field provides a place for recording the date the package was
          released. *)
  sourceInfo : string option;
      (** Allows the producer(s) of the SPDX document to describe how the
          package was acquired and/or changed from the original source. *)
  summary : string option;  (** Provides a short description of the package. *)
  supplier : string option;
      (** The name and, optionally, contact information of the person or
          organization who was the immediate supplier of this package to the
          recipient. The supplier may be different than originator when the
          software has been repackaged. Values of this property must conform to
          the agent and tool syntax. *)
  validUntilDate : string option;
      (** This field provides a place for recording the end of the support
          period for a package from the supplier. *)
  versionInfo : string option;
      (** Provides an indication of the version of the package that is described
          by this SpdxDocument. *)
}

let create_sPDX231devPackages ~sPDXID ?annotations ?attributionTexts ?builtDate
    ?checksums ?comment ?copyrightText ?description ~downloadLocation
    ?externalRefs ?filesAnalyzed ?hasFiles ?homepage ?licenseComments
    ?licenseConcluded ?licenseDeclared ?licenseInfoFromFiles ~name ?originator
    ?packageFileName ?packageVerificationCode ?primaryPackagePurpose
    ?releaseDate ?sourceInfo ?summary ?supplier ?validUntilDate ?versionInfo ()
    : sPDX231devPackages =
  {
    sPDXID;
    annotations;
    attributionTexts;
    builtDate;
    checksums;
    comment;
    copyrightText;
    description;
    downloadLocation;
    externalRefs;
    filesAnalyzed;
    hasFiles;
    homepage;
    licenseComments;
    licenseConcluded;
    licenseDeclared;
    licenseInfoFromFiles;
    name;
    originator;
    packageFileName;
    packageVerificationCode;
    primaryPackagePurpose;
    releaseDate;
    sourceInfo;
    summary;
    supplier;
    validUntilDate;
    versionInfo;
  }

let sPDX231devPackages_of_yojson (x : Yojson.Safe.t) : sPDX231devPackages =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let sPDXID =
        match assoc_ "SPDXID" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackages" "SPDXID"
      in
      let annotations =
        match assoc_ "annotations" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devPackagesAnnotations_of_yojson)
                 v)
      in
      let attributionTexts =
        match assoc_ "attributionTexts" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let builtDate =
        match assoc_ "builtDate" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let checksums =
        match assoc_ "checksums" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devPackagesChecksums_of_yojson)
                 v)
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let copyrightText =
        match assoc_ "copyrightText" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let description =
        match assoc_ "description" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let downloadLocation =
        match assoc_ "downloadLocation" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devPackages"
              "downloadLocation"
      in
      let externalRefs =
        match assoc_ "externalRefs" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devPackagesExternalRefs_of_yojson)
                 v)
      in
      let filesAnalyzed =
        match assoc_ "filesAnalyzed" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.bool_of_yojson v)
      in
      let hasFiles =
        match assoc_ "hasFiles" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let homepage =
        match assoc_ "homepage" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseComments =
        match assoc_ "licenseComments" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseConcluded =
        match assoc_ "licenseConcluded" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseDeclared =
        match assoc_ "licenseDeclared" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseInfoFromFiles =
        match assoc_ "licenseInfoFromFiles" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let name =
        match assoc_ "name" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "sPDX231devPackages" "name"
      in
      let originator =
        match assoc_ "originator" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let packageFileName =
        match assoc_ "packageFileName" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let packageVerificationCode =
        match assoc_ "packageVerificationCode" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (sPDX231devPackagesPackageVerificationCode_of_yojson v)
      in
      let primaryPackagePurpose =
        match assoc_ "primaryPackagePurpose" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (sPDX231devPackagesPrimaryPackagePurpose_of_yojson v)
      in
      let releaseDate =
        match assoc_ "releaseDate" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let sourceInfo =
        match assoc_ "sourceInfo" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let summary =
        match assoc_ "summary" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let supplier =
        match assoc_ "supplier" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let validUntilDate =
        match assoc_ "validUntilDate" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let versionInfo =
        match assoc_ "versionInfo" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      {
        sPDXID;
        annotations;
        attributionTexts;
        builtDate;
        checksums;
        comment;
        copyrightText;
        description;
        downloadLocation;
        externalRefs;
        filesAnalyzed;
        hasFiles;
        homepage;
        licenseComments;
        licenseConcluded;
        licenseDeclared;
        licenseInfoFromFiles;
        name;
        originator;
        packageFileName;
        packageVerificationCode;
        primaryPackagePurpose;
        releaseDate;
        sourceInfo;
        summary;
        supplier;
        validUntilDate;
        versionInfo;
      }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devPackages" x

let yojson_of_sPDX231devPackages (x : sPDX231devPackages) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("SPDXID", Atdml_runtime.Yojson.yojson_of_string x.sPDXID) ];
         (match x.annotations with
         | None -> []
         | Some v ->
             [
               ( "annotations",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devPackagesAnnotations)
                   v );
             ]);
         (match x.attributionTexts with
         | None -> []
         | Some v ->
             [
               ( "attributionTexts",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         (match x.builtDate with
         | None -> []
         | Some v -> [ ("builtDate", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.checksums with
         | None -> []
         | Some v ->
             [
               ( "checksums",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devPackagesChecksums)
                   v );
             ]);
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.copyrightText with
         | None -> []
         | Some v ->
             [ ("copyrightText", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.description with
         | None -> []
         | Some v ->
             [ ("description", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [
           ( "downloadLocation",
             Atdml_runtime.Yojson.yojson_of_string x.downloadLocation );
         ];
         (match x.externalRefs with
         | None -> []
         | Some v ->
             [
               ( "externalRefs",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devPackagesExternalRefs)
                   v );
             ]);
         (match x.filesAnalyzed with
         | None -> []
         | Some v ->
             [ ("filesAnalyzed", Atdml_runtime.Yojson.yojson_of_bool v) ]);
         (match x.hasFiles with
         | None -> []
         | Some v ->
             [
               ( "hasFiles",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         (match x.homepage with
         | None -> []
         | Some v -> [ ("homepage", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseComments with
         | None -> []
         | Some v ->
             [ ("licenseComments", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseConcluded with
         | None -> []
         | Some v ->
             [ ("licenseConcluded", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseDeclared with
         | None -> []
         | Some v ->
             [ ("licenseDeclared", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseInfoFromFiles with
         | None -> []
         | Some v ->
             [
               ( "licenseInfoFromFiles",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         [ ("name", Atdml_runtime.Yojson.yojson_of_string x.name) ];
         (match x.originator with
         | None -> []
         | Some v -> [ ("originator", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.packageFileName with
         | None -> []
         | Some v ->
             [ ("packageFileName", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.packageVerificationCode with
         | None -> []
         | Some v ->
             [
               ( "packageVerificationCode",
                 yojson_of_sPDX231devPackagesPackageVerificationCode v );
             ]);
         (match x.primaryPackagePurpose with
         | None -> []
         | Some v ->
             [
               ( "primaryPackagePurpose",
                 yojson_of_sPDX231devPackagesPrimaryPackagePurpose v );
             ]);
         (match x.releaseDate with
         | None -> []
         | Some v ->
             [ ("releaseDate", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.sourceInfo with
         | None -> []
         | Some v -> [ ("sourceInfo", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.summary with
         | None -> []
         | Some v -> [ ("summary", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.supplier with
         | None -> []
         | Some v -> [ ("supplier", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.validUntilDate with
         | None -> []
         | Some v ->
             [ ("validUntilDate", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.versionInfo with
         | None -> []
         | Some v ->
             [ ("versionInfo", Atdml_runtime.Yojson.yojson_of_string v) ]);
       ])

let sPDX231devPackages_of_json s =
  sPDX231devPackages_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devPackages x =
  Yojson.Safe.to_string (yojson_of_sPDX231devPackages x)

module SPDX231devPackages = struct
  type nonrec t = sPDX231devPackages

  let create = create_sPDX231devPackages
  let of_yojson = sPDX231devPackages_of_yojson
  let to_yojson = yojson_of_sPDX231devPackages
  let of_json = sPDX231devPackages_of_json
  let to_json = json_of_sPDX231devPackages
end

type sPDX231devHasExtractedLicensingInfosCrossRefs = {
  isLive : bool option;
      (** Indicate a URL is still a live accessible location on the public
          internet *)
  isValid : bool option;  (** True if the URL is a valid well formed URL *)
  isWayBackLink : bool option;
      (** True if the License SeeAlso URL points to a Wayback archive *)
  match_ : string option;
      (** Status of a License List SeeAlso URL reference if it refers to a
          website that matches the license text. *)
  order : int option;  (** The ordinal order of this element within a list *)
  timestamp : string option;  (** Timestamp *)
  url : string;  (** URL Reference *)
}
(** Cross reference details for the a URL reference *)

let create_sPDX231devHasExtractedLicensingInfosCrossRefs ?isLive ?isValid
    ?isWayBackLink ?match_ ?order ?timestamp ~url () :
    sPDX231devHasExtractedLicensingInfosCrossRefs =
  { isLive; isValid; isWayBackLink; match_; order; timestamp; url }

let sPDX231devHasExtractedLicensingInfosCrossRefs_of_yojson (x : Yojson.Safe.t)
    : sPDX231devHasExtractedLicensingInfosCrossRefs =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let isLive =
        match assoc_ "isLive" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.bool_of_yojson v)
      in
      let isValid =
        match assoc_ "isValid" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.bool_of_yojson v)
      in
      let isWayBackLink =
        match assoc_ "isWayBackLink" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.bool_of_yojson v)
      in
      let match_ =
        match assoc_ "match" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let order =
        match assoc_ "order" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.int_of_yojson v)
      in
      let timestamp =
        match assoc_ "timestamp" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let url =
        match assoc_ "url" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devHasExtractedLicensingInfosCrossRefs" "url"
      in
      { isLive; isValid; isWayBackLink; match_; order; timestamp; url }
  | _ ->
      Atdml_runtime.Yojson.bad_type
        "sPDX231devHasExtractedLicensingInfosCrossRefs" x

let yojson_of_sPDX231devHasExtractedLicensingInfosCrossRefs
    (x : sPDX231devHasExtractedLicensingInfosCrossRefs) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         (match x.isLive with
         | None -> []
         | Some v -> [ ("isLive", Atdml_runtime.Yojson.yojson_of_bool v) ]);
         (match x.isValid with
         | None -> []
         | Some v -> [ ("isValid", Atdml_runtime.Yojson.yojson_of_bool v) ]);
         (match x.isWayBackLink with
         | None -> []
         | Some v ->
             [ ("isWayBackLink", Atdml_runtime.Yojson.yojson_of_bool v) ]);
         (match x.match_ with
         | None -> []
         | Some v -> [ ("match", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.order with
         | None -> []
         | Some v -> [ ("order", Atdml_runtime.Yojson.yojson_of_int v) ]);
         (match x.timestamp with
         | None -> []
         | Some v -> [ ("timestamp", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [ ("url", Atdml_runtime.Yojson.yojson_of_string x.url) ];
       ])

let sPDX231devHasExtractedLicensingInfosCrossRefs_of_json s =
  sPDX231devHasExtractedLicensingInfosCrossRefs_of_yojson
    (Yojson.Safe.from_string s)

let json_of_sPDX231devHasExtractedLicensingInfosCrossRefs x =
  Yojson.Safe.to_string
    (yojson_of_sPDX231devHasExtractedLicensingInfosCrossRefs x)

module SPDX231devHasExtractedLicensingInfosCrossRefs = struct
  type nonrec t = sPDX231devHasExtractedLicensingInfosCrossRefs

  let create = create_sPDX231devHasExtractedLicensingInfosCrossRefs
  let of_yojson = sPDX231devHasExtractedLicensingInfosCrossRefs_of_yojson
  let to_yojson = yojson_of_sPDX231devHasExtractedLicensingInfosCrossRefs
  let of_json = sPDX231devHasExtractedLicensingInfosCrossRefs_of_json
  let to_json = json_of_sPDX231devHasExtractedLicensingInfosCrossRefs
end

type sPDX231devHasExtractedLicensingInfos = {
  comment : string option;
  crossRefs : sPDX231devHasExtractedLicensingInfosCrossRefs list option;
      (** Cross Reference Detail for a license SeeAlso URL *)
  extractedText : string;
      (** Provide a copy of the actual text of the license reference extracted
          from the package, file or snippet that is associated with the License
          Identifier to aid in future analysis. *)
  licenseId : string;
      (** A human readable short form license identifier for a license. The
          license ID is either on the standard license list or the form
          "LicenseRef-\[idString\]" where \[idString\] is a unique string
          containing letters, numbers, "." or "-". When used within a license
          expression, the license ID can optionally include a reference to an
          external document in the form
          "DocumentRef-\[docrefIdString\]:LicenseRef-\[idString\]" where
          docRefIdString is an ID for an external document reference. *)
  name : string option;  (** Identify name of this SpdxElement. *)
  seeAlsos : string list option;
}
(** An ExtractedLicensingInfo represents a license or licensing notice that was
    found in a package, file or snippet. Any license text that is recognized as
    a license may be represented as a License rather than an
    ExtractedLicensingInfo. *)

let create_sPDX231devHasExtractedLicensingInfos ?comment ?crossRefs
    ~extractedText ~licenseId ?name ?seeAlsos () :
    sPDX231devHasExtractedLicensingInfos =
  { comment; crossRefs; extractedText; licenseId; name; seeAlsos }

let sPDX231devHasExtractedLicensingInfos_of_yojson (x : Yojson.Safe.t) :
    sPDX231devHasExtractedLicensingInfos =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let crossRefs =
        match assoc_ "crossRefs" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devHasExtractedLicensingInfosCrossRefs_of_yojson)
                 v)
      in
      let extractedText =
        match assoc_ "extractedText" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devHasExtractedLicensingInfos" "extractedText"
      in
      let licenseId =
        match assoc_ "licenseId" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devHasExtractedLicensingInfos" "licenseId"
      in
      let name =
        match assoc_ "name" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let seeAlsos =
        match assoc_ "seeAlsos" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      { comment; crossRefs; extractedText; licenseId; name; seeAlsos }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devHasExtractedLicensingInfos" x

let yojson_of_sPDX231devHasExtractedLicensingInfos
    (x : sPDX231devHasExtractedLicensingInfos) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.crossRefs with
         | None -> []
         | Some v ->
             [
               ( "crossRefs",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devHasExtractedLicensingInfosCrossRefs)
                   v );
             ]);
         [
           ( "extractedText",
             Atdml_runtime.Yojson.yojson_of_string x.extractedText );
         ];
         [ ("licenseId", Atdml_runtime.Yojson.yojson_of_string x.licenseId) ];
         (match x.name with
         | None -> []
         | Some v -> [ ("name", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.seeAlsos with
         | None -> []
         | Some v ->
             [
               ( "seeAlsos",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
       ])

let sPDX231devHasExtractedLicensingInfos_of_json s =
  sPDX231devHasExtractedLicensingInfos_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devHasExtractedLicensingInfos x =
  Yojson.Safe.to_string (yojson_of_sPDX231devHasExtractedLicensingInfos x)

module SPDX231devHasExtractedLicensingInfos = struct
  type nonrec t = sPDX231devHasExtractedLicensingInfos

  let create = create_sPDX231devHasExtractedLicensingInfos
  let of_yojson = sPDX231devHasExtractedLicensingInfos_of_yojson
  let to_yojson = yojson_of_sPDX231devHasExtractedLicensingInfos
  let of_json = sPDX231devHasExtractedLicensingInfos_of_json
  let to_json = json_of_sPDX231devHasExtractedLicensingInfos
end

(** The type of the file. *)
type sPDX231devFilesFileTypes =
  | OTHER
  | DOCUMENTATION
  | IMAGE
  | VIDEO
  | ARCHIVE
  | SPDX
  | APPLICATION
  | SOURCE
  | BINARY
  | TEXT
  | AUDIO

let sPDX231devFilesFileTypes_of_yojson (x : Yojson.Safe.t) :
    sPDX231devFilesFileTypes =
  match x with
  | `String "OTHER" -> OTHER
  | `String "DOCUMENTATION" -> DOCUMENTATION
  | `String "IMAGE" -> IMAGE
  | `String "VIDEO" -> VIDEO
  | `String "ARCHIVE" -> ARCHIVE
  | `String "SPDX" -> SPDX
  | `String "APPLICATION" -> APPLICATION
  | `String "SOURCE" -> SOURCE
  | `String "BINARY" -> BINARY
  | `String "TEXT" -> TEXT
  | `String "AUDIO" -> AUDIO
  | _ -> Atdml_runtime.Yojson.bad_sum "sPDX231devFilesFileTypes" x

let yojson_of_sPDX231devFilesFileTypes (x : sPDX231devFilesFileTypes) :
    Yojson.Safe.t =
  match x with
  | OTHER -> `String "OTHER"
  | DOCUMENTATION -> `String "DOCUMENTATION"
  | IMAGE -> `String "IMAGE"
  | VIDEO -> `String "VIDEO"
  | ARCHIVE -> `String "ARCHIVE"
  | SPDX -> `String "SPDX"
  | APPLICATION -> `String "APPLICATION"
  | SOURCE -> `String "SOURCE"
  | BINARY -> `String "BINARY"
  | TEXT -> `String "TEXT"
  | AUDIO -> `String "AUDIO"

let sPDX231devFilesFileTypes_of_json s =
  sPDX231devFilesFileTypes_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devFilesFileTypes x =
  Yojson.Safe.to_string (yojson_of_sPDX231devFilesFileTypes x)

module SPDX231devFilesFileTypes = struct
  type nonrec t = sPDX231devFilesFileTypes

  let of_yojson = sPDX231devFilesFileTypes_of_yojson
  let to_yojson = yojson_of_sPDX231devFilesFileTypes
  let of_json = sPDX231devFilesFileTypes_of_json
  let to_json = json_of_sPDX231devFilesFileTypes
end

(** Identifies the algorithm used to produce the subject Checksum. Currently,
    SHA-1 is the only supported algorithm. It is anticipated that other
    algorithms will be supported at a later time. *)
type sPDX231devFilesChecksumsAlgorithm =
  | SHA1
  | BLAKE3
  | SHA3384
  | SHA256
  | SHA384
  | BLAKE2b512
  | BLAKE2b256
  | SHA3512
  | MD2
  | ADLER32
  | MD4
  | SHA3256
  | BLAKE2b384
  | SHA512
  | MD6
  | MD5
  | SHA224

let sPDX231devFilesChecksumsAlgorithm_of_yojson (x : Yojson.Safe.t) :
    sPDX231devFilesChecksumsAlgorithm =
  match x with
  | `String "SHA1" -> SHA1
  | `String "BLAKE3" -> BLAKE3
  | `String "SHA3-384" -> SHA3384
  | `String "SHA256" -> SHA256
  | `String "SHA384" -> SHA384
  | `String "BLAKE2b-512" -> BLAKE2b512
  | `String "BLAKE2b-256" -> BLAKE2b256
  | `String "SHA3-512" -> SHA3512
  | `String "MD2" -> MD2
  | `String "ADLER32" -> ADLER32
  | `String "MD4" -> MD4
  | `String "SHA3-256" -> SHA3256
  | `String "BLAKE2b-384" -> BLAKE2b384
  | `String "SHA512" -> SHA512
  | `String "MD6" -> MD6
  | `String "MD5" -> MD5
  | `String "SHA224" -> SHA224
  | _ -> Atdml_runtime.Yojson.bad_sum "sPDX231devFilesChecksumsAlgorithm" x

let yojson_of_sPDX231devFilesChecksumsAlgorithm
    (x : sPDX231devFilesChecksumsAlgorithm) : Yojson.Safe.t =
  match x with
  | SHA1 -> `String "SHA1"
  | BLAKE3 -> `String "BLAKE3"
  | SHA3384 -> `String "SHA3-384"
  | SHA256 -> `String "SHA256"
  | SHA384 -> `String "SHA384"
  | BLAKE2b512 -> `String "BLAKE2b-512"
  | BLAKE2b256 -> `String "BLAKE2b-256"
  | SHA3512 -> `String "SHA3-512"
  | MD2 -> `String "MD2"
  | ADLER32 -> `String "ADLER32"
  | MD4 -> `String "MD4"
  | SHA3256 -> `String "SHA3-256"
  | BLAKE2b384 -> `String "BLAKE2b-384"
  | SHA512 -> `String "SHA512"
  | MD6 -> `String "MD6"
  | MD5 -> `String "MD5"
  | SHA224 -> `String "SHA224"

let sPDX231devFilesChecksumsAlgorithm_of_json s =
  sPDX231devFilesChecksumsAlgorithm_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devFilesChecksumsAlgorithm x =
  Yojson.Safe.to_string (yojson_of_sPDX231devFilesChecksumsAlgorithm x)

module SPDX231devFilesChecksumsAlgorithm = struct
  type nonrec t = sPDX231devFilesChecksumsAlgorithm

  let of_yojson = sPDX231devFilesChecksumsAlgorithm_of_yojson
  let to_yojson = yojson_of_sPDX231devFilesChecksumsAlgorithm
  let of_json = sPDX231devFilesChecksumsAlgorithm_of_json
  let to_json = json_of_sPDX231devFilesChecksumsAlgorithm
end

type sPDX231devFilesChecksums = {
  algorithm : sPDX231devFilesChecksumsAlgorithm;
      (** Identifies the algorithm used to produce the subject Checksum.
          Currently, SHA-1 is the only supported algorithm. It is anticipated
          that other algorithms will be supported at a later time. *)
  checksumValue : string;
      (** The checksumValue property provides a lower case hexadecimal encoded
          digest value produced using a specific algorithm. *)
}
(** A Checksum is value that allows the contents of a file to be authenticated.
    Even small changes to the content of the file will change its checksum. This
    class allows the results of a variety of checksum and cryptographic message
    digest algorithms to be represented. *)

let create_sPDX231devFilesChecksums ~algorithm ~checksumValue () :
    sPDX231devFilesChecksums =
  { algorithm; checksumValue }

let sPDX231devFilesChecksums_of_yojson (x : Yojson.Safe.t) :
    sPDX231devFilesChecksums =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let algorithm =
        match assoc_ "algorithm" with
        | Some v -> sPDX231devFilesChecksumsAlgorithm_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFilesChecksums"
              "algorithm"
      in
      let checksumValue =
        match assoc_ "checksumValue" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFilesChecksums"
              "checksumValue"
      in
      { algorithm; checksumValue }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devFilesChecksums" x

let yojson_of_sPDX231devFilesChecksums (x : sPDX231devFilesChecksums) :
    Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ("algorithm", yojson_of_sPDX231devFilesChecksumsAlgorithm x.algorithm);
         ];
         [
           ( "checksumValue",
             Atdml_runtime.Yojson.yojson_of_string x.checksumValue );
         ];
       ])

let sPDX231devFilesChecksums_of_json s =
  sPDX231devFilesChecksums_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devFilesChecksums x =
  Yojson.Safe.to_string (yojson_of_sPDX231devFilesChecksums x)

module SPDX231devFilesChecksums = struct
  type nonrec t = sPDX231devFilesChecksums

  let create = create_sPDX231devFilesChecksums
  let of_yojson = sPDX231devFilesChecksums_of_yojson
  let to_yojson = yojson_of_sPDX231devFilesChecksums
  let of_json = sPDX231devFilesChecksums_of_json
  let to_json = json_of_sPDX231devFilesChecksums
end

(** Type of the annotation. *)
type sPDX231devFilesAnnotationsAnnotationType = OTHER | REVIEW

let sPDX231devFilesAnnotationsAnnotationType_of_yojson (x : Yojson.Safe.t) :
    sPDX231devFilesAnnotationsAnnotationType =
  match x with
  | `String "OTHER" -> OTHER
  | `String "REVIEW" -> REVIEW
  | _ ->
      Atdml_runtime.Yojson.bad_sum "sPDX231devFilesAnnotationsAnnotationType" x

let yojson_of_sPDX231devFilesAnnotationsAnnotationType
    (x : sPDX231devFilesAnnotationsAnnotationType) : Yojson.Safe.t =
  match x with
  | OTHER -> `String "OTHER"
  | REVIEW -> `String "REVIEW"

let sPDX231devFilesAnnotationsAnnotationType_of_json s =
  sPDX231devFilesAnnotationsAnnotationType_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devFilesAnnotationsAnnotationType x =
  Yojson.Safe.to_string (yojson_of_sPDX231devFilesAnnotationsAnnotationType x)

module SPDX231devFilesAnnotationsAnnotationType = struct
  type nonrec t = sPDX231devFilesAnnotationsAnnotationType

  let of_yojson = sPDX231devFilesAnnotationsAnnotationType_of_yojson
  let to_yojson = yojson_of_sPDX231devFilesAnnotationsAnnotationType
  let of_json = sPDX231devFilesAnnotationsAnnotationType_of_json
  let to_json = json_of_sPDX231devFilesAnnotationsAnnotationType
end

type sPDX231devFilesAnnotations = {
  annotationDate : string;
      (** Identify when the comment was made. This is to be specified according
          to the combined date and time in the UTC format, as specified in the
          ISO 8601 standard. *)
  annotationType : sPDX231devFilesAnnotationsAnnotationType;
      (** Type of the annotation. *)
  annotator : string;
      (** This field identifies the person, organization, or tool that has
          commented on a file, package, snippet, or the entire document. *)
  comment : string;
}
(** An Annotation is a comment on an SpdxItem by an agent. *)

let create_sPDX231devFilesAnnotations ~annotationDate ~annotationType ~annotator
    ~comment () : sPDX231devFilesAnnotations =
  { annotationDate; annotationType; annotator; comment }

let sPDX231devFilesAnnotations_of_yojson (x : Yojson.Safe.t) :
    sPDX231devFilesAnnotations =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let annotationDate =
        match assoc_ "annotationDate" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFilesAnnotations"
              "annotationDate"
      in
      let annotationType =
        match assoc_ "annotationType" with
        | Some v -> sPDX231devFilesAnnotationsAnnotationType_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFilesAnnotations"
              "annotationType"
      in
      let annotator =
        match assoc_ "annotator" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFilesAnnotations"
              "annotator"
      in
      let comment =
        match assoc_ "comment" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFilesAnnotations"
              "comment"
      in
      { annotationDate; annotationType; annotator; comment }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devFilesAnnotations" x

let yojson_of_sPDX231devFilesAnnotations (x : sPDX231devFilesAnnotations) :
    Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "annotationDate",
             Atdml_runtime.Yojson.yojson_of_string x.annotationDate );
         ];
         [
           ( "annotationType",
             yojson_of_sPDX231devFilesAnnotationsAnnotationType x.annotationType
           );
         ];
         [ ("annotator", Atdml_runtime.Yojson.yojson_of_string x.annotator) ];
         [ ("comment", Atdml_runtime.Yojson.yojson_of_string x.comment) ];
       ])

let sPDX231devFilesAnnotations_of_json s =
  sPDX231devFilesAnnotations_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devFilesAnnotations x =
  Yojson.Safe.to_string (yojson_of_sPDX231devFilesAnnotations x)

module SPDX231devFilesAnnotations = struct
  type nonrec t = sPDX231devFilesAnnotations

  let create = create_sPDX231devFilesAnnotations
  let of_yojson = sPDX231devFilesAnnotations_of_yojson
  let to_yojson = yojson_of_sPDX231devFilesAnnotations
  let of_json = sPDX231devFilesAnnotations_of_json
  let to_json = json_of_sPDX231devFilesAnnotations
end

type json_ = Yojson.Safe.t

let json__of_yojson (x : Yojson.Safe.t) : json_ = (fun x -> x) x
let yojson_of_json_ (x : json_) : Yojson.Safe.t = (fun x -> x) x
let json__of_json s = json__of_yojson (Yojson.Safe.from_string s)
let json_of_json_ x = Yojson.Safe.to_string (yojson_of_json_ x)

module Json_ = struct
  type nonrec t = json_

  let of_yojson = json__of_yojson
  let to_yojson = yojson_of_json_
  let of_json = json__of_json
  let to_json = json_of_json_
end

type sPDX231devFiles = {
  sPDXID : string;
      (** Uniquely identify any element in an SPDX document which may be
          referenced by other elements. *)
  annotations : sPDX231devFilesAnnotations list option;
      (** Provide additional information about an SpdxElement. *)
  artifactOfs : json_ list option;
      (** Indicates the project in which the SpdxElement originated. Tools must
          preserve doap:homepage and doap:name properties and the URI (if one is
          known) of doap:Project resources that are values of this property. All
          other properties of doap:Projects are not directly supported by SPDX
          and may be dropped when translating to or from some SPDX formats. *)
  attributionTexts : string list option;
      (** This field provides a place for the SPDX data creator to record
          acknowledgements that may be required to be communicated in some
          contexts. This is not meant to include the actual complete license
          text (see licenseConcluded and licenseDeclared), and may or may not
          include copyright notices (see also copyrightText). The SPDX data
          creator may use this field to record other acknowledgements, such as
          particular clauses from license texts, which may be necessary or
          desirable to reproduce. *)
  checksums : sPDX231devFilesChecksums list;
      (** The checksum property provides a mechanism that can be used to verify
          that the contents of a File or Package have not changed. *)
  comment : string option;
  copyrightText : string option;
      (** The text of copyright declarations recited in the package, file or
          snippet.

          If the copyrightText field is not present, it implies an equivalent
          meaning to NOASSERTION. *)
  fileContributors : string list option;
      (** This field provides a place for the SPDX file creator to record file
          contributors. Contributors could include names of copyright holders
          and/or authors who may not be copyright holders yet contributed to the
          file content. *)
  fileDependencies : string list option;
      (** This field is deprecated since SPDX 2.0 in favor of using Section 7
          which provides more granularity about relationships. *)
  fileName : string;
      (** The name of the file relative to the root of the package. *)
  fileTypes : sPDX231devFilesFileTypes list option;
      (** The type of the file. *)
  licenseComments : string option;
      (** The licenseComments property allows the preparer of the SPDX document
          to describe why the licensing in spdx:licenseConcluded was chosen. *)
  licenseConcluded : string option;
      (** License expression for licenseConcluded. See SPDX Annex D for the
          license expression syntax. The licensing that the preparer of this
          SPDX document has concluded, based on the evidence, actually applies
          to the SPDX Item.

          If the licenseConcluded field is not present for an SPDX Item, it
          implies an equivalent meaning to NOASSERTION. *)
  licenseInfoInFiles : string list option;
      (** Licensing information that was discovered directly in the subject
          file. This is also considered a declared license for the file.

          If the licenseInfoInFile field is not present for a file, it implies
          an equivalent meaning to NOASSERTION. *)
  noticeText : string option;
      (** This field provides a place for the SPDX file creator to record
          potential legal notices found in the file. This may or may not include
          copyright statements. *)
}

let create_sPDX231devFiles ~sPDXID ?annotations ?artifactOfs ?attributionTexts
    ~checksums ?comment ?copyrightText ?fileContributors ?fileDependencies
    ~fileName ?fileTypes ?licenseComments ?licenseConcluded ?licenseInfoInFiles
    ?noticeText () : sPDX231devFiles =
  {
    sPDXID;
    annotations;
    artifactOfs;
    attributionTexts;
    checksums;
    comment;
    copyrightText;
    fileContributors;
    fileDependencies;
    fileName;
    fileTypes;
    licenseComments;
    licenseConcluded;
    licenseInfoInFiles;
    noticeText;
  }

let sPDX231devFiles_of_yojson (x : Yojson.Safe.t) : sPDX231devFiles =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let sPDXID =
        match assoc_ "SPDXID" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "sPDX231devFiles" "SPDXID"
      in
      let annotations =
        match assoc_ "annotations" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devFilesAnnotations_of_yojson)
                 v)
      in
      let artifactOfs =
        match assoc_ "artifactOfs" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some ((Atdml_runtime.Yojson.list_of_yojson json__of_yojson) v)
      in
      let attributionTexts =
        match assoc_ "attributionTexts" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let checksums =
        match assoc_ "checksums" with
        | Some v ->
            (Atdml_runtime.Yojson.list_of_yojson
               sPDX231devFilesChecksums_of_yojson)
              v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFiles" "checksums"
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let copyrightText =
        match assoc_ "copyrightText" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let fileContributors =
        match assoc_ "fileContributors" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let fileDependencies =
        match assoc_ "fileDependencies" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let fileName =
        match assoc_ "fileName" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devFiles" "fileName"
      in
      let fileTypes =
        match assoc_ "fileTypes" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devFilesFileTypes_of_yojson)
                 v)
      in
      let licenseComments =
        match assoc_ "licenseComments" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseConcluded =
        match assoc_ "licenseConcluded" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let licenseInfoInFiles =
        match assoc_ "licenseInfoInFiles" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let noticeText =
        match assoc_ "noticeText" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      {
        sPDXID;
        annotations;
        artifactOfs;
        attributionTexts;
        checksums;
        comment;
        copyrightText;
        fileContributors;
        fileDependencies;
        fileName;
        fileTypes;
        licenseComments;
        licenseConcluded;
        licenseInfoInFiles;
        noticeText;
      }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devFiles" x

let yojson_of_sPDX231devFiles (x : sPDX231devFiles) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("SPDXID", Atdml_runtime.Yojson.yojson_of_string x.sPDXID) ];
         (match x.annotations with
         | None -> []
         | Some v ->
             [
               ( "annotations",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devFilesAnnotations)
                   v );
             ]);
         (match x.artifactOfs with
         | None -> []
         | Some v ->
             [
               ( "artifactOfs",
                 (Atdml_runtime.Yojson.yojson_of_list yojson_of_json_) v );
             ]);
         (match x.attributionTexts with
         | None -> []
         | Some v ->
             [
               ( "attributionTexts",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         [
           ( "checksums",
             (Atdml_runtime.Yojson.yojson_of_list
                yojson_of_sPDX231devFilesChecksums)
               x.checksums );
         ];
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.copyrightText with
         | None -> []
         | Some v ->
             [ ("copyrightText", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.fileContributors with
         | None -> []
         | Some v ->
             [
               ( "fileContributors",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         (match x.fileDependencies with
         | None -> []
         | Some v ->
             [
               ( "fileDependencies",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         [ ("fileName", Atdml_runtime.Yojson.yojson_of_string x.fileName) ];
         (match x.fileTypes with
         | None -> []
         | Some v ->
             [
               ( "fileTypes",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devFilesFileTypes)
                   v );
             ]);
         (match x.licenseComments with
         | None -> []
         | Some v ->
             [ ("licenseComments", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseConcluded with
         | None -> []
         | Some v ->
             [ ("licenseConcluded", Atdml_runtime.Yojson.yojson_of_string v) ]);
         (match x.licenseInfoInFiles with
         | None -> []
         | Some v ->
             [
               ( "licenseInfoInFiles",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         (match x.noticeText with
         | None -> []
         | Some v -> [ ("noticeText", Atdml_runtime.Yojson.yojson_of_string v) ]);
       ])

let sPDX231devFiles_of_json s =
  sPDX231devFiles_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devFiles x =
  Yojson.Safe.to_string (yojson_of_sPDX231devFiles x)

module SPDX231devFiles = struct
  type nonrec t = sPDX231devFiles

  let create = create_sPDX231devFiles
  let of_yojson = sPDX231devFiles_of_yojson
  let to_yojson = yojson_of_sPDX231devFiles
  let of_json = sPDX231devFiles_of_json
  let to_json = json_of_sPDX231devFiles
end

(** Identifies the algorithm used to produce the subject Checksum. Currently,
    SHA-1 is the only supported algorithm. It is anticipated that other
    algorithms will be supported at a later time. *)
type sPDX231devExternalDocumentRefsChecksumAlgorithm =
  | SHA1
  | BLAKE3
  | SHA3384
  | SHA256
  | SHA384
  | BLAKE2b512
  | BLAKE2b256
  | SHA3512
  | MD2
  | ADLER32
  | MD4
  | SHA3256
  | BLAKE2b384
  | SHA512
  | MD6
  | MD5
  | SHA224

let sPDX231devExternalDocumentRefsChecksumAlgorithm_of_yojson
    (x : Yojson.Safe.t) : sPDX231devExternalDocumentRefsChecksumAlgorithm =
  match x with
  | `String "SHA1" -> SHA1
  | `String "BLAKE3" -> BLAKE3
  | `String "SHA3-384" -> SHA3384
  | `String "SHA256" -> SHA256
  | `String "SHA384" -> SHA384
  | `String "BLAKE2b-512" -> BLAKE2b512
  | `String "BLAKE2b-256" -> BLAKE2b256
  | `String "SHA3-512" -> SHA3512
  | `String "MD2" -> MD2
  | `String "ADLER32" -> ADLER32
  | `String "MD4" -> MD4
  | `String "SHA3-256" -> SHA3256
  | `String "BLAKE2b-384" -> BLAKE2b384
  | `String "SHA512" -> SHA512
  | `String "MD6" -> MD6
  | `String "MD5" -> MD5
  | `String "SHA224" -> SHA224
  | _ ->
      Atdml_runtime.Yojson.bad_sum
        "sPDX231devExternalDocumentRefsChecksumAlgorithm" x

let yojson_of_sPDX231devExternalDocumentRefsChecksumAlgorithm
    (x : sPDX231devExternalDocumentRefsChecksumAlgorithm) : Yojson.Safe.t =
  match x with
  | SHA1 -> `String "SHA1"
  | BLAKE3 -> `String "BLAKE3"
  | SHA3384 -> `String "SHA3-384"
  | SHA256 -> `String "SHA256"
  | SHA384 -> `String "SHA384"
  | BLAKE2b512 -> `String "BLAKE2b-512"
  | BLAKE2b256 -> `String "BLAKE2b-256"
  | SHA3512 -> `String "SHA3-512"
  | MD2 -> `String "MD2"
  | ADLER32 -> `String "ADLER32"
  | MD4 -> `String "MD4"
  | SHA3256 -> `String "SHA3-256"
  | BLAKE2b384 -> `String "BLAKE2b-384"
  | SHA512 -> `String "SHA512"
  | MD6 -> `String "MD6"
  | MD5 -> `String "MD5"
  | SHA224 -> `String "SHA224"

let sPDX231devExternalDocumentRefsChecksumAlgorithm_of_json s =
  sPDX231devExternalDocumentRefsChecksumAlgorithm_of_yojson
    (Yojson.Safe.from_string s)

let json_of_sPDX231devExternalDocumentRefsChecksumAlgorithm x =
  Yojson.Safe.to_string
    (yojson_of_sPDX231devExternalDocumentRefsChecksumAlgorithm x)

module SPDX231devExternalDocumentRefsChecksumAlgorithm = struct
  type nonrec t = sPDX231devExternalDocumentRefsChecksumAlgorithm

  let of_yojson = sPDX231devExternalDocumentRefsChecksumAlgorithm_of_yojson
  let to_yojson = yojson_of_sPDX231devExternalDocumentRefsChecksumAlgorithm
  let of_json = sPDX231devExternalDocumentRefsChecksumAlgorithm_of_json
  let to_json = json_of_sPDX231devExternalDocumentRefsChecksumAlgorithm
end

type sPDX231devExternalDocumentRefsChecksum = {
  algorithm : sPDX231devExternalDocumentRefsChecksumAlgorithm;
      (** Identifies the algorithm used to produce the subject Checksum.
          Currently, SHA-1 is the only supported algorithm. It is anticipated
          that other algorithms will be supported at a later time. *)
  checksumValue : string;
      (** The checksumValue property provides a lower case hexadecimal encoded
          digest value produced using a specific algorithm. *)
}
(** A Checksum is value that allows the contents of a file to be authenticated.
    Even small changes to the content of the file will change its checksum. This
    class allows the results of a variety of checksum and cryptographic message
    digest algorithms to be represented. *)

let create_sPDX231devExternalDocumentRefsChecksum ~algorithm ~checksumValue () :
    sPDX231devExternalDocumentRefsChecksum =
  { algorithm; checksumValue }

let sPDX231devExternalDocumentRefsChecksum_of_yojson (x : Yojson.Safe.t) :
    sPDX231devExternalDocumentRefsChecksum =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let algorithm =
        match assoc_ "algorithm" with
        | Some v -> sPDX231devExternalDocumentRefsChecksumAlgorithm_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devExternalDocumentRefsChecksum" "algorithm"
      in
      let checksumValue =
        match assoc_ "checksumValue" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "sPDX231devExternalDocumentRefsChecksum" "checksumValue"
      in
      { algorithm; checksumValue }
  | _ ->
      Atdml_runtime.Yojson.bad_type "sPDX231devExternalDocumentRefsChecksum" x

let yojson_of_sPDX231devExternalDocumentRefsChecksum
    (x : sPDX231devExternalDocumentRefsChecksum) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "algorithm",
             yojson_of_sPDX231devExternalDocumentRefsChecksumAlgorithm
               x.algorithm );
         ];
         [
           ( "checksumValue",
             Atdml_runtime.Yojson.yojson_of_string x.checksumValue );
         ];
       ])

let sPDX231devExternalDocumentRefsChecksum_of_json s =
  sPDX231devExternalDocumentRefsChecksum_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devExternalDocumentRefsChecksum x =
  Yojson.Safe.to_string (yojson_of_sPDX231devExternalDocumentRefsChecksum x)

module SPDX231devExternalDocumentRefsChecksum = struct
  type nonrec t = sPDX231devExternalDocumentRefsChecksum

  let create = create_sPDX231devExternalDocumentRefsChecksum
  let of_yojson = sPDX231devExternalDocumentRefsChecksum_of_yojson
  let to_yojson = yojson_of_sPDX231devExternalDocumentRefsChecksum
  let of_json = sPDX231devExternalDocumentRefsChecksum_of_json
  let to_json = json_of_sPDX231devExternalDocumentRefsChecksum
end

type sPDX231devExternalDocumentRefs = {
  checksum : sPDX231devExternalDocumentRefsChecksum;
      (** A Checksum is value that allows the contents of a file to be
          authenticated. Even small changes to the content of the file will
          change its checksum. This class allows the results of a variety of
          checksum and cryptographic message digest algorithms to be
          represented. *)
  externalDocumentId : string;
      (** externalDocumentId is a string containing letters, numbers, ., -
          and/or + which uniquely identifies an external document within this
          document. *)
  spdxDocument : string;
      (** SPDX ID for SpdxDocument. A property containing an SPDX document. *)
}
(** Information about an external SPDX document reference including the
    checksum. This allows for verification of the external references. *)

let create_sPDX231devExternalDocumentRefs ~checksum ~externalDocumentId
    ~spdxDocument () : sPDX231devExternalDocumentRefs =
  { checksum; externalDocumentId; spdxDocument }

let sPDX231devExternalDocumentRefs_of_yojson (x : Yojson.Safe.t) :
    sPDX231devExternalDocumentRefs =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let checksum =
        match assoc_ "checksum" with
        | Some v -> sPDX231devExternalDocumentRefsChecksum_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devExternalDocumentRefs"
              "checksum"
      in
      let externalDocumentId =
        match assoc_ "externalDocumentId" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devExternalDocumentRefs"
              "externalDocumentId"
      in
      let spdxDocument =
        match assoc_ "spdxDocument" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devExternalDocumentRefs"
              "spdxDocument"
      in
      { checksum; externalDocumentId; spdxDocument }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devExternalDocumentRefs" x

let yojson_of_sPDX231devExternalDocumentRefs
    (x : sPDX231devExternalDocumentRefs) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [
           ( "checksum",
             yojson_of_sPDX231devExternalDocumentRefsChecksum x.checksum );
         ];
         [
           ( "externalDocumentId",
             Atdml_runtime.Yojson.yojson_of_string x.externalDocumentId );
         ];
         [
           ("spdxDocument", Atdml_runtime.Yojson.yojson_of_string x.spdxDocument);
         ];
       ])

let sPDX231devExternalDocumentRefs_of_json s =
  sPDX231devExternalDocumentRefs_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devExternalDocumentRefs x =
  Yojson.Safe.to_string (yojson_of_sPDX231devExternalDocumentRefs x)

module SPDX231devExternalDocumentRefs = struct
  type nonrec t = sPDX231devExternalDocumentRefs

  let create = create_sPDX231devExternalDocumentRefs
  let of_yojson = sPDX231devExternalDocumentRefs_of_yojson
  let to_yojson = yojson_of_sPDX231devExternalDocumentRefs
  let of_json = sPDX231devExternalDocumentRefs_of_json
  let to_json = json_of_sPDX231devExternalDocumentRefs
end

type sPDX231devCreationInfo = {
  comment : string option;
  created : string;
      (** Identify when the SPDX document was originally created. The date is to
          be specified according to combined date and time in UTC format as
          specified in ISO 8601 standard. *)
  creators : string list;
      (** Identify who (or what, in the case of a tool) created the SPDX
          document. If the SPDX document was created by an individual, indicate
          the person's name. If the SPDX document was created on behalf of a
          company or organization, indicate the entity name. If the SPDX
          document was created using a software tool, indicate the name and
          version for that tool. If multiple participants or tools were
          involved, use multiple instances of this field. Person name or
          organization name may be designated as “anonymous” if appropriate. *)
  licenseListVersion : string option;
      (** An optional field for creators of the SPDX file to provide the version
          of the SPDX License List used when the SPDX file was created. *)
}
(** One instance is required for each SPDX file produced. It provides the
    necessary information for forward and backward compatibility for processing
    tools. *)

let create_sPDX231devCreationInfo ?comment ~created ~creators
    ?licenseListVersion () : sPDX231devCreationInfo =
  { comment; created; creators; licenseListVersion }

let sPDX231devCreationInfo_of_yojson (x : Yojson.Safe.t) :
    sPDX231devCreationInfo =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let created =
        match assoc_ "created" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devCreationInfo"
              "created"
      in
      let creators =
        match assoc_ "creators" with
        | Some v ->
            (Atdml_runtime.Yojson.list_of_yojson
               Atdml_runtime.Yojson.string_of_yojson)
              v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devCreationInfo"
              "creators"
      in
      let licenseListVersion =
        match assoc_ "licenseListVersion" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      { comment; created; creators; licenseListVersion }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devCreationInfo" x

let yojson_of_sPDX231devCreationInfo (x : sPDX231devCreationInfo) :
    Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [ ("created", Atdml_runtime.Yojson.yojson_of_string x.created) ];
         [
           ( "creators",
             (Atdml_runtime.Yojson.yojson_of_list
                Atdml_runtime.Yojson.yojson_of_string)
               x.creators );
         ];
         (match x.licenseListVersion with
         | None -> []
         | Some v ->
             [ ("licenseListVersion", Atdml_runtime.Yojson.yojson_of_string v) ]);
       ])

let sPDX231devCreationInfo_of_json s =
  sPDX231devCreationInfo_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devCreationInfo x =
  Yojson.Safe.to_string (yojson_of_sPDX231devCreationInfo x)

module SPDX231devCreationInfo = struct
  type nonrec t = sPDX231devCreationInfo

  let create = create_sPDX231devCreationInfo
  let of_yojson = sPDX231devCreationInfo_of_yojson
  let to_yojson = yojson_of_sPDX231devCreationInfo
  let of_json = sPDX231devCreationInfo_of_json
  let to_json = json_of_sPDX231devCreationInfo
end

(** Type of the annotation. *)
type sPDX231devAnnotationsAnnotationType = OTHER | REVIEW

let sPDX231devAnnotationsAnnotationType_of_yojson (x : Yojson.Safe.t) :
    sPDX231devAnnotationsAnnotationType =
  match x with
  | `String "OTHER" -> OTHER
  | `String "REVIEW" -> REVIEW
  | _ -> Atdml_runtime.Yojson.bad_sum "sPDX231devAnnotationsAnnotationType" x

let yojson_of_sPDX231devAnnotationsAnnotationType
    (x : sPDX231devAnnotationsAnnotationType) : Yojson.Safe.t =
  match x with
  | OTHER -> `String "OTHER"
  | REVIEW -> `String "REVIEW"

let sPDX231devAnnotationsAnnotationType_of_json s =
  sPDX231devAnnotationsAnnotationType_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devAnnotationsAnnotationType x =
  Yojson.Safe.to_string (yojson_of_sPDX231devAnnotationsAnnotationType x)

module SPDX231devAnnotationsAnnotationType = struct
  type nonrec t = sPDX231devAnnotationsAnnotationType

  let of_yojson = sPDX231devAnnotationsAnnotationType_of_yojson
  let to_yojson = yojson_of_sPDX231devAnnotationsAnnotationType
  let of_json = sPDX231devAnnotationsAnnotationType_of_json
  let to_json = json_of_sPDX231devAnnotationsAnnotationType
end

type sPDX231devAnnotations = {
  annotationDate : string;
      (** Identify when the comment was made. This is to be specified according
          to the combined date and time in the UTC format, as specified in the
          ISO 8601 standard. *)
  annotationType : sPDX231devAnnotationsAnnotationType;
      (** Type of the annotation. *)
  annotator : string;
      (** This field identifies the person, organization, or tool that has
          commented on a file, package, snippet, or the entire document. *)
  comment : string;
}
(** An Annotation is a comment on an SpdxItem by an agent. *)

let create_sPDX231devAnnotations ~annotationDate ~annotationType ~annotator
    ~comment () : sPDX231devAnnotations =
  { annotationDate; annotationType; annotator; comment }

let sPDX231devAnnotations_of_yojson (x : Yojson.Safe.t) : sPDX231devAnnotations
    =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let annotationDate =
        match assoc_ "annotationDate" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devAnnotations"
              "annotationDate"
      in
      let annotationType =
        match assoc_ "annotationType" with
        | Some v -> sPDX231devAnnotationsAnnotationType_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devAnnotations"
              "annotationType"
      in
      let annotator =
        match assoc_ "annotator" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devAnnotations"
              "annotator"
      in
      let comment =
        match assoc_ "comment" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231devAnnotations" "comment"
      in
      { annotationDate; annotationType; annotator; comment }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231devAnnotations" x

let yojson_of_sPDX231devAnnotations (x : sPDX231devAnnotations) : Yojson.Safe.t
    =
  `Assoc
    (List.concat
       [
         [
           ( "annotationDate",
             Atdml_runtime.Yojson.yojson_of_string x.annotationDate );
         ];
         [
           ( "annotationType",
             yojson_of_sPDX231devAnnotationsAnnotationType x.annotationType );
         ];
         [ ("annotator", Atdml_runtime.Yojson.yojson_of_string x.annotator) ];
         [ ("comment", Atdml_runtime.Yojson.yojson_of_string x.comment) ];
       ])

let sPDX231devAnnotations_of_json s =
  sPDX231devAnnotations_of_yojson (Yojson.Safe.from_string s)

let json_of_sPDX231devAnnotations x =
  Yojson.Safe.to_string (yojson_of_sPDX231devAnnotations x)

module SPDX231devAnnotations = struct
  type nonrec t = sPDX231devAnnotations

  let create = create_sPDX231devAnnotations
  let of_yojson = sPDX231devAnnotations_of_yojson
  let to_yojson = yojson_of_sPDX231devAnnotations
  let of_json = sPDX231devAnnotations_of_json
  let to_json = json_of_sPDX231devAnnotations
end

type sPDX231dev = {
  schema : string option;  (** Reference the SPDX 2.3.1 JSON schema. *)
  sPDXID : string;
      (** Uniquely identify any element in an SPDX document which may be
          referenced by other elements. *)
  annotations : sPDX231devAnnotations list option;
      (** Provide additional information about an SpdxElement. *)
  comment : string option;
  creationInfo : sPDX231devCreationInfo;
      (** One instance is required for each SPDX file produced. It provides the
          necessary information for forward and backward compatibility for
          processing tools. *)
  dataLicense : string;
      (** License expression for dataLicense. See SPDX Annex D for the license
          expression syntax. Compliance with the SPDX specification includes
          populating the SPDX fields therein with data related to such fields
          ("SPDX-Metadata"). The SPDX specification contains numerous fields
          where an SPDX document creator may provide relevant explanatory text
          in SPDX-Metadata. Without opining on the lawfulness of "database
          rights" (in jurisdictions where applicable), such explanatory text is
          copyrightable subject matter in most Berne Convention countries. By
          using the SPDX specification, or any portion hereof, you hereby agree
          that any copyright rights (as determined by your jurisdiction) in any
          SPDX-Metadata, including without limitation explanatory text, shall be
          subject to the terms of the Creative Commons CC0 1.0 Universal
          license. For SPDX-Metadata not containing any copyright rights, you
          hereby agree and acknowledge that the SPDX-Metadata is provided to you
          "as-is" and without any representations or warranties of any kind
          concerning the SPDX-Metadata, express, implied, statutory or
          otherwise, including without limitation warranties of title,
          merchantability, fitness for a particular purpose, non-infringement,
          or the absence of latent or other defects, accuracy, or the presence
          or absence of errors, whether or not discoverable, all to the greatest
          extent permissible under applicable law. *)
  externalDocumentRefs : sPDX231devExternalDocumentRefs list option;
      (** Identify any external SPDX documents referenced within this SPDX
          document. *)
  hasExtractedLicensingInfos : sPDX231devHasExtractedLicensingInfos list option;
      (** Indicates that a particular ExtractedLicensingInfo was defined in the
          subject SpdxDocument. *)
  name : string;  (** Identify name of this SpdxElement. *)
  revieweds : sPDX231devRevieweds list option;  (** Reviewed *)
  spdxVersion : string;
      (** Provide a reference number that can be used to understand how to parse
          and interpret the rest of the file. It will enable both future changes
          to the specification and to support backward compatibility. The
          version number consists of a major and minor version indicator. The
          major field will be incremented when incompatible changes between
          versions are made (one or more sections are created, modified or
          deleted). The minor field will be incremented when backwards
          compatible changes are made. *)
  documentNamespace : string;
      (** The URI provides an unambiguous mechanism for other SPDX documents to
          reference SPDX elements within this SPDX document. *)
  documentDescribes : string list option;
      (** DEPRECATED: use relationships instead of this field. Packages, files
          and/or Snippets described by this SPDX document *)
  packages : sPDX231devPackages list option;
      (** Packages referenced in the SPDX document *)
  files : sPDX231devFiles list option;
      (** Files referenced in the SPDX document *)
  snippets : sPDX231devSnippets list option;
      (** Snippets referenced in the SPDX document *)
  relationships : sPDX231devRelationships list option;
      (** Relationships referenced in the SPDX document *)
}

let create_sPDX231dev ?schema ~sPDXID ?annotations ?comment ~creationInfo
    ~dataLicense ?externalDocumentRefs ?hasExtractedLicensingInfos ~name
    ?revieweds ~spdxVersion ~documentNamespace ?documentDescribes ?packages
    ?files ?snippets ?relationships () : sPDX231dev =
  {
    schema;
    sPDXID;
    annotations;
    comment;
    creationInfo;
    dataLicense;
    externalDocumentRefs;
    hasExtractedLicensingInfos;
    name;
    revieweds;
    spdxVersion;
    documentNamespace;
    documentDescribes;
    packages;
    files;
    snippets;
    relationships;
  }

let sPDX231dev_of_yojson (x : Yojson.Safe.t) : sPDX231dev =
  match x with
  | `Assoc fields ->
      (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
      let assoc_ =
        if Atdml_runtime.list_length_gt 5 fields then (
          let tbl = Hashtbl.create 16 in
          List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
          fun key -> Hashtbl.find_opt tbl key)
        else fun key -> List.assoc_opt key fields
      in
      let schema =
        match assoc_ "$schema" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let sPDXID =
        match assoc_ "SPDXID" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "sPDX231dev" "SPDXID"
      in
      let annotations =
        match assoc_ "annotations" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devAnnotations_of_yojson)
                 v)
      in
      let comment =
        match assoc_ "comment" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (Atdml_runtime.Yojson.string_of_yojson v)
      in
      let creationInfo =
        match assoc_ "creationInfo" with
        | Some v -> sPDX231devCreationInfo_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "sPDX231dev" "creationInfo"
      in
      let dataLicense =
        match assoc_ "dataLicense" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "sPDX231dev" "dataLicense"
      in
      let externalDocumentRefs =
        match assoc_ "externalDocumentRefs" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devExternalDocumentRefs_of_yojson)
                 v)
      in
      let hasExtractedLicensingInfos =
        match assoc_ "hasExtractedLicensingInfos" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devHasExtractedLicensingInfos_of_yojson)
                 v)
      in
      let name =
        match assoc_ "name" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "sPDX231dev" "name"
      in
      let revieweds =
        match assoc_ "revieweds" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devRevieweds_of_yojson)
                 v)
      in
      let spdxVersion =
        match assoc_ "spdxVersion" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "sPDX231dev" "spdxVersion"
      in
      let documentNamespace =
        match assoc_ "documentNamespace" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "sPDX231dev" "documentNamespace"
      in
      let documentDescribes =
        match assoc_ "documentDescribes" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  Atdml_runtime.Yojson.string_of_yojson)
                 v)
      in
      let packages =
        match assoc_ "packages" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson sPDX231devPackages_of_yojson)
                 v)
      in
      let files =
        match assoc_ "files" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson sPDX231devFiles_of_yojson)
                 v)
      in
      let snippets =
        match assoc_ "snippets" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson sPDX231devSnippets_of_yojson)
                 v)
      in
      let relationships =
        match assoc_ "relationships" with
        | None
        | Some `Null ->
            None
        | Some v ->
            Some
              ((Atdml_runtime.Yojson.list_of_yojson
                  sPDX231devRelationships_of_yojson)
                 v)
      in
      {
        schema;
        sPDXID;
        annotations;
        comment;
        creationInfo;
        dataLicense;
        externalDocumentRefs;
        hasExtractedLicensingInfos;
        name;
        revieweds;
        spdxVersion;
        documentNamespace;
        documentDescribes;
        packages;
        files;
        snippets;
        relationships;
      }
  | _ -> Atdml_runtime.Yojson.bad_type "sPDX231dev" x

let yojson_of_sPDX231dev (x : sPDX231dev) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         (match x.schema with
         | None -> []
         | Some v -> [ ("$schema", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [ ("SPDXID", Atdml_runtime.Yojson.yojson_of_string x.sPDXID) ];
         (match x.annotations with
         | None -> []
         | Some v ->
             [
               ( "annotations",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devAnnotations)
                   v );
             ]);
         (match x.comment with
         | None -> []
         | Some v -> [ ("comment", Atdml_runtime.Yojson.yojson_of_string v) ]);
         [ ("creationInfo", yojson_of_sPDX231devCreationInfo x.creationInfo) ];
         [
           ("dataLicense", Atdml_runtime.Yojson.yojson_of_string x.dataLicense);
         ];
         (match x.externalDocumentRefs with
         | None -> []
         | Some v ->
             [
               ( "externalDocumentRefs",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devExternalDocumentRefs)
                   v );
             ]);
         (match x.hasExtractedLicensingInfos with
         | None -> []
         | Some v ->
             [
               ( "hasExtractedLicensingInfos",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devHasExtractedLicensingInfos)
                   v );
             ]);
         [ ("name", Atdml_runtime.Yojson.yojson_of_string x.name) ];
         (match x.revieweds with
         | None -> []
         | Some v ->
             [
               ( "revieweds",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devRevieweds)
                   v );
             ]);
         [
           ("spdxVersion", Atdml_runtime.Yojson.yojson_of_string x.spdxVersion);
         ];
         [
           ( "documentNamespace",
             Atdml_runtime.Yojson.yojson_of_string x.documentNamespace );
         ];
         (match x.documentDescribes with
         | None -> []
         | Some v ->
             [
               ( "documentDescribes",
                 (Atdml_runtime.Yojson.yojson_of_list
                    Atdml_runtime.Yojson.yojson_of_string)
                   v );
             ]);
         (match x.packages with
         | None -> []
         | Some v ->
             [
               ( "packages",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devPackages)
                   v );
             ]);
         (match x.files with
         | None -> []
         | Some v ->
             [
               ( "files",
                 (Atdml_runtime.Yojson.yojson_of_list yojson_of_sPDX231devFiles)
                   v );
             ]);
         (match x.snippets with
         | None -> []
         | Some v ->
             [
               ( "snippets",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devSnippets)
                   v );
             ]);
         (match x.relationships with
         | None -> []
         | Some v ->
             [
               ( "relationships",
                 (Atdml_runtime.Yojson.yojson_of_list
                    yojson_of_sPDX231devRelationships)
                   v );
             ]);
       ])

let sPDX231dev_of_json s = sPDX231dev_of_yojson (Yojson.Safe.from_string s)
let json_of_sPDX231dev x = Yojson.Safe.to_string (yojson_of_sPDX231dev x)

module SPDX231dev = struct
  type nonrec t = sPDX231dev

  let create = create_sPDX231dev
  let of_yojson = sPDX231dev_of_yojson
  let to_yojson = yojson_of_sPDX231dev
  let of_json = sPDX231dev_of_json
  let to_json = json_of_sPDX231dev
end

type int64 = int

let create_int64 (x : int) : int64 = x

let int64_of_yojson (x : Yojson.Safe.t) : int64 =
  Atdml_runtime.Yojson.int_of_yojson x

let yojson_of_int64 (x : int64) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_int x

let int64_of_json s = int64_of_yojson (Yojson.Safe.from_string s)
let json_of_int64 x = Yojson.Safe.to_string (yojson_of_int64 x)

module Int64 = struct
  type nonrec t = int64

  let create = create_int64
  let of_yojson = int64_of_yojson
  let to_yojson = yojson_of_int64
  let of_json = int64_of_json
  let to_json = json_of_int64
end
