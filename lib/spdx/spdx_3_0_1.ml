(* Auto-generated from "spdx_3_0_1.atd" by atdml. *)
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

type iri = string

let create_iri (x : string) : iri = x

let iri_of_yojson (x : Yojson.Safe.t) : iri =
  Atdml_runtime.Yojson.string_of_yojson x

let yojson_of_iri (x : iri) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_string x

let iri_of_json s = iri_of_yojson (Yojson.Safe.from_string s)
let json_of_iri x = Yojson.Safe.to_string (yojson_of_iri x)

module Iri = struct
  type nonrec t = iri

  let create = create_iri
  let of_yojson = iri_of_yojson
  let to_yojson = yojson_of_iri
  let of_json = iri_of_json
  let to_json = json_of_iri
end

type creation_info = {
  type_ : string;
  spec_version : string;
  created : string;
  created_by : iri list;
}

let create_creation_info ~type_ ~spec_version ~created ~created_by () :
    creation_info =
  { type_; spec_version; created; created_by }

let creation_info_of_yojson (x : Yojson.Safe.t) : creation_info =
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
      let type_ =
        match assoc_ "type" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "creation_info" "type"
      in
      let spec_version =
        match assoc_ "specVersion" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "creation_info" "specVersion"
      in
      let created =
        match assoc_ "created" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "creation_info" "created"
      in
      let created_by =
        match assoc_ "createdBy" with
        | Some v -> (Atdml_runtime.Yojson.list_of_yojson iri_of_yojson) v
        | None -> Atdml_runtime.Yojson.missing_field "creation_info" "createdBy"
      in
      { type_; spec_version; created; created_by }
  | _ -> Atdml_runtime.Yojson.bad_type "creation_info" x

let yojson_of_creation_info (x : creation_info) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("type", Atdml_runtime.Yojson.yojson_of_string x.type_) ];
         [
           ("specVersion", Atdml_runtime.Yojson.yojson_of_string x.spec_version);
         ];
         [ ("created", Atdml_runtime.Yojson.yojson_of_string x.created) ];
         [
           ( "createdBy",
             (Atdml_runtime.Yojson.yojson_of_list yojson_of_iri) x.created_by );
         ];
       ])

let creation_info_of_json s =
  creation_info_of_yojson (Yojson.Safe.from_string s)

let json_of_creation_info x = Yojson.Safe.to_string (yojson_of_creation_info x)

module Creation_info = struct
  type nonrec t = creation_info

  let create = create_creation_info
  let of_yojson = creation_info_of_yojson
  let to_yojson = yojson_of_creation_info
  let of_json = creation_info_of_json
  let to_json = json_of_creation_info
end

type tool = { spdx_id : iri; name : string; creation_info : creation_info }

let create_tool ~spdx_id ~name ~creation_info () : tool =
  { spdx_id; name; creation_info }

let tool_of_yojson (x : Yojson.Safe.t) : tool =
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
      let spdx_id =
        match assoc_ "spdxId" with
        | Some v -> iri_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "tool" "spdxId"
      in
      let name =
        match assoc_ "name" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "tool" "name"
      in
      let creation_info =
        match assoc_ "creationInfo" with
        | Some v -> creation_info_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "tool" "creationInfo"
      in
      { spdx_id; name; creation_info }
  | _ -> Atdml_runtime.Yojson.bad_type "tool" x

let yojson_of_tool (x : tool) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("spdxId", yojson_of_iri x.spdx_id) ];
         [ ("name", Atdml_runtime.Yojson.yojson_of_string x.name) ];
         [ ("creationInfo", yojson_of_creation_info x.creation_info) ];
       ])

let tool_of_json s = tool_of_yojson (Yojson.Safe.from_string s)
let json_of_tool x = Yojson.Safe.to_string (yojson_of_tool x)

