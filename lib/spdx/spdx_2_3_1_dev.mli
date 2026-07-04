(* Auto-generated from "spdx_2_3_1_dev.atd" by atdml. *)

type sPDX231devSnippetsRangesStartPointer = {
  reference : string;  (** SPDX ID for File *)
  offset : int option;  (** Byte offset in the file *)
  lineNumber : int option;  (** line number offset in the file *)
}

val create_sPDX231devSnippetsRangesStartPointer :
  reference:string ->
  ?offset:int ->
  ?lineNumber:int ->
  unit ->
  sPDX231devSnippetsRangesStartPointer

val sPDX231devSnippetsRangesStartPointer_of_yojson :
  Yojson.Safe.t -> sPDX231devSnippetsRangesStartPointer

val yojson_of_sPDX231devSnippetsRangesStartPointer :
  sPDX231devSnippetsRangesStartPointer -> Yojson.Safe.t

val sPDX231devSnippetsRangesStartPointer_of_json :
  string -> sPDX231devSnippetsRangesStartPointer

val json_of_sPDX231devSnippetsRangesStartPointer :
  sPDX231devSnippetsRangesStartPointer -> string

module SPDX231devSnippetsRangesStartPointer : sig
  type nonrec t = sPDX231devSnippetsRangesStartPointer

  val create : reference:string -> ?offset:int -> ?lineNumber:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type sPDX231devSnippetsRangesEndPointer = {
  reference : string;  (** SPDX ID for File *)
  offset : int option;  (** Byte offset in the file *)
  lineNumber : int option;  (** line number offset in the file *)
}

val create_sPDX231devSnippetsRangesEndPointer :
  reference:string ->
  ?offset:int ->
  ?lineNumber:int ->
  unit ->
  sPDX231devSnippetsRangesEndPointer

val sPDX231devSnippetsRangesEndPointer_of_yojson :
  Yojson.Safe.t -> sPDX231devSnippetsRangesEndPointer

val yojson_of_sPDX231devSnippetsRangesEndPointer :
  sPDX231devSnippetsRangesEndPointer -> Yojson.Safe.t

val sPDX231devSnippetsRangesEndPointer_of_json :
  string -> sPDX231devSnippetsRangesEndPointer

val json_of_sPDX231devSnippetsRangesEndPointer :
  sPDX231devSnippetsRangesEndPointer -> string

module SPDX231devSnippetsRangesEndPointer : sig
  type nonrec t = sPDX231devSnippetsRangesEndPointer

  val create : reference:string -> ?offset:int -> ?lineNumber:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type sPDX231devSnippetsRanges = {
  endPointer : sPDX231devSnippetsRangesEndPointer;
  startPointer : sPDX231devSnippetsRangesStartPointer;
}

val create_sPDX231devSnippetsRanges :
  endPointer:sPDX231devSnippetsRangesEndPointer ->
  startPointer:sPDX231devSnippetsRangesStartPointer ->
  unit ->
  sPDX231devSnippetsRanges

val sPDX231devSnippetsRanges_of_yojson :
  Yojson.Safe.t -> sPDX231devSnippetsRanges

val yojson_of_sPDX231devSnippetsRanges :
  sPDX231devSnippetsRanges -> Yojson.Safe.t

val sPDX231devSnippetsRanges_of_json : string -> sPDX231devSnippetsRanges
val json_of_sPDX231devSnippetsRanges : sPDX231devSnippetsRanges -> string

module SPDX231devSnippetsRanges : sig
  type nonrec t = sPDX231devSnippetsRanges

  val create :
    endPointer:sPDX231devSnippetsRangesEndPointer ->
    startPointer:sPDX231devSnippetsRangesStartPointer ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Type of the annotation. *)
type sPDX231devSnippetsAnnotationsAnnotationType = OTHER | REVIEW

val sPDX231devSnippetsAnnotationsAnnotationType_of_yojson :
  Yojson.Safe.t -> sPDX231devSnippetsAnnotationsAnnotationType

val yojson_of_sPDX231devSnippetsAnnotationsAnnotationType :
  sPDX231devSnippetsAnnotationsAnnotationType -> Yojson.Safe.t

val sPDX231devSnippetsAnnotationsAnnotationType_of_json :
  string -> sPDX231devSnippetsAnnotationsAnnotationType

val json_of_sPDX231devSnippetsAnnotationsAnnotationType :
  sPDX231devSnippetsAnnotationsAnnotationType -> string

