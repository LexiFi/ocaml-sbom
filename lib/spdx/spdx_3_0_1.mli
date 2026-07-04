(* Auto-generated from "spdx_3_0_1.atd" by atdml. *)

type iri = private string

val create_iri : string -> iri
val iri_of_yojson : Yojson.Safe.t -> iri
val yojson_of_iri : iri -> Yojson.Safe.t
val iri_of_json : string -> iri
val json_of_iri : iri -> string

module Iri : sig
  type nonrec t = iri

  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type creation_info = {
  type_ : string;
  spec_version : string;
  created : string;
  created_by : iri list;
}

val create_creation_info :
  type_:string ->
  spec_version:string ->
  created:string ->
  created_by:iri list ->
  unit ->
  creation_info

val creation_info_of_yojson : Yojson.Safe.t -> creation_info
val yojson_of_creation_info : creation_info -> Yojson.Safe.t
val creation_info_of_json : string -> creation_info
val json_of_creation_info : creation_info -> string

module Creation_info : sig
  type nonrec t = creation_info

  val create :
    type_:string ->
    spec_version:string ->
    created:string ->
    created_by:iri list ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type tool = { spdx_id : iri; name : string; creation_info : creation_info }

val create_tool :
  spdx_id:iri -> name:string -> creation_info:creation_info -> unit -> tool

val tool_of_yojson : Yojson.Safe.t -> tool
val yojson_of_tool : tool -> Yojson.Safe.t
val tool_of_json : string -> tool
val json_of_tool : tool -> string

module Tool : sig
  type nonrec t = tool

  val create :
    spdx_id:iri -> name:string -> creation_info:creation_info -> unit -> t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type spdx_document = {
  spdx_id : iri;
  name : string;
  creation_info : creation_info;
  element : iri list;
  root_element : iri list;
}

val create_spdx_document :
  spdx_id:iri ->
  name:string ->
  creation_info:creation_info ->
  element:iri list ->
  root_element:iri list ->
  unit ->
  spdx_document

val spdx_document_of_yojson : Yojson.Safe.t -> spdx_document
val yojson_of_spdx_document : spdx_document -> Yojson.Safe.t
val spdx_document_of_json : string -> spdx_document
val json_of_spdx_document : spdx_document -> string

module Spdx_document : sig
  type nonrec t = spdx_document

  val create :
    spdx_id:iri ->
    name:string ->
    creation_info:creation_info ->
    element:iri list ->
    root_element:iri list ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type software_package = {
  spdx_id : iri;
  name : string;
  creation_info : creation_info;
  software_package_version : string;
  software_package_url : iri;
  software_download_location : string option;
  license_declared : string option;
  license_concluded : string option;
  description : string option;
}

val create_software_package :
  spdx_id:iri ->
  name:string ->
  creation_info:creation_info ->
  software_package_version:string ->
  software_package_url:iri ->
  ?software_download_location:string ->
  ?license_declared:string ->
  ?license_concluded:string ->
  ?description:string ->
  unit ->
  software_package

val software_package_of_yojson : Yojson.Safe.t -> software_package
val yojson_of_software_package : software_package -> Yojson.Safe.t
val software_package_of_json : string -> software_package
val json_of_software_package : software_package -> string

module Software_package : sig
  type nonrec t = software_package

  val create :
    spdx_id:iri ->
    name:string ->
    creation_info:creation_info ->
    software_package_version:string ->
    software_package_url:iri ->
    ?software_download_location:string ->
    ?license_declared:string ->
    ?license_concluded:string ->
    ?description:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type relationship_type = DependsOn | Describes

val relationship_type_of_yojson : Yojson.Safe.t -> relationship_type
val yojson_of_relationship_type : relationship_type -> Yojson.Safe.t
val relationship_type_of_json : string -> relationship_type
val json_of_relationship_type : relationship_type -> string

module Relationship_type : sig
  type nonrec t = relationship_type

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type lifecycle_scope = Runtime | Build | Test | Development | Other

val lifecycle_scope_of_yojson : Yojson.Safe.t -> lifecycle_scope
val yojson_of_lifecycle_scope : lifecycle_scope -> Yojson.Safe.t
val lifecycle_scope_of_json : string -> lifecycle_scope
val json_of_lifecycle_scope : lifecycle_scope -> string

module Lifecycle_scope : sig
  type nonrec t = lifecycle_scope

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type lifecycle_scoped_relationship = {
  spdx_id : iri;
  creation_info : creation_info;
  from_ : iri;
  to_ : iri list;
  relationship_type : relationship_type;
  scope : lifecycle_scope option;
}

val create_lifecycle_scoped_relationship :
  spdx_id:iri ->
  creation_info:creation_info ->
  from_:iri ->
  to_:iri list ->
  relationship_type:relationship_type ->
  ?scope:lifecycle_scope ->
  unit ->
  lifecycle_scoped_relationship

val lifecycle_scoped_relationship_of_yojson :
  Yojson.Safe.t -> lifecycle_scoped_relationship

val yojson_of_lifecycle_scoped_relationship :
  lifecycle_scoped_relationship -> Yojson.Safe.t

val lifecycle_scoped_relationship_of_json :
  string -> lifecycle_scoped_relationship

val json_of_lifecycle_scoped_relationship :
  lifecycle_scoped_relationship -> string

module Lifecycle_scoped_relationship : sig
  type nonrec t = lifecycle_scoped_relationship

  val create :
    spdx_id:iri ->
    creation_info:creation_info ->
    from_:iri ->
    to_:iri list ->
    relationship_type:relationship_type ->
    ?scope:lifecycle_scope ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type graph_element =
  | SpdxDocument of spdx_document
  | Tool of tool
  | Software_Package of software_package
  | LifecycleScopedRelationship of lifecycle_scoped_relationship

val graph_element_of_yojson : Yojson.Safe.t -> graph_element
val yojson_of_graph_element : graph_element -> Yojson.Safe.t
val graph_element_of_json : string -> graph_element
val json_of_graph_element : graph_element -> string

module Graph_element : sig
  type nonrec t = graph_element

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type root_json = { context : string; graph : graph_element list }

val create_root_json :
  context:string -> graph:graph_element list -> unit -> root_json

val root_json_of_yojson : Yojson.Safe.t -> root_json
val yojson_of_root_json : root_json -> Yojson.Safe.t
val root_json_of_json : string -> root_json
val json_of_root_json : root_json -> string

module Root_json : sig
  type nonrec t = root_json

  val create : context:string -> graph:graph_element list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end