module Tool = struct
  type nonrec t = tool

  let create = create_tool
  let of_yojson = tool_of_yojson
  let to_yojson = yojson_of_tool
  let of_json = tool_of_json
  let to_json = json_of_tool
end

type spdx_document = {
  spdx_id : iri;
  name : string;
  creation_info : creation_info;
  element : iri list;
  root_element : iri list;
}

let create_spdx_document ~spdx_id ~name ~creation_info ~element ~root_element ()
    : spdx_document =
  { spdx_id; name; creation_info; element; root_element }

let spdx_document_of_yojson (x : Yojson.Safe.t) : spdx_document =
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
      let spdx_id =
        match assoc_ "spdxId" with
        | Some v -> iri_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "spdx_document" "spdxId"
      in
      let name =
        match assoc_ "name" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "spdx_document" "name"
      in
      let creation_info =
        match assoc_ "creationInfo" with
        | Some v -> creation_info_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "spdx_document" "creationInfo"
      in
      let element =
        match assoc_ "element" with
        | Some v -> (Atdml_runtime.Yojson.list_of_yojson iri_of_yojson) v
        | None -> Atdml_runtime.Yojson.missing_field "spdx_document" "element"
      in
      let root_element =
        match assoc_ "rootElement" with
        | Some v -> (Atdml_runtime.Yojson.list_of_yojson iri_of_yojson) v
        | None ->
            Atdml_runtime.Yojson.missing_field "spdx_document" "rootElement"
      in
      { spdx_id; name; creation_info; element; root_element }
  | _ -> Atdml_runtime.Yojson.bad_type "spdx_document" x

let yojson_of_spdx_document (x : spdx_document) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("spdxId", yojson_of_iri x.spdx_id) ];
         [ ("name", Atdml_runtime.Yojson.yojson_of_string x.name) ];
         [ ("creationInfo", yojson_of_creation_info x.creation_info) ];
         [
           ( "element",
             (Atdml_runtime.Yojson.yojson_of_list yojson_of_iri) x.element );
         ];
         [
           ( "rootElement",
             (Atdml_runtime.Yojson.yojson_of_list yojson_of_iri) x.root_element
           );
         ];
       ])

let spdx_document_of_json s =
  spdx_document_of_yojson (Yojson.Safe.from_string s)

let json_of_spdx_document x = Yojson.Safe.to_string (yojson_of_spdx_document x)

module Spdx_document = struct
  type nonrec t = spdx_document

  let create = create_spdx_document
  let of_yojson = spdx_document_of_yojson
  let to_yojson = yojson_of_spdx_document
  let of_json = spdx_document_of_json
  let to_json = json_of_spdx_document
end

type software_package = {
  spdx_id : iri;
  name : string;
  creation_info : creation_info;
  software_package_version : string;
  software_package_url : iri;
  software_download_location : string option;
  description : string option;
}

let create_software_package ~spdx_id ~name ~creation_info
    ~software_package_version ~software_package_url ?software_download_location
    ?description () : software_package =
  {
    spdx_id;
    name;
    creation_info;
    software_package_version;
    software_package_url;
    software_download_location;
    description;
  }

let software_package_of_yojson (x : Yojson.Safe.t) : software_package =
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
      let spdx_id =
        match assoc_ "spdxId" with
        | Some v -> iri_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "software_package" "spdxId"
      in
      let name =
        match assoc_ "name" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "software_package" "name"
      in
      let creation_info =
        match assoc_ "creationInfo" with
        | Some v -> creation_info_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "software_package" "creationInfo"
      in
      let software_package_version =
        match assoc_ "software_packageVersion" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "software_package"
              "software_packageVersion"
      in
      let software_package_url =
        match assoc_ "software_packageUrl" with
        | Some v -> iri_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "software_package"
              "software_packageUrl"
      in
      let software_download_location =
        match assoc_ "software_downloadLocation" with
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
      {
        spdx_id;
        name;
        creation_info;
        software_package_version;
        software_package_url;
        software_download_location;
        description;
      }
  | _ -> Atdml_runtime.Yojson.bad_type "software_package" x