module SPDX231devSnippetsAnnotationsAnnotationType : sig
  type nonrec t = sPDX231devSnippetsAnnotationsAnnotationType

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devSnippetsAnnotations :
  annotationDate:string ->
  annotationType:sPDX231devSnippetsAnnotationsAnnotationType ->
  annotator:string ->
  comment:string ->
  unit ->
  sPDX231devSnippetsAnnotations

val sPDX231devSnippetsAnnotations_of_yojson :
  Yojson.Safe.t -> sPDX231devSnippetsAnnotations

val yojson_of_sPDX231devSnippetsAnnotations :
  sPDX231devSnippetsAnnotations -> Yojson.Safe.t

val sPDX231devSnippetsAnnotations_of_json :
  string -> sPDX231devSnippetsAnnotations

val json_of_sPDX231devSnippetsAnnotations :
  sPDX231devSnippetsAnnotations -> string

module SPDX231devSnippetsAnnotations : sig
  type nonrec t = sPDX231devSnippetsAnnotations

  val create :
    annotationDate:string ->
    annotationType:sPDX231devSnippetsAnnotationsAnnotationType ->
    annotator:string ->
    comment:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devSnippets :
  sPDXID:string ->
  ?annotations:sPDX231devSnippetsAnnotations list ->
  ?attributionTexts:string list ->
  ?comment:string ->
  ?copyrightText:string ->
  ?licenseComments:string ->
  ?licenseConcluded:string ->
  ?licenseInfoInSnippets:string list ->
  ?name:string ->
  ranges:sPDX231devSnippetsRanges list ->
  snippetFromFile:string ->
  unit ->
  sPDX231devSnippets

val sPDX231devSnippets_of_yojson : Yojson.Safe.t -> sPDX231devSnippets
val yojson_of_sPDX231devSnippets : sPDX231devSnippets -> Yojson.Safe.t
val sPDX231devSnippets_of_json : string -> sPDX231devSnippets
val json_of_sPDX231devSnippets : sPDX231devSnippets -> string

module SPDX231devSnippets : sig
  type nonrec t = sPDX231devSnippets

  val create :
    sPDXID:string ->
    ?annotations:sPDX231devSnippetsAnnotations list ->
    ?attributionTexts:string list ->
    ?comment:string ->
    ?copyrightText:string ->
    ?licenseComments:string ->
    ?licenseConcluded:string ->
    ?licenseInfoInSnippets:string list ->
    ?name:string ->
    ranges:sPDX231devSnippetsRanges list ->
    snippetFromFile:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devRevieweds :
  ?comment:string ->
  reviewDate:string ->
  ?reviewer:string ->
  unit ->
  sPDX231devRevieweds

val sPDX231devRevieweds_of_yojson : Yojson.Safe.t -> sPDX231devRevieweds
val yojson_of_sPDX231devRevieweds : sPDX231devRevieweds -> Yojson.Safe.t
val sPDX231devRevieweds_of_json : string -> sPDX231devRevieweds
val json_of_sPDX231devRevieweds : sPDX231devRevieweds -> string

module SPDX231devRevieweds : sig
  type nonrec t = sPDX231devRevieweds

  val create :
    ?comment:string -> reviewDate:string -> ?reviewer:string -> unit -> t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val sPDX231devRelationshipsRelationshipType_of_yojson :
  Yojson.Safe.t -> sPDX231devRelationshipsRelationshipType

val yojson_of_sPDX231devRelationshipsRelationshipType :
  sPDX231devRelationshipsRelationshipType -> Yojson.Safe.t

val sPDX231devRelationshipsRelationshipType_of_json :
  string -> sPDX231devRelationshipsRelationshipType

val json_of_sPDX231devRelationshipsRelationshipType :
  sPDX231devRelationshipsRelationshipType -> string

module SPDX231devRelationshipsRelationshipType : sig
  type nonrec t = sPDX231devRelationshipsRelationshipType

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type sPDX231devRelationships = {
  spdxElementId : string;  (** Id to which the SPDX element is related *)
  comment : string option;
  relatedSpdxElement : string;
      (** SPDX ID for SpdxElement. A related SpdxElement. *)
  relationshipType : sPDX231devRelationshipsRelationshipType;
      (** Describes the type of relationship between two SPDX elements. *)
}

val create_sPDX231devRelationships :
  spdxElementId:string ->
  ?comment:string ->
  relatedSpdxElement:string ->
  relationshipType:sPDX231devRelationshipsRelationshipType ->
  unit ->
  sPDX231devRelationships

val sPDX231devRelationships_of_yojson : Yojson.Safe.t -> sPDX231devRelationships
val yojson_of_sPDX231devRelationships : sPDX231devRelationships -> Yojson.Safe.t
val sPDX231devRelationships_of_json : string -> sPDX231devRelationships
val json_of_sPDX231devRelationships : sPDX231devRelationships -> string

module SPDX231devRelationships : sig
  type nonrec t = sPDX231devRelationships

  val create :
    spdxElementId:string ->
    ?comment:string ->
    relatedSpdxElement:string ->
    relationshipType:sPDX231devRelationshipsRelationshipType ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val sPDX231devPackagesPrimaryPackagePurpose_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesPrimaryPackagePurpose

val yojson_of_sPDX231devPackagesPrimaryPackagePurpose :
  sPDX231devPackagesPrimaryPackagePurpose -> Yojson.Safe.t

val sPDX231devPackagesPrimaryPackagePurpose_of_json :
  string -> sPDX231devPackagesPrimaryPackagePurpose

val json_of_sPDX231devPackagesPrimaryPackagePurpose :
  sPDX231devPackagesPrimaryPackagePurpose -> string

module SPDX231devPackagesPrimaryPackagePurpose : sig
  type nonrec t = sPDX231devPackagesPrimaryPackagePurpose

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devPackagesPackageVerificationCode :
  ?packageVerificationCodeExcludedFiles:string list ->
  packageVerificationCodeValue:string ->
  unit ->
  sPDX231devPackagesPackageVerificationCode

val sPDX231devPackagesPackageVerificationCode_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesPackageVerificationCode

val yojson_of_sPDX231devPackagesPackageVerificationCode :
  sPDX231devPackagesPackageVerificationCode -> Yojson.Safe.t

val sPDX231devPackagesPackageVerificationCode_of_json :
  string -> sPDX231devPackagesPackageVerificationCode

val json_of_sPDX231devPackagesPackageVerificationCode :
  sPDX231devPackagesPackageVerificationCode -> string

module SPDX231devPackagesPackageVerificationCode : sig
  type nonrec t = sPDX231devPackagesPackageVerificationCode

  val create :
    ?packageVerificationCodeExcludedFiles:string list ->
    packageVerificationCodeValue:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Category for the external reference *)
type sPDX231devPackagesExternalRefsReferenceCategory =
  | OTHER
  | PERSISTENTID
  | PERSISTENT_ID
  | SECURITY
  | PACKAGEMANAGER
  | PACKAGE_MANAGER

val sPDX231devPackagesExternalRefsReferenceCategory_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesExternalRefsReferenceCategory

val yojson_of_sPDX231devPackagesExternalRefsReferenceCategory :
  sPDX231devPackagesExternalRefsReferenceCategory -> Yojson.Safe.t

val sPDX231devPackagesExternalRefsReferenceCategory_of_json :
  string -> sPDX231devPackagesExternalRefsReferenceCategory

val json_of_sPDX231devPackagesExternalRefsReferenceCategory :
  sPDX231devPackagesExternalRefsReferenceCategory -> string

module SPDX231devPackagesExternalRefsReferenceCategory : sig
  type nonrec t = sPDX231devPackagesExternalRefsReferenceCategory

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devPackagesExternalRefs :
  ?comment:string ->
  referenceCategory:sPDX231devPackagesExternalRefsReferenceCategory ->
  referenceLocator:string ->
  referenceType:string ->
  unit ->
  sPDX231devPackagesExternalRefs

val sPDX231devPackagesExternalRefs_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesExternalRefs

val yojson_of_sPDX231devPackagesExternalRefs :
  sPDX231devPackagesExternalRefs -> Yojson.Safe.t

val sPDX231devPackagesExternalRefs_of_json :
  string -> sPDX231devPackagesExternalRefs

val json_of_sPDX231devPackagesExternalRefs :
  sPDX231devPackagesExternalRefs -> string

module SPDX231devPackagesExternalRefs : sig
  type nonrec t = sPDX231devPackagesExternalRefs

  val create :
    ?comment:string ->
    referenceCategory:sPDX231devPackagesExternalRefsReferenceCategory ->
    referenceLocator:string ->
    referenceType:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val sPDX231devPackagesChecksumsAlgorithm_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesChecksumsAlgorithm

val yojson_of_sPDX231devPackagesChecksumsAlgorithm :
  sPDX231devPackagesChecksumsAlgorithm -> Yojson.Safe.t

val sPDX231devPackagesChecksumsAlgorithm_of_json :
  string -> sPDX231devPackagesChecksumsAlgorithm

val json_of_sPDX231devPackagesChecksumsAlgorithm :
  sPDX231devPackagesChecksumsAlgorithm -> string

module SPDX231devPackagesChecksumsAlgorithm : sig
  type nonrec t = sPDX231devPackagesChecksumsAlgorithm

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devPackagesChecksums :
  algorithm:sPDX231devPackagesChecksumsAlgorithm ->
  checksumValue:string ->
  unit ->
  sPDX231devPackagesChecksums

val sPDX231devPackagesChecksums_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesChecksums

val yojson_of_sPDX231devPackagesChecksums :
  sPDX231devPackagesChecksums -> Yojson.Safe.t

val sPDX231devPackagesChecksums_of_json : string -> sPDX231devPackagesChecksums
val json_of_sPDX231devPackagesChecksums : sPDX231devPackagesChecksums -> string

module SPDX231devPackagesChecksums : sig
  type nonrec t = sPDX231devPackagesChecksums

  val create :
    algorithm:sPDX231devPackagesChecksumsAlgorithm ->
    checksumValue:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Type of the annotation. *)
type sPDX231devPackagesAnnotationsAnnotationType = OTHER | REVIEW

val sPDX231devPackagesAnnotationsAnnotationType_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesAnnotationsAnnotationType

val yojson_of_sPDX231devPackagesAnnotationsAnnotationType :
  sPDX231devPackagesAnnotationsAnnotationType -> Yojson.Safe.t

val sPDX231devPackagesAnnotationsAnnotationType_of_json :
  string -> sPDX231devPackagesAnnotationsAnnotationType

val json_of_sPDX231devPackagesAnnotationsAnnotationType :
  sPDX231devPackagesAnnotationsAnnotationType -> string

module SPDX231devPackagesAnnotationsAnnotationType : sig
  type nonrec t = sPDX231devPackagesAnnotationsAnnotationType

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devPackagesAnnotations :
  annotationDate:string ->
  annotationType:sPDX231devPackagesAnnotationsAnnotationType ->
  annotator:string ->
  comment:string ->
  unit ->
  sPDX231devPackagesAnnotations

val sPDX231devPackagesAnnotations_of_yojson :
  Yojson.Safe.t -> sPDX231devPackagesAnnotations

val yojson_of_sPDX231devPackagesAnnotations :
  sPDX231devPackagesAnnotations -> Yojson.Safe.t

val sPDX231devPackagesAnnotations_of_json :
  string -> sPDX231devPackagesAnnotations

val json_of_sPDX231devPackagesAnnotations :
  sPDX231devPackagesAnnotations -> string

module SPDX231devPackagesAnnotations : sig
  type nonrec t = sPDX231devPackagesAnnotations

  val create :
    annotationDate:string ->
    annotationType:sPDX231devPackagesAnnotationsAnnotationType ->
    annotator:string ->
    comment:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devPackages :
  sPDXID:string ->
  ?annotations:sPDX231devPackagesAnnotations list ->
  ?attributionTexts:string list ->
  ?builtDate:string ->
  ?checksums:sPDX231devPackagesChecksums list ->
  ?comment:string ->
  ?copyrightText:string ->
  ?description:string ->
  downloadLocation:string ->
  ?externalRefs:sPDX231devPackagesExternalRefs list ->
  ?filesAnalyzed:bool ->
  ?hasFiles:string list ->
  ?homepage:string ->
  ?licenseComments:string ->
  ?licenseConcluded:string ->
  ?licenseDeclared:string ->
  ?licenseInfoFromFiles:string list ->
  name:string ->
  ?originator:string ->
  ?packageFileName:string ->
  ?packageVerificationCode:sPDX231devPackagesPackageVerificationCode ->
  ?primaryPackagePurpose:sPDX231devPackagesPrimaryPackagePurpose ->
  ?releaseDate:string ->
  ?sourceInfo:string ->
  ?summary:string ->
  ?supplier:string ->
  ?validUntilDate:string ->
  ?versionInfo:string ->
  unit ->
  sPDX231devPackages