let yojson_of_software_package (x : software_package) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("spdxId", yojson_of_iri x.spdx_id) ];
         [ ("name", Atdml_runtime.Yojson.yojson_of_string x.name) ];
         [ ("creationInfo", yojson_of_creation_info x.creation_info) ];
         [
           ( "software_packageVersion",
             Atdml_runtime.Yojson.yojson_of_string x.software_package_version );
         ];
         [ ("software_packageUrl", yojson_of_iri x.software_package_url) ];
         (match x.software_download_location with
         | None -> []
         | Some v ->
             [
               ( "software_downloadLocation",
                 Atdml_runtime.Yojson.yojson_of_string v );
             ]);
         (match x.description with
         | None -> []
         | Some v ->
             [ ("description", Atdml_runtime.Yojson.yojson_of_string v) ]);
       ])

let software_package_of_json s =
  software_package_of_yojson (Yojson.Safe.from_string s)

let json_of_software_package x =
  Yojson.Safe.to_string (yojson_of_software_package x)

module Software_package = struct
  type nonrec t = software_package

  let create = create_software_package
  let of_yojson = software_package_of_yojson
  let to_yojson = yojson_of_software_package
  let of_json = software_package_of_json
  let to_json = json_of_software_package
end

type simplelicensing_license_expression = {
  spdx_id : iri;
  creation_info : creation_info;
  license_expression : string;
}

let create_simplelicensing_license_expression ~spdx_id ~creation_info
    ~license_expression () : simplelicensing_license_expression =
  { spdx_id; creation_info; license_expression }

let simplelicensing_license_expression_of_yojson (x : Yojson.Safe.t) :
    simplelicensing_license_expression =
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
      let spdx_id =
        match assoc_ "spdxId" with
        | Some v -> iri_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "simplelicensing_license_expression" "spdxId"
      in
      let creation_info =
        match assoc_ "creationInfo" with
        | Some v -> creation_info_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "simplelicensing_license_expression" "creationInfo"
      in
      let license_expression =
        match assoc_ "simplelicensing_licenseExpression" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field
              "simplelicensing_license_expression"
              "simplelicensing_licenseExpression"
      in
      { spdx_id; creation_info; license_expression }
  | _ -> Atdml_runtime.Yojson.bad_type "simplelicensing_license_expression" x

let yojson_of_simplelicensing_license_expression
    (x : simplelicensing_license_expression) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("spdxId", yojson_of_iri x.spdx_id) ];
         [ ("creationInfo", yojson_of_creation_info x.creation_info) ];
         [
           ( "simplelicensing_licenseExpression",
             Atdml_runtime.Yojson.yojson_of_string x.license_expression );
         ];
       ])

let simplelicensing_license_expression_of_json s =
  simplelicensing_license_expression_of_yojson (Yojson.Safe.from_string s)

let json_of_simplelicensing_license_expression x =
  Yojson.Safe.to_string (yojson_of_simplelicensing_license_expression x)

module Simplelicensing_license_expression = struct
  type nonrec t = simplelicensing_license_expression

  let create = create_simplelicensing_license_expression
  let of_yojson = simplelicensing_license_expression_of_yojson
  let to_yojson = yojson_of_simplelicensing_license_expression
  let of_json = simplelicensing_license_expression_of_json
  let to_json = json_of_simplelicensing_license_expression
end

type relationship_type =
  | DependsOn
  | Describes
  | HasDeclaredLicense
  | HasConcludedLicense

let relationship_type_of_yojson (x : Yojson.Safe.t) : relationship_type =
  match x with
  | `String "dependsOn" -> DependsOn
  | `String "describes" -> Describes
  | `String "hasDeclaredLicense" -> HasDeclaredLicense
  | `String "hasConcludedLicense" -> HasConcludedLicense
  | _ -> Atdml_runtime.Yojson.bad_sum "relationship_type" x