val sPDX231devPackages_of_yojson : Yojson.Safe.t -> sPDX231devPackages
val yojson_of_sPDX231devPackages : sPDX231devPackages -> Yojson.Safe.t
val sPDX231devPackages_of_json : string -> sPDX231devPackages
val json_of_sPDX231devPackages : sPDX231devPackages -> string

module SPDX231devPackages : sig
  type nonrec t = sPDX231devPackages

  val create :
    sPDXID:string ->
    ?annotations:sPDX231devPackagesAnnotations list ->
    ?attributionTexts:string list ->
    ?builtDate:string ->
    ?checksums:sPDX231devPackagesChecksums list ->
    ?comment:string ->
    ?copyrightText:string ->
    ?description:string ->
    downloadLocation:string ->
    ?externalRefs:sPDX231devPackagesExternalRefs list ->
    ?filesAnalyzed:bool ->
    ?hasFiles:string list ->
    ?homepage:string ->
    ?licenseComments:string ->
    ?licenseConcluded:string ->
    ?licenseDeclared:string ->
    ?licenseInfoFromFiles:string list ->
    name:string ->
    ?originator:string ->
    ?packageFileName:string ->
    ?packageVerificationCode:sPDX231devPackagesPackageVerificationCode ->
    ?primaryPackagePurpose:sPDX231devPackagesPrimaryPackagePurpose ->
    ?releaseDate:string ->
    ?sourceInfo:string ->
    ?summary:string ->
    ?supplier:string ->
    ?validUntilDate:string ->
    ?versionInfo:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devHasExtractedLicensingInfosCrossRefs :
  ?isLive:bool ->
  ?isValid:bool ->
  ?isWayBackLink:bool ->
  ?match_:string ->
  ?order:int ->
  ?timestamp:string ->
  url:string ->
  unit ->
  sPDX231devHasExtractedLicensingInfosCrossRefs

val sPDX231devHasExtractedLicensingInfosCrossRefs_of_yojson :
  Yojson.Safe.t -> sPDX231devHasExtractedLicensingInfosCrossRefs

val yojson_of_sPDX231devHasExtractedLicensingInfosCrossRefs :
  sPDX231devHasExtractedLicensingInfosCrossRefs -> Yojson.Safe.t

val sPDX231devHasExtractedLicensingInfosCrossRefs_of_json :
  string -> sPDX231devHasExtractedLicensingInfosCrossRefs

val json_of_sPDX231devHasExtractedLicensingInfosCrossRefs :
  sPDX231devHasExtractedLicensingInfosCrossRefs -> string

module SPDX231devHasExtractedLicensingInfosCrossRefs : sig
  type nonrec t = sPDX231devHasExtractedLicensingInfosCrossRefs

  val create :
    ?isLive:bool ->
    ?isValid:bool ->
    ?isWayBackLink:bool ->
    ?match_:string ->
    ?order:int ->
    ?timestamp:string ->
    url:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devHasExtractedLicensingInfos :
  ?comment:string ->
  ?crossRefs:sPDX231devHasExtractedLicensingInfosCrossRefs list ->
  extractedText:string ->
  licenseId:string ->
  ?name:string ->
  ?seeAlsos:string list ->
  unit ->
  sPDX231devHasExtractedLicensingInfos

val sPDX231devHasExtractedLicensingInfos_of_yojson :
  Yojson.Safe.t -> sPDX231devHasExtractedLicensingInfos

val yojson_of_sPDX231devHasExtractedLicensingInfos :
  sPDX231devHasExtractedLicensingInfos -> Yojson.Safe.t

val sPDX231devHasExtractedLicensingInfos_of_json :
  string -> sPDX231devHasExtractedLicensingInfos

val json_of_sPDX231devHasExtractedLicensingInfos :
  sPDX231devHasExtractedLicensingInfos -> string

module SPDX231devHasExtractedLicensingInfos : sig
  type nonrec t = sPDX231devHasExtractedLicensingInfos

  val create :
    ?comment:string ->
    ?crossRefs:sPDX231devHasExtractedLicensingInfosCrossRefs list ->
    extractedText:string ->
    licenseId:string ->
    ?name:string ->
    ?seeAlsos:string list ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val sPDX231devFilesFileTypes_of_yojson :
  Yojson.Safe.t -> sPDX231devFilesFileTypes

val yojson_of_sPDX231devFilesFileTypes :
  sPDX231devFilesFileTypes -> Yojson.Safe.t