let yojson_of_relationship_type (x : relationship_type) : Yojson.Safe.t =
  match x with
  | DependsOn -> `String "dependsOn"
  | Describes -> `String "describes"
  | HasDeclaredLicense -> `String "hasDeclaredLicense"
  | HasConcludedLicense -> `String "hasConcludedLicense"

let relationship_type_of_json s =
  relationship_type_of_yojson (Yojson.Safe.from_string s)

let json_of_relationship_type x =
  Yojson.Safe.to_string (yojson_of_relationship_type x)

module Relationship_type = struct
  type nonrec t = relationship_type

  let of_yojson = relationship_type_of_yojson
  let to_yojson = yojson_of_relationship_type
  let of_json = relationship_type_of_json
  let to_json = json_of_relationship_type
end

type relationship = {
  spdx_id : iri;
  creation_info : creation_info;
  from_ : iri;
  to_ : iri list;
  relationship_type : relationship_type;
}

let create_relationship ~spdx_id ~creation_info ~from_ ~to_ ~relationship_type
    () : relationship =
  { spdx_id; creation_info; from_; to_; relationship_type }

let relationship_of_yojson (x : Yojson.Safe.t) : relationship =
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
      let spdx_id =
        match assoc_ "spdxId" with
        | Some v -> iri_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "relationship" "spdxId"
      in
      let creation_info =
        match assoc_ "creationInfo" with
        | Some v -> creation_info_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "relationship" "creationInfo"
      in
      let from_ =
        match assoc_ "from" with
        | Some v -> iri_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "relationship" "from"
      in
      let to_ =
        match assoc_ "to" with
        | Some v -> (Atdml_runtime.Yojson.list_of_yojson iri_of_yojson) v
        | None -> Atdml_runtime.Yojson.missing_field "relationship" "to"
      in
      let relationship_type =
        match assoc_ "relationshipType" with
        | Some v -> relationship_type_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "relationship" "relationshipType"
      in
      { spdx_id; creation_info; from_; to_; relationship_type }
  | _ -> Atdml_runtime.Yojson.bad_type "relationship" x

let yojson_of_relationship (x : relationship) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("spdxId", yojson_of_iri x.spdx_id) ];
         [ ("creationInfo", yojson_of_creation_info x.creation_info) ];
         [ ("from", yojson_of_iri x.from_) ];
         [ ("to", (Atdml_runtime.Yojson.yojson_of_list yojson_of_iri) x.to_) ];
         [
           ("relationshipType", yojson_of_relationship_type x.relationship_type);
         ];
       ])

let relationship_of_json s = relationship_of_yojson (Yojson.Safe.from_string s)
let json_of_relationship x = Yojson.Safe.to_string (yojson_of_relationship x)

module Relationship = struct
  type nonrec t = relationship

  let create = create_relationship
  let of_yojson = relationship_of_yojson
  let to_yojson = yojson_of_relationship
  let of_json = relationship_of_json
  let to_json = json_of_relationship
end

type lifecycle_scope = Runtime | Build | Test | Development | Other

let lifecycle_scope_of_yojson (x : Yojson.Safe.t) : lifecycle_scope =
  match x with
  | `String "runtime" -> Runtime
  | `String "build" -> Build
  | `String "test" -> Test
  | `String "development" -> Development
  | `String "other" -> Other
  | _ -> Atdml_runtime.Yojson.bad_sum "lifecycle_scope" x

let yojson_of_lifecycle_scope (x : lifecycle_scope) : Yojson.Safe.t =
  match x with
  | Runtime -> `String "runtime"
  | Build -> `String "build"
  | Test -> `String "test"
  | Development -> `String "development"
  | Other -> `String "other"

let lifecycle_scope_of_json s =
  lifecycle_scope_of_yojson (Yojson.Safe.from_string s)

let json_of_lifecycle_scope x =
  Yojson.Safe.to_string (yojson_of_lifecycle_scope x)