val sPDX231devFilesFileTypes_of_json : string -> sPDX231devFilesFileTypes
val json_of_sPDX231devFilesFileTypes : sPDX231devFilesFileTypes -> string

module SPDX231devFilesFileTypes : sig
  type nonrec t = sPDX231devFilesFileTypes

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val sPDX231devFilesChecksumsAlgorithm_of_yojson :
  Yojson.Safe.t -> sPDX231devFilesChecksumsAlgorithm

val yojson_of_sPDX231devFilesChecksumsAlgorithm :
  sPDX231devFilesChecksumsAlgorithm -> Yojson.Safe.t

val sPDX231devFilesChecksumsAlgorithm_of_json :
  string -> sPDX231devFilesChecksumsAlgorithm

val json_of_sPDX231devFilesChecksumsAlgorithm :
  sPDX231devFilesChecksumsAlgorithm -> string

module SPDX231devFilesChecksumsAlgorithm : sig
  type nonrec t = sPDX231devFilesChecksumsAlgorithm

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devFilesChecksums :
  algorithm:sPDX231devFilesChecksumsAlgorithm ->
  checksumValue:string ->
  unit ->
  sPDX231devFilesChecksums

val sPDX231devFilesChecksums_of_yojson :
  Yojson.Safe.t -> sPDX231devFilesChecksums

val yojson_of_sPDX231devFilesChecksums :
  sPDX231devFilesChecksums -> Yojson.Safe.t

val sPDX231devFilesChecksums_of_json : string -> sPDX231devFilesChecksums
val json_of_sPDX231devFilesChecksums : sPDX231devFilesChecksums -> string

module SPDX231devFilesChecksums : sig
  type nonrec t = sPDX231devFilesChecksums

  val create :
    algorithm:sPDX231devFilesChecksumsAlgorithm ->
    checksumValue:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Type of the annotation. *)
type sPDX231devFilesAnnotationsAnnotationType = OTHER | REVIEW

val sPDX231devFilesAnnotationsAnnotationType_of_yojson :
  Yojson.Safe.t -> sPDX231devFilesAnnotationsAnnotationType

val yojson_of_sPDX231devFilesAnnotationsAnnotationType :
  sPDX231devFilesAnnotationsAnnotationType -> Yojson.Safe.t

val sPDX231devFilesAnnotationsAnnotationType_of_json :
  string -> sPDX231devFilesAnnotationsAnnotationType

val json_of_sPDX231devFilesAnnotationsAnnotationType :
  sPDX231devFilesAnnotationsAnnotationType -> string

module SPDX231devFilesAnnotationsAnnotationType : sig
  type nonrec t = sPDX231devFilesAnnotationsAnnotationType

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devFilesAnnotations :
  annotationDate:string ->
  annotationType:sPDX231devFilesAnnotationsAnnotationType ->
  annotator:string ->
  comment:string ->
  unit ->
  sPDX231devFilesAnnotations

val sPDX231devFilesAnnotations_of_yojson :
  Yojson.Safe.t -> sPDX231devFilesAnnotations

val yojson_of_sPDX231devFilesAnnotations :
  sPDX231devFilesAnnotations -> Yojson.Safe.t

val sPDX231devFilesAnnotations_of_json : string -> sPDX231devFilesAnnotations
val json_of_sPDX231devFilesAnnotations : sPDX231devFilesAnnotations -> string

module SPDX231devFilesAnnotations : sig
  type nonrec t = sPDX231devFilesAnnotations

  val create :
    annotationDate:string ->
    annotationType:sPDX231devFilesAnnotationsAnnotationType ->
    annotator:string ->
    comment:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type json_ = Yojson.Safe.t

val json__of_yojson : Yojson.Safe.t -> json_
val yojson_of_json_ : json_ -> Yojson.Safe.t
val json__of_json : string -> json_
val json_of_json_ : json_ -> string

module Json_ : sig
  type nonrec t = json_

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devFiles :
  sPDXID:string ->
  ?annotations:sPDX231devFilesAnnotations list ->
  ?artifactOfs:json_ list ->
  ?attributionTexts:string list ->
  checksums:sPDX231devFilesChecksums list ->
  ?comment:string ->
  ?copyrightText:string ->
  ?fileContributors:string list ->
  ?fileDependencies:string list ->
  fileName:string ->
  ?fileTypes:sPDX231devFilesFileTypes list ->
  ?licenseComments:string ->
  ?licenseConcluded:string ->
  ?licenseInfoInFiles:string list ->
  ?noticeText:string ->
  unit ->
  sPDX231devFiles