module Lifecycle_scope = struct
  type nonrec t = lifecycle_scope

  let of_yojson = lifecycle_scope_of_yojson
  let to_yojson = yojson_of_lifecycle_scope
  let of_json = lifecycle_scope_of_json
  let to_json = json_of_lifecycle_scope
end

type lifecycle_scoped_relationship = {
  spdx_id : iri;
  creation_info : creation_info;
  from_ : iri;
  to_ : iri list;
  relationship_type : relationship_type;
  scope : lifecycle_scope option;
}

let create_lifecycle_scoped_relationship ~spdx_id ~creation_info ~from_ ~to_
    ~relationship_type ?scope () : lifecycle_scoped_relationship =
  { spdx_id; creation_info; from_; to_; relationship_type; scope }

let lifecycle_scoped_relationship_of_yojson (x : Yojson.Safe.t) :
    lifecycle_scoped_relationship =
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
      let spdx_id =
        match assoc_ "spdxId" with
        | Some v -> iri_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "lifecycle_scoped_relationship"
              "spdxId"
      in
      let creation_info =
        match assoc_ "creationInfo" with
        | Some v -> creation_info_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "lifecycle_scoped_relationship"
              "creationInfo"
      in
      let from_ =
        match assoc_ "from" with
        | Some v -> iri_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "lifecycle_scoped_relationship"
              "from"
      in
      let to_ =
        match assoc_ "to" with
        | Some v -> (Atdml_runtime.Yojson.list_of_yojson iri_of_yojson) v
        | None ->
            Atdml_runtime.Yojson.missing_field "lifecycle_scoped_relationship"
              "to"
      in
      let relationship_type =
        match assoc_ "relationshipType" with
        | Some v -> relationship_type_of_yojson v
        | None ->
            Atdml_runtime.Yojson.missing_field "lifecycle_scoped_relationship"
              "relationshipType"
      in
      let scope =
        match assoc_ "scope" with
        | None
        | Some `Null ->
            None
        | Some v -> Some (lifecycle_scope_of_yojson v)
      in
      { spdx_id; creation_info; from_; to_; relationship_type; scope }
  | _ -> Atdml_runtime.Yojson.bad_type "lifecycle_scoped_relationship" x

let yojson_of_lifecycle_scoped_relationship (x : lifecycle_scoped_relationship)
    : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("spdxId", yojson_of_iri x.spdx_id) ];
         [ ("creationInfo", yojson_of_creation_info x.creation_info) ];
         [ ("from", yojson_of_iri x.from_) ];
         [ ("to", (Atdml_runtime.Yojson.yojson_of_list yojson_of_iri) x.to_) ];
         [
           ("relationshipType", yojson_of_relationship_type x.relationship_type);
         ];
         (match x.scope with
         | None -> []
         | Some v -> [ ("scope", yojson_of_lifecycle_scope v) ]);
       ])

let lifecycle_scoped_relationship_of_json s =
  lifecycle_scoped_relationship_of_yojson (Yojson.Safe.from_string s)

let json_of_lifecycle_scoped_relationship x =
  Yojson.Safe.to_string (yojson_of_lifecycle_scoped_relationship x)

module Lifecycle_scoped_relationship = struct
  type nonrec t = lifecycle_scoped_relationship

  let create = create_lifecycle_scoped_relationship
  let of_yojson = lifecycle_scoped_relationship_of_yojson
  let to_yojson = yojson_of_lifecycle_scoped_relationship
  let of_json = lifecycle_scoped_relationship_of_json
  let to_json = json_of_lifecycle_scoped_relationship
end

type graph_element =
  | SpdxDocument of spdx_document
  | Tool of tool
  | Software_Package of software_package
  | LifecycleScopedRelationship of lifecycle_scoped_relationship
  | Relationship of relationship
  | SimpleLicensing_LicenseExpression of simplelicensing_license_expression

let graph_element_of_yojson (x : Yojson.Safe.t) : graph_element =
  let x = Spdx_3_0_1_adapter.normalize x in
  match x with
  | `List [ `String "SpdxDocument"; v ] ->
      SpdxDocument (spdx_document_of_yojson v)
  | `List [ `String "Tool"; v ] -> Tool (tool_of_yojson v)
  | `List [ `String "software_Package"; v ] ->
      Software_Package (software_package_of_yojson v)
  | `List [ `String "LifecycleScopedRelationship"; v ] ->
      LifecycleScopedRelationship (lifecycle_scoped_relationship_of_yojson v)
  | `List [ `String "Relationship"; v ] ->
      Relationship (relationship_of_yojson v)
  | `List [ `String "simplelicensing_LicenseExpression"; v ] ->
      SimpleLicensing_LicenseExpression
        (simplelicensing_license_expression_of_yojson v)
  | _ -> Atdml_runtime.Yojson.bad_sum "graph_element" x

let yojson_of_graph_element (x : graph_element) : Yojson.Safe.t =
  let atdml_result_ =
    match x with
    | SpdxDocument v ->
        `List [ `String "SpdxDocument"; yojson_of_spdx_document v ]
    | Tool v -> `List [ `String "Tool"; yojson_of_tool v ]
    | Software_Package v ->
        `List [ `String "software_Package"; yojson_of_software_package v ]
    | LifecycleScopedRelationship v ->
        `List
          [
            `String "LifecycleScopedRelationship";
            yojson_of_lifecycle_scoped_relationship v;
          ]
    | Relationship v ->
        `List [ `String "Relationship"; yojson_of_relationship v ]
    | SimpleLicensing_LicenseExpression v ->
        `List
          [
            `String "simplelicensing_LicenseExpression";
            yojson_of_simplelicensing_license_expression v;
          ]
  in
  Spdx_3_0_1_adapter.restore atdml_result_

let graph_element_of_json s =
  graph_element_of_yojson (Yojson.Safe.from_string s)

let json_of_graph_element x = Yojson.Safe.to_string (yojson_of_graph_element x)

module Graph_element = struct
  type nonrec t = graph_element

  let of_yojson = graph_element_of_yojson
  let to_yojson = yojson_of_graph_element
  let of_json = graph_element_of_json
  let to_json = json_of_graph_element
end

type root_json = { context : string; graph : graph_element list }

let create_root_json ~context ~graph () : root_json = { context; graph }

let root_json_of_yojson (x : Yojson.Safe.t) : root_json =
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
      let context =
        match assoc_ "@context" with
        | Some v -> Atdml_runtime.Yojson.string_of_yojson v
        | None -> Atdml_runtime.Yojson.missing_field "root_json" "@context"
      in
      let graph =
        match assoc_ "@graph" with
        | Some v ->
            (Atdml_runtime.Yojson.list_of_yojson graph_element_of_yojson) v
        | None -> Atdml_runtime.Yojson.missing_field "root_json" "@graph"
      in
      { context; graph }
  | _ -> Atdml_runtime.Yojson.bad_type "root_json" x

let yojson_of_root_json (x : root_json) : Yojson.Safe.t =
  `Assoc
    (List.concat
       [
         [ ("@context", Atdml_runtime.Yojson.yojson_of_string x.context) ];
         [
           ( "@graph",
             (Atdml_runtime.Yojson.yojson_of_list yojson_of_graph_element)
               x.graph );
         ];
       ])

let root_json_of_json s = root_json_of_yojson (Yojson.Safe.from_string s)
let json_of_root_json x = Yojson.Safe.to_string (yojson_of_root_json x)

module Root_json = struct
  type nonrec t = root_json

  let create = create_root_json
  let of_yojson = root_json_of_yojson
  let to_yojson = yojson_of_root_json
  let of_json = root_json_of_json
  let to_json = json_of_root_json
end