val sPDX231devFiles_of_yojson : Yojson.Safe.t -> sPDX231devFiles
val yojson_of_sPDX231devFiles : sPDX231devFiles -> Yojson.Safe.t
val sPDX231devFiles_of_json : string -> sPDX231devFiles
val json_of_sPDX231devFiles : sPDX231devFiles -> string

module SPDX231devFiles : sig
  type nonrec t = sPDX231devFiles

  val create :
    sPDXID:string ->
    ?annotations:sPDX231devFilesAnnotations list ->
    ?artifactOfs:json_ list ->
    ?attributionTexts:string list ->
    checksums:sPDX231devFilesChecksums list ->
    ?comment:string ->
    ?copyrightText:string ->
    ?fileContributors:string list ->
    ?fileDependencies:string list ->
    fileName:string ->
    ?fileTypes:sPDX231devFilesFileTypes list ->
    ?licenseComments:string ->
    ?licenseConcluded:string ->
    ?licenseInfoInFiles:string list ->
    ?noticeText:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val sPDX231devExternalDocumentRefsChecksumAlgorithm_of_yojson :
  Yojson.Safe.t -> sPDX231devExternalDocumentRefsChecksumAlgorithm

val yojson_of_sPDX231devExternalDocumentRefsChecksumAlgorithm :
  sPDX231devExternalDocumentRefsChecksumAlgorithm -> Yojson.Safe.t

val sPDX231devExternalDocumentRefsChecksumAlgorithm_of_json :
  string -> sPDX231devExternalDocumentRefsChecksumAlgorithm

val json_of_sPDX231devExternalDocumentRefsChecksumAlgorithm :
  sPDX231devExternalDocumentRefsChecksumAlgorithm -> string

module SPDX231devExternalDocumentRefsChecksumAlgorithm : sig
  type nonrec t = sPDX231devExternalDocumentRefsChecksumAlgorithm

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devExternalDocumentRefsChecksum :
  algorithm:sPDX231devExternalDocumentRefsChecksumAlgorithm ->
  checksumValue:string ->
  unit ->
  sPDX231devExternalDocumentRefsChecksum

val sPDX231devExternalDocumentRefsChecksum_of_yojson :
  Yojson.Safe.t -> sPDX231devExternalDocumentRefsChecksum

val yojson_of_sPDX231devExternalDocumentRefsChecksum :
  sPDX231devExternalDocumentRefsChecksum -> Yojson.Safe.t

val sPDX231devExternalDocumentRefsChecksum_of_json :
  string -> sPDX231devExternalDocumentRefsChecksum

val json_of_sPDX231devExternalDocumentRefsChecksum :
  sPDX231devExternalDocumentRefsChecksum -> string

module SPDX231devExternalDocumentRefsChecksum : sig
  type nonrec t = sPDX231devExternalDocumentRefsChecksum

  val create :
    algorithm:sPDX231devExternalDocumentRefsChecksumAlgorithm ->
    checksumValue:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devExternalDocumentRefs :
  checksum:sPDX231devExternalDocumentRefsChecksum ->
  externalDocumentId:string ->
  spdxDocument:string ->
  unit ->
  sPDX231devExternalDocumentRefs

val sPDX231devExternalDocumentRefs_of_yojson :
  Yojson.Safe.t -> sPDX231devExternalDocumentRefs

val yojson_of_sPDX231devExternalDocumentRefs :
  sPDX231devExternalDocumentRefs -> Yojson.Safe.t

val sPDX231devExternalDocumentRefs_of_json :
  string -> sPDX231devExternalDocumentRefs

val json_of_sPDX231devExternalDocumentRefs :
  sPDX231devExternalDocumentRefs -> string

module SPDX231devExternalDocumentRefs : sig
  type nonrec t = sPDX231devExternalDocumentRefs

  val create :
    checksum:sPDX231devExternalDocumentRefsChecksum ->
    externalDocumentId:string ->
    spdxDocument:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devCreationInfo :
  ?comment:string ->
  created:string ->
  creators:string list ->
  ?licenseListVersion:string ->
  unit ->
  sPDX231devCreationInfo

val sPDX231devCreationInfo_of_yojson : Yojson.Safe.t -> sPDX231devCreationInfo
val yojson_of_sPDX231devCreationInfo : sPDX231devCreationInfo -> Yojson.Safe.t
val sPDX231devCreationInfo_of_json : string -> sPDX231devCreationInfo
val json_of_sPDX231devCreationInfo : sPDX231devCreationInfo -> string

module SPDX231devCreationInfo : sig
  type nonrec t = sPDX231devCreationInfo

  val create :
    ?comment:string ->
    created:string ->
    creators:string list ->
    ?licenseListVersion:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Type of the annotation. *)
type sPDX231devAnnotationsAnnotationType = OTHER | REVIEW

val sPDX231devAnnotationsAnnotationType_of_yojson :
  Yojson.Safe.t -> sPDX231devAnnotationsAnnotationType

val yojson_of_sPDX231devAnnotationsAnnotationType :
  sPDX231devAnnotationsAnnotationType -> Yojson.Safe.t

val sPDX231devAnnotationsAnnotationType_of_json :
  string -> sPDX231devAnnotationsAnnotationType

val json_of_sPDX231devAnnotationsAnnotationType :
  sPDX231devAnnotationsAnnotationType -> string

module SPDX231devAnnotationsAnnotationType : sig
  type nonrec t = sPDX231devAnnotationsAnnotationType

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231devAnnotations :
  annotationDate:string ->
  annotationType:sPDX231devAnnotationsAnnotationType ->
  annotator:string ->
  comment:string ->
  unit ->
  sPDX231devAnnotations

val sPDX231devAnnotations_of_yojson : Yojson.Safe.t -> sPDX231devAnnotations
val yojson_of_sPDX231devAnnotations : sPDX231devAnnotations -> Yojson.Safe.t
val sPDX231devAnnotations_of_json : string -> sPDX231devAnnotations
val json_of_sPDX231devAnnotations : sPDX231devAnnotations -> string

module SPDX231devAnnotations : sig
  type nonrec t = sPDX231devAnnotations

  val create :
    annotationDate:string ->
    annotationType:sPDX231devAnnotationsAnnotationType ->
    annotator:string ->
    comment:string ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_sPDX231dev :
  ?schema:string ->
  sPDXID:string ->
  ?annotations:sPDX231devAnnotations list ->
  ?comment:string ->
  creationInfo:sPDX231devCreationInfo ->
  dataLicense:string ->
  ?externalDocumentRefs:sPDX231devExternalDocumentRefs list ->
  ?hasExtractedLicensingInfos:sPDX231devHasExtractedLicensingInfos list ->
  name:string ->
  ?revieweds:sPDX231devRevieweds list ->
  spdxVersion:string ->
  documentNamespace:string ->
  ?documentDescribes:string list ->
  ?packages:sPDX231devPackages list ->
  ?files:sPDX231devFiles list ->
  ?snippets:sPDX231devSnippets list ->
  ?relationships:sPDX231devRelationships list ->
  unit ->
  sPDX231dev

val sPDX231dev_of_yojson : Yojson.Safe.t -> sPDX231dev
val yojson_of_sPDX231dev : sPDX231dev -> Yojson.Safe.t
val sPDX231dev_of_json : string -> sPDX231dev
val json_of_sPDX231dev : sPDX231dev -> string

module SPDX231dev : sig
  type nonrec t = sPDX231dev

  val create :
    ?schema:string ->
    sPDXID:string ->
    ?annotations:sPDX231devAnnotations list ->
    ?comment:string ->
    creationInfo:sPDX231devCreationInfo ->
    dataLicense:string ->
    ?externalDocumentRefs:sPDX231devExternalDocumentRefs list ->
    ?hasExtractedLicensingInfos:sPDX231devHasExtractedLicensingInfos list ->
    name:string ->
    ?revieweds:sPDX231devRevieweds list ->
    spdxVersion:string ->
    documentNamespace:string ->
    ?documentDescribes:string list ->
    ?packages:sPDX231devPackages list ->
    ?files:sPDX231devFiles list ->
    ?snippets:sPDX231devSnippets list ->
    ?relationships:sPDX231devRelationships list ->
    unit ->
    t

  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type int64 = private int

val create_int64 : int -> int64
val int64_of_yojson : Yojson.Safe.t -> int64
val yojson_of_int64 : int64 -> Yojson.Safe.t
val int64_of_json : string -> int64
val json_of_int64 : int64 -> string

module Int64 : sig
  type nonrec t = int64

  val create : int -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end
