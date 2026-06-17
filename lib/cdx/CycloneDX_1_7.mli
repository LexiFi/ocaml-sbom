(* Auto-generated from "CycloneDX_1_7.atd" by atdml. *)

(** Specifies the encoding the text is represented in. *)
type attachmentEncoding =
  | Base64

val attachmentEncoding_of_yojson : Yojson.Safe.t -> attachmentEncoding
val yojson_of_attachmentEncoding : attachmentEncoding -> Yojson.Safe.t
val attachmentEncoding_of_json : string -> attachmentEncoding
val json_of_attachmentEncoding : attachmentEncoding -> string

module AttachmentEncoding : sig
  type nonrec t = attachmentEncoding
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  encoding: attachmentEncoding option;  (** Specifies the encoding the text is represented in. *)
  content: string;
  (**
     The attachment data. Proactive controls such as input validation and
     sanitization should be employed to prevent misuse of attachment text.
  *)
}

val create_attachment : ?contentType:string -> ?encoding:attachmentEncoding -> content:string -> unit -> attachment
val attachment_of_yojson : Yojson.Safe.t -> attachment
val yojson_of_attachment : attachment -> Yojson.Safe.t
val attachment_of_json : string -> attachment
val json_of_attachment : attachment -> string

module Attachment : sig
  type nonrec t = attachment
  val create : ?contentType:string -> ?encoding:attachmentEncoding -> content:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Descriptor for another BOM document. See
   https://cyclonedx.org/capabilities/bomlink/
*)
type bomLinkDocumentType = private string

val create_bomLinkDocumentType : string -> bomLinkDocumentType
val bomLinkDocumentType_of_yojson : Yojson.Safe.t -> bomLinkDocumentType
val yojson_of_bomLinkDocumentType : bomLinkDocumentType -> Yojson.Safe.t
val bomLinkDocumentType_of_json : string -> bomLinkDocumentType
val json_of_bomLinkDocumentType : bomLinkDocumentType -> string

module BomLinkDocumentType : sig
  type nonrec t = bomLinkDocumentType
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Descriptor for an element in a BOM document. See
   https://cyclonedx.org/capabilities/bomlink/
*)
type bomLinkElementType = private string

val create_bomLinkElementType : string -> bomLinkElementType
val bomLinkElementType_of_yojson : Yojson.Safe.t -> bomLinkElementType
val yojson_of_bomLinkElementType : bomLinkElementType -> Yojson.Safe.t
val bomLinkElementType_of_json : string -> bomLinkElementType
val json_of_bomLinkElementType : bomLinkElementType -> string

module BomLinkElementType : sig
  type nonrec t = bomLinkElementType
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type bomLink =
  | BomLinkDocumentType of bomLinkDocumentType
  | BomLinkElementType of bomLinkElementType

val bomLink_of_yojson : Yojson.Safe.t -> bomLink
val yojson_of_bomLink : bomLink -> Yojson.Safe.t
val bomLink_of_json : string -> bomLink
val json_of_bomLink : bomLink -> string

module BomLink : sig
  type nonrec t = bomLink
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Unit of carbon dioxide (CO2). *)
type co2MeasureUnit =
  | TCO2eq

val co2MeasureUnit_of_yojson : Yojson.Safe.t -> co2MeasureUnit
val yojson_of_co2MeasureUnit : co2MeasureUnit -> Yojson.Safe.t
val co2MeasureUnit_of_json : string -> co2MeasureUnit
val json_of_co2MeasureUnit : co2MeasureUnit -> string

module Co2MeasureUnit : sig
  type nonrec t = co2MeasureUnit
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A measure of carbon dioxide (CO2). *)
type co2Measure = {
  value: float;  (** Quantity of carbon dioxide (CO2). *)
  unit: co2MeasureUnit;  (** Unit of carbon dioxide (CO2). *)
}

val create_co2Measure : value:float -> unit:co2MeasureUnit -> unit -> co2Measure
val co2Measure_of_yojson : Yojson.Safe.t -> co2Measure
val yojson_of_co2Measure : co2Measure -> Yojson.Safe.t
val co2Measure_of_json : string -> co2Measure
val json_of_co2Measure : co2Measure -> string

module Co2Measure : sig
  type nonrec t = co2Measure
  val create : value:float -> unit:co2MeasureUnit -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The general theme or subject matter of the data being specified. *)
type componentDataType =
  | Sourcecode
  | Configuration
  | Dataset
  | Definition
  | Other

val componentDataType_of_yojson : Yojson.Safe.t -> componentDataType
val yojson_of_componentDataType : componentDataType -> Yojson.Safe.t
val componentDataType_of_json : string -> componentDataType
val json_of_componentDataType : componentDataType -> string

module ComponentDataType : sig
  type nonrec t = componentDataType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type componentEvidenceCallstackFrames = {
  package: string option;
  (**
     A package organizes modules into namespaces, providing a unique
     namespace for each type it contains.
  *)
  module_: string;  (** A module or class that encloses functions/methods and other code. *)
  function_: string option;  (** A block of code designed to perform a particular task. *)
  parameters: string list option;  (** Arguments that are passed to the module or function. *)
  line: int option;  (** The line number the code that is called resides on. *)
  column: int option;  (** The column the code that is called resides. *)
  fullFilename: string option;  (** The full path and filename of the module. *)
}

val create_componentEvidenceCallstackFrames : ?package:string -> module_:string -> ?function_:string -> ?parameters:string list -> ?line:int -> ?column:int -> ?fullFilename:string -> unit -> componentEvidenceCallstackFrames
val componentEvidenceCallstackFrames_of_yojson : Yojson.Safe.t -> componentEvidenceCallstackFrames
val yojson_of_componentEvidenceCallstackFrames : componentEvidenceCallstackFrames -> Yojson.Safe.t
val componentEvidenceCallstackFrames_of_json : string -> componentEvidenceCallstackFrames
val json_of_componentEvidenceCallstackFrames : componentEvidenceCallstackFrames -> string

module ComponentEvidenceCallstackFrames : sig
  type nonrec t = componentEvidenceCallstackFrames
  val create : ?package:string -> module_:string -> ?function_:string -> ?parameters:string list -> ?line:int -> ?column:int -> ?fullFilename:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_componentEvidenceCallstack : ?frames:componentEvidenceCallstackFrames list -> unit -> componentEvidenceCallstack
val componentEvidenceCallstack_of_yojson : Yojson.Safe.t -> componentEvidenceCallstack
val yojson_of_componentEvidenceCallstack : componentEvidenceCallstack -> Yojson.Safe.t
val componentEvidenceCallstack_of_json : string -> componentEvidenceCallstack
val json_of_componentEvidenceCallstack : componentEvidenceCallstack -> string

module ComponentEvidenceCallstack : sig
  type nonrec t = componentEvidenceCallstack
  val create : ?frames:componentEvidenceCallstackFrames list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val componentIdentityEvidenceField_of_yojson : Yojson.Safe.t -> componentIdentityEvidenceField
val yojson_of_componentIdentityEvidenceField : componentIdentityEvidenceField -> Yojson.Safe.t
val componentIdentityEvidenceField_of_json : string -> componentIdentityEvidenceField
val json_of_componentIdentityEvidenceField : componentIdentityEvidenceField -> string

module ComponentIdentityEvidenceField : sig
  type nonrec t = componentIdentityEvidenceField
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val componentIdentityEvidenceMethodsTechnique_of_yojson : Yojson.Safe.t -> componentIdentityEvidenceMethodsTechnique
val yojson_of_componentIdentityEvidenceMethodsTechnique : componentIdentityEvidenceMethodsTechnique -> Yojson.Safe.t
val componentIdentityEvidenceMethodsTechnique_of_json : string -> componentIdentityEvidenceMethodsTechnique
val json_of_componentIdentityEvidenceMethodsTechnique : componentIdentityEvidenceMethodsTechnique -> string

module ComponentIdentityEvidenceMethodsTechnique : sig
  type nonrec t = componentIdentityEvidenceMethodsTechnique
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_componentIdentityEvidenceMethods : technique:componentIdentityEvidenceMethodsTechnique -> confidence:float -> ?value:string -> unit -> componentIdentityEvidenceMethods
val componentIdentityEvidenceMethods_of_yojson : Yojson.Safe.t -> componentIdentityEvidenceMethods
val yojson_of_componentIdentityEvidenceMethods : componentIdentityEvidenceMethods -> Yojson.Safe.t
val componentIdentityEvidenceMethods_of_json : string -> componentIdentityEvidenceMethods
val json_of_componentIdentityEvidenceMethods : componentIdentityEvidenceMethods -> string

module ComponentIdentityEvidenceMethods : sig
  type nonrec t = componentIdentityEvidenceMethods
  val create : technique:componentIdentityEvidenceMethodsTechnique -> confidence:float -> ?value:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Specifies the scope of the component. If scope is not specified,
   'required' scope SHOULD be assumed by the consumer of the BOM.
*)
type componentScope =
  | Required
  | Optional
  | Excluded

val componentScope_of_yojson : Yojson.Safe.t -> componentScope
val yojson_of_componentScope : componentScope -> Yojson.Safe.t
val componentScope_of_json : string -> componentScope
val json_of_componentScope : componentScope -> string

module ComponentScope : sig
  type nonrec t = componentScope
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val componentType_of_yojson : Yojson.Safe.t -> componentType
val yojson_of_componentType : componentType -> Yojson.Safe.t
val componentType_of_json : string -> componentType
val json_of_componentType : componentType -> string

module ComponentType : sig
  type nonrec t = componentType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   A copyright notice informing users of the underlying claims to
   copyright ownership in a published work.
*)
type copyright = {
  text: string;  (** The textual content of the copyright. *)
}

val create_copyright : text:string -> unit -> copyright
val copyright_of_yojson : Yojson.Safe.t -> copyright
val yojson_of_copyright : copyright -> Yojson.Safe.t
val copyright_of_json : string -> copyright
val json_of_copyright : copyright -> string

module Copyright : sig
  type nonrec t = copyright
  val create : text:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmPropertiesCertificationLevel
val yojson_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel : cryptoPropertiesAlgorithmPropertiesCertificationLevel -> Yojson.Safe.t
val cryptoPropertiesAlgorithmPropertiesCertificationLevel_of_json : string -> cryptoPropertiesAlgorithmPropertiesCertificationLevel
val json_of_cryptoPropertiesAlgorithmPropertiesCertificationLevel : cryptoPropertiesAlgorithmPropertiesCertificationLevel -> string

module CryptoPropertiesAlgorithmPropertiesCertificationLevel : sig
  type nonrec t = cryptoPropertiesAlgorithmPropertiesCertificationLevel
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmPropertiesCryptoFunctions
val yojson_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions : cryptoPropertiesAlgorithmPropertiesCryptoFunctions -> Yojson.Safe.t
val cryptoPropertiesAlgorithmPropertiesCryptoFunctions_of_json : string -> cryptoPropertiesAlgorithmPropertiesCryptoFunctions
val json_of_cryptoPropertiesAlgorithmPropertiesCryptoFunctions : cryptoPropertiesAlgorithmPropertiesCryptoFunctions -> string

module CryptoPropertiesAlgorithmPropertiesCryptoFunctions : sig
  type nonrec t = cryptoPropertiesAlgorithmPropertiesCryptoFunctions
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmPropertiesExecutionEnvironment
val yojson_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment : cryptoPropertiesAlgorithmPropertiesExecutionEnvironment -> Yojson.Safe.t
val cryptoPropertiesAlgorithmPropertiesExecutionEnvironment_of_json : string -> cryptoPropertiesAlgorithmPropertiesExecutionEnvironment
val json_of_cryptoPropertiesAlgorithmPropertiesExecutionEnvironment : cryptoPropertiesAlgorithmPropertiesExecutionEnvironment -> string

module CryptoPropertiesAlgorithmPropertiesExecutionEnvironment : sig
  type nonrec t = cryptoPropertiesAlgorithmPropertiesExecutionEnvironment
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmPropertiesImplementationPlatform
val yojson_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform : cryptoPropertiesAlgorithmPropertiesImplementationPlatform -> Yojson.Safe.t
val cryptoPropertiesAlgorithmPropertiesImplementationPlatform_of_json : string -> cryptoPropertiesAlgorithmPropertiesImplementationPlatform
val json_of_cryptoPropertiesAlgorithmPropertiesImplementationPlatform : cryptoPropertiesAlgorithmPropertiesImplementationPlatform -> string

module CryptoPropertiesAlgorithmPropertiesImplementationPlatform : sig
  type nonrec t = cryptoPropertiesAlgorithmPropertiesImplementationPlatform
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesAlgorithmPropertiesMode_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmPropertiesMode
val yojson_of_cryptoPropertiesAlgorithmPropertiesMode : cryptoPropertiesAlgorithmPropertiesMode -> Yojson.Safe.t
val cryptoPropertiesAlgorithmPropertiesMode_of_json : string -> cryptoPropertiesAlgorithmPropertiesMode
val json_of_cryptoPropertiesAlgorithmPropertiesMode : cryptoPropertiesAlgorithmPropertiesMode -> string

module CryptoPropertiesAlgorithmPropertiesMode : sig
  type nonrec t = cryptoPropertiesAlgorithmPropertiesMode
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesAlgorithmPropertiesPadding_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmPropertiesPadding
val yojson_of_cryptoPropertiesAlgorithmPropertiesPadding : cryptoPropertiesAlgorithmPropertiesPadding -> Yojson.Safe.t
val cryptoPropertiesAlgorithmPropertiesPadding_of_json : string -> cryptoPropertiesAlgorithmPropertiesPadding
val json_of_cryptoPropertiesAlgorithmPropertiesPadding : cryptoPropertiesAlgorithmPropertiesPadding -> string

module CryptoPropertiesAlgorithmPropertiesPadding : sig
  type nonrec t = cryptoPropertiesAlgorithmPropertiesPadding
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  | Keywrap
  | Other
  | Unknown

val cryptoPropertiesAlgorithmPropertiesPrimitive_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmPropertiesPrimitive
val yojson_of_cryptoPropertiesAlgorithmPropertiesPrimitive : cryptoPropertiesAlgorithmPropertiesPrimitive -> Yojson.Safe.t
val cryptoPropertiesAlgorithmPropertiesPrimitive_of_json : string -> cryptoPropertiesAlgorithmPropertiesPrimitive
val json_of_cryptoPropertiesAlgorithmPropertiesPrimitive : cryptoPropertiesAlgorithmPropertiesPrimitive -> string

module CryptoPropertiesAlgorithmPropertiesPrimitive : sig
  type nonrec t = cryptoPropertiesAlgorithmPropertiesPrimitive
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesAssetType_of_yojson : Yojson.Safe.t -> cryptoPropertiesAssetType
val yojson_of_cryptoPropertiesAssetType : cryptoPropertiesAssetType -> Yojson.Safe.t
val cryptoPropertiesAssetType_of_json : string -> cryptoPropertiesAssetType
val json_of_cryptoPropertiesAssetType : cryptoPropertiesAssetType -> string

module CryptoPropertiesAssetType : sig
  type nonrec t = cryptoPropertiesAssetType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The concrete protocol type. *)
type cryptoPropertiesProtocolPropertiesType =
  | Tls
  | Ssh
  | Ipsec
  | Ike
  | Sstp
  | Wpa
  | Dtls
  | Quic
  | Eapaka
  | Eapakaprime
  | Prins
  | N_5gaka
  | Other
  | Unknown

val cryptoPropertiesProtocolPropertiesType_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolPropertiesType
val yojson_of_cryptoPropertiesProtocolPropertiesType : cryptoPropertiesProtocolPropertiesType -> Yojson.Safe.t
val cryptoPropertiesProtocolPropertiesType_of_json : string -> cryptoPropertiesProtocolPropertiesType
val json_of_cryptoPropertiesProtocolPropertiesType : cryptoPropertiesProtocolPropertiesType -> string

module CryptoPropertiesProtocolPropertiesType : sig
  type nonrec t = cryptoPropertiesProtocolPropertiesType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The key state as defined by NIST SP 800-57. *)
type cryptoPropertiesRelatedCryptoMaterialPropertiesState =
  | Preactivation
  | Active
  | Suspended
  | Deactivated
  | Compromised
  | Destroyed

val cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_yojson : Yojson.Safe.t -> cryptoPropertiesRelatedCryptoMaterialPropertiesState
val yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState : cryptoPropertiesRelatedCryptoMaterialPropertiesState -> Yojson.Safe.t
val cryptoPropertiesRelatedCryptoMaterialPropertiesState_of_json : string -> cryptoPropertiesRelatedCryptoMaterialPropertiesState
val json_of_cryptoPropertiesRelatedCryptoMaterialPropertiesState : cryptoPropertiesRelatedCryptoMaterialPropertiesState -> string

module CryptoPropertiesRelatedCryptoMaterialPropertiesState : sig
  type nonrec t = cryptoPropertiesRelatedCryptoMaterialPropertiesState
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_yojson : Yojson.Safe.t -> cryptoPropertiesRelatedCryptoMaterialPropertiesType
val yojson_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType : cryptoPropertiesRelatedCryptoMaterialPropertiesType -> Yojson.Safe.t
val cryptoPropertiesRelatedCryptoMaterialPropertiesType_of_json : string -> cryptoPropertiesRelatedCryptoMaterialPropertiesType
val json_of_cryptoPropertiesRelatedCryptoMaterialPropertiesType : cryptoPropertiesRelatedCryptoMaterialPropertiesType -> string

module CryptoPropertiesRelatedCryptoMaterialPropertiesType : sig
  type nonrec t = cryptoPropertiesRelatedCryptoMaterialPropertiesType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Data classification tags data according to its type, sensitivity, and
   value if altered, stolen, or destroyed.
*)
type dataClassification = private string

val create_dataClassification : string -> dataClassification
val dataClassification_of_yojson : Yojson.Safe.t -> dataClassification
val yojson_of_dataClassification : dataClassification -> Yojson.Safe.t
val dataClassification_of_json : string -> dataClassification
val json_of_dataClassification : dataClassification -> string

module DataClassification : sig
  type nonrec t = dataClassification
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val dataFlowDirection_of_yojson : Yojson.Safe.t -> dataFlowDirection
val yojson_of_dataFlowDirection : dataFlowDirection -> Yojson.Safe.t
val dataFlowDirection_of_json : string -> dataFlowDirection
val json_of_dataFlowDirection : dataFlowDirection -> string

module DataFlowDirection : sig
  type nonrec t = dataFlowDirection
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The patch file (or diff) that shows changes. Refer to
   https://en.wikipedia.org/wiki/Diff
*)
type diff = {
  text: attachment option;
  url: string option;  (** Specifies the URL to the diff *)
}

val create_diff : ?text:attachment -> ?url:string -> unit -> diff
val diff_of_yojson : Yojson.Safe.t -> diff
val yojson_of_diff : diff -> Yojson.Safe.t
val diff_of_json : string -> diff
val json_of_diff : diff -> string

module Diff : sig
  type nonrec t = diff
  val create : ?text:attachment -> ?url:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val energyConsumptionActivity_of_yojson : Yojson.Safe.t -> energyConsumptionActivity
val yojson_of_energyConsumptionActivity : energyConsumptionActivity -> Yojson.Safe.t
val energyConsumptionActivity_of_json : string -> energyConsumptionActivity
val json_of_energyConsumptionActivity : energyConsumptionActivity -> string

module EnergyConsumptionActivity : sig
  type nonrec t = energyConsumptionActivity
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Unit of energy. *)
type energyMeasureUnit =
  | KWh

val energyMeasureUnit_of_yojson : Yojson.Safe.t -> energyMeasureUnit
val yojson_of_energyMeasureUnit : energyMeasureUnit -> Yojson.Safe.t
val energyMeasureUnit_of_json : string -> energyMeasureUnit
val json_of_energyMeasureUnit : energyMeasureUnit -> string

module EnergyMeasureUnit : sig
  type nonrec t = energyMeasureUnit
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A measure of energy. *)
type energyMeasure = {
  value: float;  (** Quantity of energy. *)
  unit: energyMeasureUnit;  (** Unit of energy. *)
}

val create_energyMeasure : value:float -> unit:energyMeasureUnit -> unit -> energyMeasure
val energyMeasure_of_yojson : Yojson.Safe.t -> energyMeasure
val yojson_of_energyMeasure : energyMeasure -> Yojson.Safe.t
val energyMeasure_of_json : string -> energyMeasure
val json_of_energyMeasure : energyMeasure -> string

module EnergyMeasure : sig
  type nonrec t = energyMeasure
  val create : value:float -> unit:energyMeasureUnit -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val energyProviderEnergySource_of_yojson : Yojson.Safe.t -> energyProviderEnergySource
val yojson_of_energyProviderEnergySource : energyProviderEnergySource -> Yojson.Safe.t
val energyProviderEnergySource_of_json : string -> energyProviderEnergySource
val json_of_energyProviderEnergySource : energyProviderEnergySource -> string

module EnergyProviderEnergySource : sig
  type nonrec t = energyProviderEnergySource
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  | Patent
  | Patentfamily
  | Patentassertion
  | Citation
  | Other

val externalReferenceType_of_yojson : Yojson.Safe.t -> externalReferenceType
val yojson_of_externalReferenceType : externalReferenceType -> Yojson.Safe.t
val externalReferenceType_of_json : string -> externalReferenceType
val json_of_externalReferenceType : externalReferenceType -> string

module ExternalReferenceType : sig
  type nonrec t = externalReferenceType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val externalReferenceUrl_of_yojson : Yojson.Safe.t -> externalReferenceUrl
val yojson_of_externalReferenceUrl : externalReferenceUrl -> Yojson.Safe.t
val externalReferenceUrl_of_json : string -> externalReferenceUrl
val json_of_externalReferenceUrl : externalReferenceUrl -> string

module ExternalReferenceUrl : sig
  type nonrec t = externalReferenceUrl
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_fairnessAssessment : ?groupAtRisk:string -> ?benefits:string -> ?harms:string -> ?mitigationStrategy:string -> unit -> fairnessAssessment
val fairnessAssessment_of_yojson : Yojson.Safe.t -> fairnessAssessment
val yojson_of_fairnessAssessment : fairnessAssessment -> Yojson.Safe.t
val fairnessAssessment_of_json : string -> fairnessAssessment
val json_of_fairnessAssessment : fairnessAssessment -> string

module FairnessAssessment : sig
  type nonrec t = fairnessAssessment
  val create : ?groupAtRisk:string -> ?benefits:string -> ?harms:string -> ?mitigationStrategy:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type graphic = {
  name: string option;  (** The name of the graphic. *)
  image: attachment option;
}

val create_graphic : ?name:string -> ?image:attachment -> unit -> graphic
val graphic_of_yojson : Yojson.Safe.t -> graphic
val yojson_of_graphic : graphic -> Yojson.Safe.t
val graphic_of_json : string -> graphic
val json_of_graphic : graphic -> string

module Graphic : sig
  type nonrec t = graphic
  val create : ?name:string -> ?image:attachment -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A collection of graphics that represent various measurements. *)
type graphicsCollection = {
  description: string option;  (** A description of this collection of graphics. *)
  collection: graphic list option;  (** A collection of graphics. *)
}

val create_graphicsCollection : ?description:string -> ?collection:graphic list -> unit -> graphicsCollection
val graphicsCollection_of_yojson : Yojson.Safe.t -> graphicsCollection
val yojson_of_graphicsCollection : graphicsCollection -> Yojson.Safe.t
val graphicsCollection_of_json : string -> graphicsCollection
val json_of_graphicsCollection : graphicsCollection -> string

module GraphicsCollection : sig
  type nonrec t = graphicsCollection
  val create : ?description:string -> ?collection:graphic list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  | Streebog256
  | Streebog512

val hashalg_of_yojson : Yojson.Safe.t -> hashalg
val yojson_of_hashalg : hashalg -> Yojson.Safe.t
val hashalg_of_json : string -> hashalg
val json_of_hashalg : hashalg -> string

module Hashalg : sig
  type nonrec t = hashalg
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The value of the hash. *)
type hashcontent = private string

val create_hashcontent : string -> hashcontent
val hashcontent_of_yojson : Yojson.Safe.t -> hashcontent
val yojson_of_hashcontent : hashcontent -> Yojson.Safe.t
val hashcontent_of_json : string -> hashcontent
val json_of_hashcontent : hashcontent -> string

module Hashcontent : sig
  type nonrec t = hashcontent
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type hash = {
  alg: hashalg;
  content: hashcontent;
}

val create_hash : alg:hashalg -> content:hashcontent -> unit -> hash
val hash_of_yojson : Yojson.Safe.t -> hash
val yojson_of_hash : hash -> Yojson.Safe.t
val hash_of_json : string -> hash
val json_of_hash : hash -> string

module Hash : sig
  type nonrec t = hash
  val create : alg:hashalg -> content:hashcontent -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Specifies an individual commit *)
type identifiableAction = {
  timestamp: string option;  (** The timestamp in which the action occurred *)
  name: string option;  (** The name of the individual who performed the action *)
  email: string option;  (** The email address of the individual who performed the action *)
}

val create_identifiableAction : ?timestamp:string -> ?name:string -> ?email:string -> unit -> identifiableAction
val identifiableAction_of_yojson : Yojson.Safe.t -> identifiableAction
val yojson_of_identifiableAction : identifiableAction -> Yojson.Safe.t
val identifiableAction_of_json : string -> identifiableAction
val json_of_identifiableAction : identifiableAction -> string

module IdentifiableAction : sig
  type nonrec t = identifiableAction
  val create : ?timestamp:string -> ?name:string -> ?email:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_commit : ?uid:string -> ?url:string -> ?author:identifiableAction -> ?committer:identifiableAction -> ?message:string -> unit -> commit
val commit_of_yojson : Yojson.Safe.t -> commit
val yojson_of_commit : commit -> Yojson.Safe.t
val commit_of_json : string -> commit
val json_of_commit : commit -> string

module Commit : sig
  type nonrec t = commit
  val create : ?uid:string -> ?url:string -> ?author:identifiableAction -> ?committer:identifiableAction -> ?message:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type inputOutputMLParameters = {
  format: string option;  (** The data format for input/output to the model. *)
}

val create_inputOutputMLParameters : ?format:string -> unit -> inputOutputMLParameters
val inputOutputMLParameters_of_yojson : Yojson.Safe.t -> inputOutputMLParameters
val yojson_of_inputOutputMLParameters : inputOutputMLParameters -> Yojson.Safe.t
val inputOutputMLParameters_of_json : string -> inputOutputMLParameters
val json_of_inputOutputMLParameters : inputOutputMLParameters -> string

module InputOutputMLParameters : sig
  type nonrec t = inputOutputMLParameters
  val create : ?format:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The source of the issue where it is documented *)
type issueSource = {
  name: string option;  (** The name of the source. *)
  url: string option;  (** The url of the issue documentation as provided by the source *)
}

val create_issueSource : ?name:string -> ?url:string -> unit -> issueSource
val issueSource_of_yojson : Yojson.Safe.t -> issueSource
val yojson_of_issueSource : issueSource -> Yojson.Safe.t
val issueSource_of_json : string -> issueSource
val json_of_issueSource : issueSource -> string

module IssueSource : sig
  type nonrec t = issueSource
  val create : ?name:string -> ?url:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Specifies the type of issue *)
type issueType =
  | Defect
  | Enhancement
  | Security

val issueType_of_yojson : Yojson.Safe.t -> issueType
val yojson_of_issueType : issueType -> Yojson.Safe.t
val issueType_of_json : string -> issueType
val json_of_issueType : issueType -> string

module IssueType : sig
  type nonrec t = issueType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_issue : type_:issueType -> ?id:string -> ?name:string -> ?description:string -> ?source:issueSource -> ?references:string list -> unit -> issue
val issue_of_yojson : Yojson.Safe.t -> issue
val yojson_of_issue : issue -> Yojson.Safe.t
val issue_of_json : string -> issue
val json_of_issue : issue -> string

module Issue : sig
  type nonrec t = issue
  val create : type_:issueType -> ?id:string -> ?name:string -> ?description:string -> ?source:issueSource -> ?references:string list -> unit -> t
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
  algorithmFamily: json_ option;
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
     \[Deprecated\] This will be removed in a future version. Use
     `\@.ellipticCurve` instead. The specific underlying Elliptic Curve
     (EC) definition employed which is an indicator of the level of
     security strength, performance and complexity. Absent an authoritative
     source of curve names, CycloneDX recommends using curve names as
     defined at
     \[https://neuromancer.sk/std/\](https://neuromancer.sk/std/), the
     source of which can be found at
     \[https://github.com/J08nY/std-curves\](https://github.com/J08nY/std-curves).
  *)
  ellipticCurve: json_ option;
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

val create_cryptoPropertiesAlgorithmProperties : ?primitive:cryptoPropertiesAlgorithmPropertiesPrimitive -> ?algorithmFamily:json_ -> ?parameterSetIdentifier:string -> ?curve:string -> ?ellipticCurve:json_ -> ?executionEnvironment:cryptoPropertiesAlgorithmPropertiesExecutionEnvironment -> ?implementationPlatform:cryptoPropertiesAlgorithmPropertiesImplementationPlatform -> ?certificationLevel:cryptoPropertiesAlgorithmPropertiesCertificationLevel list -> ?mode:cryptoPropertiesAlgorithmPropertiesMode -> ?padding:cryptoPropertiesAlgorithmPropertiesPadding -> ?cryptoFunctions:cryptoPropertiesAlgorithmPropertiesCryptoFunctions list -> ?classicalSecurityLevel:int -> ?nistQuantumSecurityLevel:int -> unit -> cryptoPropertiesAlgorithmProperties
val cryptoPropertiesAlgorithmProperties_of_yojson : Yojson.Safe.t -> cryptoPropertiesAlgorithmProperties
val yojson_of_cryptoPropertiesAlgorithmProperties : cryptoPropertiesAlgorithmProperties -> Yojson.Safe.t
val cryptoPropertiesAlgorithmProperties_of_json : string -> cryptoPropertiesAlgorithmProperties
val json_of_cryptoPropertiesAlgorithmProperties : cryptoPropertiesAlgorithmProperties -> string

module CryptoPropertiesAlgorithmProperties : sig
  type nonrec t = cryptoPropertiesAlgorithmProperties
  val create : ?primitive:cryptoPropertiesAlgorithmPropertiesPrimitive -> ?algorithmFamily:json_ -> ?parameterSetIdentifier:string -> ?curve:string -> ?ellipticCurve:json_ -> ?executionEnvironment:cryptoPropertiesAlgorithmPropertiesExecutionEnvironment -> ?implementationPlatform:cryptoPropertiesAlgorithmPropertiesImplementationPlatform -> ?certificationLevel:cryptoPropertiesAlgorithmPropertiesCertificationLevel list -> ?mode:cryptoPropertiesAlgorithmPropertiesMode -> ?padding:cryptoPropertiesAlgorithmPropertiesPadding -> ?cryptoFunctions:cryptoPropertiesAlgorithmPropertiesCryptoFunctions list -> ?classicalSecurityLevel:int -> ?nistQuantumSecurityLevel:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type cryptoPropertiesCertificatePropertiesCertificateExtensions =
  | JsoncryptoPropertiescertificatePropertiescertificateExtensions_1 of json_
  | JsoncryptoPropertiescertificatePropertiescertificateExtensions_2 of json_

val cryptoPropertiesCertificatePropertiesCertificateExtensions_of_yojson : Yojson.Safe.t -> cryptoPropertiesCertificatePropertiesCertificateExtensions
val yojson_of_cryptoPropertiesCertificatePropertiesCertificateExtensions : cryptoPropertiesCertificatePropertiesCertificateExtensions -> Yojson.Safe.t
val cryptoPropertiesCertificatePropertiesCertificateExtensions_of_json : string -> cryptoPropertiesCertificatePropertiesCertificateExtensions
val json_of_cryptoPropertiesCertificatePropertiesCertificateExtensions : cryptoPropertiesCertificatePropertiesCertificateExtensions -> string

module CryptoPropertiesCertificatePropertiesCertificateExtensions : sig
  type nonrec t = cryptoPropertiesCertificatePropertiesCertificateExtensions
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The state of the certificate. *)
type cryptoPropertiesCertificatePropertiesCertificateState =
  | JsoncryptoPropertiescertificatePropertiescertificateState_1 of json_
  | JsoncryptoPropertiescertificatePropertiescertificateState_2 of json_

val cryptoPropertiesCertificatePropertiesCertificateState_of_yojson : Yojson.Safe.t -> cryptoPropertiesCertificatePropertiesCertificateState
val yojson_of_cryptoPropertiesCertificatePropertiesCertificateState : cryptoPropertiesCertificatePropertiesCertificateState -> Yojson.Safe.t
val cryptoPropertiesCertificatePropertiesCertificateState_of_json : string -> cryptoPropertiesCertificatePropertiesCertificateState
val json_of_cryptoPropertiesCertificatePropertiesCertificateState : cryptoPropertiesCertificatePropertiesCertificateState -> string

module CryptoPropertiesCertificatePropertiesCertificateState : sig
  type nonrec t = cryptoPropertiesCertificatePropertiesCertificateState
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type dataGovernanceResponsibleParty =
  | JsondataGovernanceResponsibleParty_1 of json_
  | JsondataGovernanceResponsibleParty_2 of json_

val dataGovernanceResponsibleParty_of_yojson : Yojson.Safe.t -> dataGovernanceResponsibleParty
val yojson_of_dataGovernanceResponsibleParty : dataGovernanceResponsibleParty -> Yojson.Safe.t
val dataGovernanceResponsibleParty_of_json : string -> dataGovernanceResponsibleParty
val json_of_dataGovernanceResponsibleParty : dataGovernanceResponsibleParty -> string

module DataGovernanceResponsibleParty : sig
  type nonrec t = dataGovernanceResponsibleParty
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_dataGovernance : ?custodians:dataGovernanceResponsibleParty list -> ?stewards:dataGovernanceResponsibleParty list -> ?owners:dataGovernanceResponsibleParty list -> unit -> dataGovernance
val dataGovernance_of_yojson : Yojson.Safe.t -> dataGovernance
val yojson_of_dataGovernance : dataGovernance -> Yojson.Safe.t
val dataGovernance_of_json : string -> dataGovernance
val json_of_dataGovernance : dataGovernance -> string

module DataGovernance : sig
  type nonrec t = dataGovernance
  val create : ?custodians:dataGovernanceResponsibleParty list -> ?stewards:dataGovernanceResponsibleParty list -> ?owners:dataGovernanceResponsibleParty list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val license_of_yojson : Yojson.Safe.t -> license
val yojson_of_license : license -> Yojson.Safe.t
val license_of_json : string -> license
val json_of_license : license -> string

module License : sig
  type nonrec t = license
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val licenseAcknowledgementEnumeration_of_yojson : Yojson.Safe.t -> licenseAcknowledgementEnumeration
val yojson_of_licenseAcknowledgementEnumeration : licenseAcknowledgementEnumeration -> Yojson.Safe.t
val licenseAcknowledgementEnumeration_of_json : string -> licenseAcknowledgementEnumeration
val json_of_licenseAcknowledgementEnumeration : licenseAcknowledgementEnumeration -> string

module LicenseAcknowledgementEnumeration : sig
  type nonrec t = licenseAcknowledgementEnumeration
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type licenseChoiceItemsLicense = {
  license: license;
}

val create_licenseChoiceItemsLicense : license:license -> unit -> licenseChoiceItemsLicense
val licenseChoiceItemsLicense_of_yojson : Yojson.Safe.t -> licenseChoiceItemsLicense
val yojson_of_licenseChoiceItemsLicense : licenseChoiceItemsLicense -> Yojson.Safe.t
val licenseChoiceItemsLicense_of_json : string -> licenseChoiceItemsLicense
val json_of_licenseChoiceItemsLicense : licenseChoiceItemsLicense -> string

module LicenseChoiceItemsLicense : sig
  type nonrec t = licenseChoiceItemsLicense
  val create : license:license -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type licensingLicenseTypes =
  | Academic
  | Appliance
  | Clientaccess
  | Concurrentuser
  | Corepoints
  | Custommetric
  | Device
  | Evaluation
  | Nameduser
  | Nodelocked
  | Oem
  | Perpetual
  | Processorpoints
  | Subscription
  | User
  | Other

val licensingLicenseTypes_of_yojson : Yojson.Safe.t -> licensingLicenseTypes
val yojson_of_licensingLicenseTypes : licensingLicenseTypes -> Yojson.Safe.t
val licensingLicenseTypes_of_json : string -> licensingLicenseTypes
val json_of_licensingLicenseTypes : licensingLicenseTypes -> string

module LicensingLicenseTypes : sig
  type nonrec t = licensingLicenseTypes
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The individual or organization for which a license was granted to *)
type licensingLicensee =
  | Jsonlicensinglicensee_1 of json_
  | Jsonlicensinglicensee_2 of json_

val licensingLicensee_of_yojson : Yojson.Safe.t -> licensingLicensee
val yojson_of_licensingLicensee : licensingLicensee -> Yojson.Safe.t
val licensingLicensee_of_json : string -> licensingLicensee
val json_of_licensingLicensee : licensingLicensee -> string

module LicensingLicensee : sig
  type nonrec t = licensingLicensee
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The individual or organization that grants a license to another
   individual or organization
*)
type licensingLicensor =
  | Jsonlicensinglicensor_1 of json_
  | Jsonlicensinglicensor_2 of json_

val licensingLicensor_of_yojson : Yojson.Safe.t -> licensingLicensor
val yojson_of_licensingLicensor : licensingLicensor -> Yojson.Safe.t
val licensingLicensor_of_json : string -> licensingLicensor
val json_of_licensingLicensor : licensingLicensor -> string

module LicensingLicensor : sig
  type nonrec t = licensingLicensor
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The individual or organization that purchased the license *)
type licensingPurchaser =
  | Jsonlicensingpurchaser_1 of json_
  | Jsonlicensingpurchaser_2 of json_

val licensingPurchaser_of_yojson : Yojson.Safe.t -> licensingPurchaser
val yojson_of_licensingPurchaser : licensingPurchaser -> Yojson.Safe.t
val licensingPurchaser_of_json : string -> licensingPurchaser
val json_of_licensingPurchaser : licensingPurchaser -> string

module LicensingPurchaser : sig
  type nonrec t = licensingPurchaser
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Licensing details describing the licensor/licensee, license type,
   renewal and expiration dates, and other important metadata
*)
type licensing = {
  altIds: string list option;
  (**
     License identifiers that may be used to manage licenses and their
     lifecycle
  *)
  licensor: licensingLicensor option;
  (**
     The individual or organization that grants a license to another
     individual or organization
  *)
  licensee: licensingLicensee option;  (** The individual or organization for which a license was granted to *)
  purchaser: licensingPurchaser option;  (** The individual or organization that purchased the license *)
  purchaseOrder: string option;
  (**
     The purchase order identifier the purchaser sent to a supplier or
     vendor to authorize a purchase
  *)
  licenseTypes: licensingLicenseTypes list option;  (** The type of license(s) that was granted to the licensee. *)
  lastRenewal: string option;
  (**
     The timestamp indicating when the license was last renewed. For new
     purchases, this is often the purchase or acquisition date. For
     non-perpetual licenses or subscriptions, this is the timestamp of when
     the license was last renewed.
  *)
  expiration: string option;
  (**
     The timestamp indicating when the current license expires (if
     applicable).
  *)
}

val create_licensing : ?altIds:string list -> ?licensor:licensingLicensor -> ?licensee:licensingLicensee -> ?purchaser:licensingPurchaser -> ?purchaseOrder:string -> ?licenseTypes:licensingLicenseTypes list -> ?lastRenewal:string -> ?expiration:string -> unit -> licensing
val licensing_of_yojson : Yojson.Safe.t -> licensing
val yojson_of_licensing : licensing -> Yojson.Safe.t
val licensing_of_json : string -> licensing
val json_of_licensing : licensing -> string

module Licensing : sig
  type nonrec t = licensing
  val create : ?altIds:string list -> ?licensor:licensingLicensor -> ?licensee:licensingLicensee -> ?purchaser:licensingPurchaser -> ?purchaseOrder:string -> ?licenseTypes:licensingLicenseTypes list -> ?lastRenewal:string -> ?expiration:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Defines a syntax for representing two character language code
   (ISO-639) followed by an optional two character country code. The
   language code must be lower case. If the country code is specified,
   the country code must be upper case. The language code and country
   code must be separated by a minus sign. Examples: en, en-US, fr, fr-CA
*)
type localeType = private string

val create_localeType : string -> localeType
val localeType_of_yojson : Yojson.Safe.t -> localeType
val yojson_of_localeType : localeType -> Yojson.Safe.t
val localeType_of_json : string -> localeType
val json_of_localeType : localeType -> string

module LocaleType : sig
  type nonrec t = localeType
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val modelCardModelParametersApproachType_of_yojson : Yojson.Safe.t -> modelCardModelParametersApproachType
val yojson_of_modelCardModelParametersApproachType : modelCardModelParametersApproachType -> Yojson.Safe.t
val modelCardModelParametersApproachType_of_json : string -> modelCardModelParametersApproachType
val json_of_modelCardModelParametersApproachType : modelCardModelParametersApproachType -> string

module ModelCardModelParametersApproachType : sig
  type nonrec t = modelCardModelParametersApproachType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_modelCardModelParametersApproach : ?type_:modelCardModelParametersApproachType -> unit -> modelCardModelParametersApproach
val modelCardModelParametersApproach_of_yojson : Yojson.Safe.t -> modelCardModelParametersApproach
val yojson_of_modelCardModelParametersApproach : modelCardModelParametersApproach -> Yojson.Safe.t
val modelCardModelParametersApproach_of_json : string -> modelCardModelParametersApproach
val json_of_modelCardModelParametersApproach : modelCardModelParametersApproach -> string

module ModelCardModelParametersApproach : sig
  type nonrec t = modelCardModelParametersApproach
  val create : ?type_:modelCardModelParametersApproachType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A note containing the locale and content. *)
type note = {
  locale: localeType option;
  text: attachment;
}

val create_note : ?locale:localeType -> text:attachment -> unit -> note
val note_of_yojson : Yojson.Safe.t -> note
val yojson_of_note : note -> Yojson.Safe.t
val note_of_json : string -> note
val json_of_note : note -> string

module Note : sig
  type nonrec t = note
  val create : ?locale:localeType -> text:attachment -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val patchType_of_yojson : Yojson.Safe.t -> patchType
val yojson_of_patchType : patchType -> Yojson.Safe.t
val patchType_of_json : string -> patchType
val json_of_patchType : patchType -> string

module PatchType : sig
  type nonrec t = patchType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_patch : type_:patchType -> ?diff:diff -> ?resolves:issue list -> unit -> patch
val patch_of_yojson : Yojson.Safe.t -> patch
val yojson_of_patch : patch -> Yojson.Safe.t
val patch_of_json : string -> patch
val json_of_patch : patch -> string

module Patch : sig
  type nonrec t = patch
  val create : type_:patchType -> ?diff:diff -> ?resolves:issue list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The type of assertion being made about the patent or patent family.
   Examples include ownership, licensing, and standards inclusion.
*)
type patentAssertionsItemsAssertionType =
  | Ownership
  | License
  | Thirdpartyclaim
  | Standardsinclusion
  | Priorart
  | Exclusiverights
  | Nonassertion
  | Researchorevaluation

val patentAssertionsItemsAssertionType_of_yojson : Yojson.Safe.t -> patentAssertionsItemsAssertionType
val yojson_of_patentAssertionsItemsAssertionType : patentAssertionsItemsAssertionType -> Yojson.Safe.t
val patentAssertionsItemsAssertionType_of_json : string -> patentAssertionsItemsAssertionType
val json_of_patentAssertionsItemsAssertionType : patentAssertionsItemsAssertionType -> string

module PatentAssertionsItemsAssertionType : sig
  type nonrec t = patentAssertionsItemsAssertionType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The confidence interval of the metric. *)
type performanceMetricConfidenceInterval = {
  lowerBound: string option;  (** The lower bound of the confidence interval. *)
  upperBound: string option;  (** The upper bound of the confidence interval. *)
}

val create_performanceMetricConfidenceInterval : ?lowerBound:string -> ?upperBound:string -> unit -> performanceMetricConfidenceInterval
val performanceMetricConfidenceInterval_of_yojson : Yojson.Safe.t -> performanceMetricConfidenceInterval
val yojson_of_performanceMetricConfidenceInterval : performanceMetricConfidenceInterval -> Yojson.Safe.t
val performanceMetricConfidenceInterval_of_json : string -> performanceMetricConfidenceInterval
val json_of_performanceMetricConfidenceInterval : performanceMetricConfidenceInterval -> string

module PerformanceMetricConfidenceInterval : sig
  type nonrec t = performanceMetricConfidenceInterval
  val create : ?lowerBound:string -> ?upperBound:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_performanceMetric : ?type_:string -> ?value:string -> ?slice:string -> ?confidenceInterval:performanceMetricConfidenceInterval -> unit -> performanceMetric
val performanceMetric_of_yojson : Yojson.Safe.t -> performanceMetric
val yojson_of_performanceMetric : performanceMetric -> Yojson.Safe.t
val performanceMetric_of_json : string -> performanceMetric
val json_of_performanceMetric : performanceMetric -> string

module PerformanceMetric : sig
  type nonrec t = performanceMetric
  val create : ?type_:string -> ?value:string -> ?slice:string -> ?confidenceInterval:performanceMetricConfidenceInterval -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_modelCardQuantitativeAnalysis : ?performanceMetrics:performanceMetric list -> ?graphics:graphicsCollection -> unit -> modelCardQuantitativeAnalysis
val modelCardQuantitativeAnalysis_of_yojson : Yojson.Safe.t -> modelCardQuantitativeAnalysis
val yojson_of_modelCardQuantitativeAnalysis : modelCardQuantitativeAnalysis -> Yojson.Safe.t
val modelCardQuantitativeAnalysis_of_json : string -> modelCardQuantitativeAnalysis
val json_of_modelCardQuantitativeAnalysis : modelCardQuantitativeAnalysis -> string

module ModelCardQuantitativeAnalysis : sig
  type nonrec t = modelCardQuantitativeAnalysis
  val create : ?performanceMetrics:performanceMetric list -> ?graphics:graphicsCollection -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_property : name:string -> ?value:string -> unit -> property
val property_of_yojson : Yojson.Safe.t -> property
val yojson_of_property : property -> Yojson.Safe.t
val property_of_json : string -> property
val json_of_property : property -> string

module Property : sig
  type nonrec t = property
  val create : name:string -> ?value:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_componentDataContents : ?attachment:attachment -> ?url:string -> ?properties:property list -> unit -> componentDataContents
val componentDataContents_of_yojson : Yojson.Safe.t -> componentDataContents
val yojson_of_componentDataContents : componentDataContents -> Yojson.Safe.t
val componentDataContents_of_json : string -> componentDataContents
val json_of_componentDataContents : componentDataContents -> string

module ComponentDataContents : sig
  type nonrec t = componentDataContents
  val create : ?attachment:attachment -> ?url:string -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  comment: string option;  (** A comment describing the external reference *)
  type_: externalReferenceType;  (** Specifies the type of external reference. *)
  hashes: hash list option;  (** The hashes of the external reference (if applicable). *)
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

val create_externalReference : url:externalReferenceUrl -> ?comment:string -> type_:externalReferenceType -> ?hashes:hash list -> ?properties:property list -> unit -> externalReference
val externalReference_of_yojson : Yojson.Safe.t -> externalReference
val yojson_of_externalReference : externalReference -> Yojson.Safe.t
val externalReference_of_json : string -> externalReference
val json_of_externalReference : externalReference -> string

module ExternalReference : sig
  type nonrec t = externalReference
  val create : url:externalReferenceUrl -> ?comment:string -> type_:externalReferenceType -> ?hashes:hash list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Descriptor for an element identified by the attribute 'bom-ref' in the
   same BOM document. In contrast to `bomLinkElementType`.
*)
type refLinkType = json_

val refLinkType_of_yojson : Yojson.Safe.t -> refLinkType
val yojson_of_refLinkType : refLinkType -> Yojson.Safe.t
val refLinkType_of_json : string -> refLinkType
val json_of_refLinkType : refLinkType -> string

module RefLinkType : sig
  type nonrec t = refLinkType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type componentIdentityEvidenceTools =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

val componentIdentityEvidenceTools_of_yojson : Yojson.Safe.t -> componentIdentityEvidenceTools
val yojson_of_componentIdentityEvidenceTools : componentIdentityEvidenceTools -> Yojson.Safe.t
val componentIdentityEvidenceTools_of_json : string -> componentIdentityEvidenceTools
val json_of_componentIdentityEvidenceTools : componentIdentityEvidenceTools -> string

module ComponentIdentityEvidenceTools : sig
  type nonrec t = componentIdentityEvidenceTools
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_componentIdentityEvidence : field:componentIdentityEvidenceField -> ?confidence:float -> ?concludedValue:string -> ?methods:componentIdentityEvidenceMethods list -> ?tools:componentIdentityEvidenceTools list -> unit -> componentIdentityEvidence
val componentIdentityEvidence_of_yojson : Yojson.Safe.t -> componentIdentityEvidence
val yojson_of_componentIdentityEvidence : componentIdentityEvidence -> Yojson.Safe.t
val componentIdentityEvidence_of_json : string -> componentIdentityEvidence
val json_of_componentIdentityEvidence : componentIdentityEvidence -> string

module ComponentIdentityEvidence : sig
  type nonrec t = componentIdentityEvidence
  val create : field:componentIdentityEvidenceField -> ?confidence:float -> ?concludedValue:string -> ?methods:componentIdentityEvidenceMethods list -> ?tools:componentIdentityEvidenceTools list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val componentEvidenceIdentity_of_yojson : Yojson.Safe.t -> componentEvidenceIdentity
val yojson_of_componentEvidenceIdentity : componentEvidenceIdentity -> Yojson.Safe.t
val componentEvidenceIdentity_of_json : string -> componentEvidenceIdentity
val json_of_componentEvidenceIdentity : componentEvidenceIdentity -> string

module ComponentEvidenceIdentity : sig
  type nonrec t = componentEvidenceIdentity
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** References a data component by the components bom-ref attribute *)
type modelCardModelParametersDatasetsDataReferenceRef =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

val modelCardModelParametersDatasetsDataReferenceRef_of_yojson : Yojson.Safe.t -> modelCardModelParametersDatasetsDataReferenceRef
val yojson_of_modelCardModelParametersDatasetsDataReferenceRef : modelCardModelParametersDatasetsDataReferenceRef -> Yojson.Safe.t
val modelCardModelParametersDatasetsDataReferenceRef_of_json : string -> modelCardModelParametersDatasetsDataReferenceRef
val json_of_modelCardModelParametersDatasetsDataReferenceRef : modelCardModelParametersDatasetsDataReferenceRef -> string

module ModelCardModelParametersDatasetsDataReferenceRef : sig
  type nonrec t = modelCardModelParametersDatasetsDataReferenceRef
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type modelCardModelParametersDatasetsDataReference = {
  ref: modelCardModelParametersDatasetsDataReferenceRef option;  (** References a data component by the components bom-ref attribute *)
}

val create_modelCardModelParametersDatasetsDataReference : ?ref:modelCardModelParametersDatasetsDataReferenceRef -> unit -> modelCardModelParametersDatasetsDataReference
val modelCardModelParametersDatasetsDataReference_of_yojson : Yojson.Safe.t -> modelCardModelParametersDatasetsDataReference
val yojson_of_modelCardModelParametersDatasetsDataReference : modelCardModelParametersDatasetsDataReference -> Yojson.Safe.t
val modelCardModelParametersDatasetsDataReference_of_json : string -> modelCardModelParametersDatasetsDataReference
val json_of_modelCardModelParametersDatasetsDataReference : modelCardModelParametersDatasetsDataReference -> string

module ModelCardModelParametersDatasetsDataReference : sig
  type nonrec t = modelCardModelParametersDatasetsDataReference
  val create : ?ref:modelCardModelParametersDatasetsDataReferenceRef -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Identifier for referable and therefore interlinkable elements. Value
   SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts
   with BOM-Links.
*)
type refType = private string

val create_refType : string -> refType
val refType_of_yojson : Yojson.Safe.t -> refType
val yojson_of_refType : refType -> Yojson.Safe.t
val refType_of_json : string -> refType
val json_of_refType : refType -> string

module RefType : sig
  type nonrec t = refType
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Object representing a cipher suite *)
type cipherSuite = {
  name: string option;  (** A common name for the cipher suite. *)
  algorithms: refType list option;  (** A list of algorithms related to the cipher suite. *)
  identifiers: string list option;  (** A list of common identifiers for the cipher suite. *)
  tlsGroups: string list option;
  (**
     A list of TLS named groups (formerly known as curves) for this cipher
     suite. These groups define the parameters for key exchange algorithms
     like ECDHE.
  *)
  tlsSignatureSchemes: string list option;
  (**
     A list of signature schemes supported for cipher suite. These schemes
     specify the algorithms used for digital signatures in TLS handshakes
     and certificate verification.
  *)
}

val create_cipherSuite : ?name:string -> ?algorithms:refType list -> ?identifiers:string list -> ?tlsGroups:string list -> ?tlsSignatureSchemes:string list -> unit -> cipherSuite
val cipherSuite_of_yojson : Yojson.Safe.t -> cipherSuite
val yojson_of_cipherSuite : cipherSuite -> Yojson.Safe.t
val cipherSuite_of_json : string -> cipherSuite
val json_of_cipherSuite : cipherSuite -> string

module CipherSuite : sig
  type nonrec t = cipherSuite
  val create : ?name:string -> ?algorithms:refType list -> ?identifiers:string list -> ?tlsGroups:string list -> ?tlsSignatureSchemes:string list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_componentData : ?bomref:refType -> type_:componentDataType -> ?name:string -> ?contents:componentDataContents -> ?classification:dataClassification -> ?sensitiveData:string list -> ?graphics:graphicsCollection -> ?description:string -> ?governance:dataGovernance -> unit -> componentData
val componentData_of_yojson : Yojson.Safe.t -> componentData
val yojson_of_componentData : componentData -> Yojson.Safe.t
val componentData_of_json : string -> componentData
val json_of_componentData : componentData -> string

module ComponentData : sig
  type nonrec t = componentData
  val create : ?bomref:refType -> type_:componentDataType -> ?name:string -> ?contents:componentDataContents -> ?classification:dataClassification -> ?sensitiveData:string list -> ?graphics:graphicsCollection -> ?description:string -> ?governance:dataGovernance -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_componentEvidenceOccurrences : ?bomref:refType -> location:string -> ?line:int -> ?offset:int -> ?symbol:string -> ?additionalContext:string -> unit -> componentEvidenceOccurrences
val componentEvidenceOccurrences_of_yojson : Yojson.Safe.t -> componentEvidenceOccurrences
val yojson_of_componentEvidenceOccurrences : componentEvidenceOccurrences -> Yojson.Safe.t
val componentEvidenceOccurrences_of_json : string -> componentEvidenceOccurrences
val json_of_componentEvidenceOccurrences : componentEvidenceOccurrences -> string

module ComponentEvidenceOccurrences : sig
  type nonrec t = componentEvidenceOccurrences
  val create : ?bomref:refType -> location:string -> ?line:int -> ?offset:int -> ?symbol:string -> ?additionalContext:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Deprecated definition. *)
type cryptoRefArray = refType list

val cryptoRefArray_of_yojson : Yojson.Safe.t -> cryptoRefArray
val yojson_of_cryptoRefArray : cryptoRefArray -> Yojson.Safe.t
val cryptoRefArray_of_json : string -> cryptoRefArray
val json_of_cryptoRefArray : cryptoRefArray -> string

module CryptoRefArray : sig
  type nonrec t = cryptoRefArray
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Object representing a IKEv2 Authentication method *)
type ikeV2Auth = {
  name: string option;  (** A name for the authentication method. *)
  algorithm: refType option;
}

val create_ikeV2Auth : ?name:string -> ?algorithm:refType -> unit -> ikeV2Auth
val ikeV2Auth_of_yojson : Yojson.Safe.t -> ikeV2Auth
val yojson_of_ikeV2Auth : ikeV2Auth -> Yojson.Safe.t
val ikeV2Auth_of_json : string -> ikeV2Auth
val json_of_ikeV2Auth : ikeV2Auth -> string

module IkeV2Auth : sig
  type nonrec t = ikeV2Auth
  val create : ?name:string -> ?algorithm:refType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   IKEv2 Authentication method per
   \[RFC9593\](https://www.ietf.org/rfc/rfc9593.html).
*)
type cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth =
  | IkeV2AuthList of ikeV2Auth list
  | CryptoRefArray of cryptoRefArray

val cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth
val yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth : cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth -> Yojson.Safe.t
val cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth_of_json : string -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth
val json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth : cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth -> string

module CryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth : sig
  type nonrec t = cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Object representing an encryption algorithm (ENCR) *)
type ikeV2Enc = {
  name: string option;  (** A name for the encryption method. *)
  keyLength: int option;  (** The key length of the encryption algorithm. *)
  algorithm: refType option;
}

val create_ikeV2Enc : ?name:string -> ?keyLength:int -> ?algorithm:refType -> unit -> ikeV2Enc
val ikeV2Enc_of_yojson : Yojson.Safe.t -> ikeV2Enc
val yojson_of_ikeV2Enc : ikeV2Enc -> Yojson.Safe.t
val ikeV2Enc_of_json : string -> ikeV2Enc
val json_of_ikeV2Enc : ikeV2Enc -> string

module IkeV2Enc : sig
  type nonrec t = ikeV2Enc
  val create : ?name:string -> ?keyLength:int -> ?algorithm:refType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Transform Type 1: encryption algorithms *)
type cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr =
  | IkeV2EncList of ikeV2Enc list
  | CryptoRefArray of cryptoRefArray

val cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr
val yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr : cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr -> Yojson.Safe.t
val cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr_of_json : string -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr
val json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr : cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr -> string

module CryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr : sig
  type nonrec t = cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Object representing an integrity algorithm (INTEG) *)
type ikeV2Integ = {
  name: string option;  (** A name for the integrity algorithm. *)
  algorithm: refType option;
}

val create_ikeV2Integ : ?name:string -> ?algorithm:refType -> unit -> ikeV2Integ
val ikeV2Integ_of_yojson : Yojson.Safe.t -> ikeV2Integ
val yojson_of_ikeV2Integ : ikeV2Integ -> Yojson.Safe.t
val ikeV2Integ_of_json : string -> ikeV2Integ
val json_of_ikeV2Integ : ikeV2Integ -> string

module IkeV2Integ : sig
  type nonrec t = ikeV2Integ
  val create : ?name:string -> ?algorithm:refType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Transform Type 3: integrity algorithms *)
type cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg =
  | IkeV2IntegList of ikeV2Integ list
  | CryptoRefArray of cryptoRefArray

val cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg
val yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg : cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg -> Yojson.Safe.t
val cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg_of_json : string -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg
val json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg : cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg -> string

module CryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg : sig
  type nonrec t = cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Object representing a key exchange method (KE) *)
type ikeV2Ke = {
  group: int option;  (** A group identifier for the key exchange algorithm. *)
  algorithm: refType option;
}

val create_ikeV2Ke : ?group:int -> ?algorithm:refType -> unit -> ikeV2Ke
val ikeV2Ke_of_yojson : Yojson.Safe.t -> ikeV2Ke
val yojson_of_ikeV2Ke : ikeV2Ke -> Yojson.Safe.t
val ikeV2Ke_of_json : string -> ikeV2Ke
val json_of_ikeV2Ke : ikeV2Ke -> string

module IkeV2Ke : sig
  type nonrec t = ikeV2Ke
  val create : ?group:int -> ?algorithm:refType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Transform Type 4: Key Exchange Method (KE) per \[RFC
   9370\](https://www.ietf.org/rfc/rfc9370.html), formerly called
   Diffie-Hellman Group (D-H).
*)
type cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe =
  | IkeV2KeList of ikeV2Ke list
  | CryptoRefArray of cryptoRefArray

val cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe
val yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe : cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe -> Yojson.Safe.t
val cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe_of_json : string -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe
val json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe : cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe -> string

module CryptoPropertiesProtocolPropertiesIkev2TransformTypesKe : sig
  type nonrec t = cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Object representing a pseudorandom function (PRF) *)
type ikeV2Prf = {
  name: string option;  (** A name for the pseudorandom function. *)
  algorithm: refType option;
}

val create_ikeV2Prf : ?name:string -> ?algorithm:refType -> unit -> ikeV2Prf
val ikeV2Prf_of_yojson : Yojson.Safe.t -> ikeV2Prf
val yojson_of_ikeV2Prf : ikeV2Prf -> Yojson.Safe.t
val ikeV2Prf_of_json : string -> ikeV2Prf
val json_of_ikeV2Prf : ikeV2Prf -> string

module IkeV2Prf : sig
  type nonrec t = ikeV2Prf
  val create : ?name:string -> ?algorithm:refType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Transform Type 2: pseudorandom functions *)
type cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf =
  | IkeV2PrfList of ikeV2Prf list
  | CryptoRefArray of cryptoRefArray

val cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf
val yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf : cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf -> Yojson.Safe.t
val cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf_of_json : string -> cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf
val json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf : cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf -> string

module CryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf : sig
  type nonrec t = cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The IKEv2 transform types supported (types 1-4), defined in \[RFC 7296
   section 3.3.2\](https://www.ietf.org/rfc/rfc7296.html#section-3.3.2),
   and additional properties.
*)
type cryptoPropertiesProtocolPropertiesIkev2TransformTypes = {
  encr: cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr option;  (** Transform Type 1: encryption algorithms *)
  prf: cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf option;  (** Transform Type 2: pseudorandom functions *)
  integ: cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg option;  (** Transform Type 3: integrity algorithms *)
  ke: cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe option;
  (**
     Transform Type 4: Key Exchange Method (KE) per \[RFC
     9370\](https://www.ietf.org/rfc/rfc9370.html), formerly called
     Diffie-Hellman Group (D-H).
  *)
  esn: bool option;  (** Specifies if an Extended Sequence Number (ESN) is used. *)
  auth: cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth option;
  (**
     IKEv2 Authentication method per
     \[RFC9593\](https://www.ietf.org/rfc/rfc9593.html).
  *)
}

val create_cryptoPropertiesProtocolPropertiesIkev2TransformTypes : ?encr:cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr -> ?prf:cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf -> ?integ:cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg -> ?ke:cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe -> ?esn:bool -> ?auth:cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth -> unit -> cryptoPropertiesProtocolPropertiesIkev2TransformTypes
val cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolPropertiesIkev2TransformTypes
val yojson_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes : cryptoPropertiesProtocolPropertiesIkev2TransformTypes -> Yojson.Safe.t
val cryptoPropertiesProtocolPropertiesIkev2TransformTypes_of_json : string -> cryptoPropertiesProtocolPropertiesIkev2TransformTypes
val json_of_cryptoPropertiesProtocolPropertiesIkev2TransformTypes : cryptoPropertiesProtocolPropertiesIkev2TransformTypes -> string

module CryptoPropertiesProtocolPropertiesIkev2TransformTypes : sig
  type nonrec t = cryptoPropertiesProtocolPropertiesIkev2TransformTypes
  val create : ?encr:cryptoPropertiesProtocolPropertiesIkev2TransformTypesEncr -> ?prf:cryptoPropertiesProtocolPropertiesIkev2TransformTypesPrf -> ?integ:cryptoPropertiesProtocolPropertiesIkev2TransformTypesInteg -> ?ke:cryptoPropertiesProtocolPropertiesIkev2TransformTypesKe -> ?esn:bool -> ?auth:cryptoPropertiesProtocolPropertiesIkev2TransformTypesAuth -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   This document specifies the details and attributes related to a
   software license identifier. An SPDX expression may be a compound of
   license identifiers. The `license_identifier` property serves as the
   key that identifies each record. Note that this key is not required to
   be unique, as the same license identifier could apply to multiple,
   different but similar license details, texts, etc.
*)
type licenseChoiceItemsLicenseExpressionExpressionDetails = {
  licenseIdentifier: string;
  (**
     The valid SPDX license identifier. Refer to
     https://spdx.org/specifications for syntax requirements. This property
     serves as the primary key, which uniquely identifies each record.
  *)
  bomref: refType option;
  text: attachment option;
  url: string option;
  (**
     The URL to the license file. If specified, a 'license'
     externalReference should also be specified for completeness
  *)
}

val create_licenseChoiceItemsLicenseExpressionExpressionDetails : licenseIdentifier:string -> ?bomref:refType -> ?text:attachment -> ?url:string -> unit -> licenseChoiceItemsLicenseExpressionExpressionDetails
val licenseChoiceItemsLicenseExpressionExpressionDetails_of_yojson : Yojson.Safe.t -> licenseChoiceItemsLicenseExpressionExpressionDetails
val yojson_of_licenseChoiceItemsLicenseExpressionExpressionDetails : licenseChoiceItemsLicenseExpressionExpressionDetails -> Yojson.Safe.t
val licenseChoiceItemsLicenseExpressionExpressionDetails_of_json : string -> licenseChoiceItemsLicenseExpressionExpressionDetails
val json_of_licenseChoiceItemsLicenseExpressionExpressionDetails : licenseChoiceItemsLicenseExpressionExpressionDetails -> string

module LicenseChoiceItemsLicenseExpressionExpressionDetails : sig
  type nonrec t = licenseChoiceItemsLicenseExpressionExpressionDetails
  val create : licenseIdentifier:string -> ?bomref:refType -> ?text:attachment -> ?url:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Specifies the details and attributes related to a software license. It
   must be a valid SPDX license expression, along with additional
   properties such as license acknowledgment.
*)
type licenseChoiceItemsLicenseExpression = {
  expression: string;
  (**
     A valid SPDX license expression. Refer to
     https://spdx.org/specifications for syntax requirements.
  *)
  expressionDetails: licenseChoiceItemsLicenseExpressionExpressionDetails list option;  (** Details for parts of the `expression`. *)
  acknowledgement: licenseAcknowledgementEnumeration option;
  bomref: refType option;
  licensing: licensing option;
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

val create_licenseChoiceItemsLicenseExpression : expression:string -> ?expressionDetails:licenseChoiceItemsLicenseExpressionExpressionDetails list -> ?acknowledgement:licenseAcknowledgementEnumeration -> ?bomref:refType -> ?licensing:licensing -> ?properties:property list -> unit -> licenseChoiceItemsLicenseExpression
val licenseChoiceItemsLicenseExpression_of_yojson : Yojson.Safe.t -> licenseChoiceItemsLicenseExpression
val yojson_of_licenseChoiceItemsLicenseExpression : licenseChoiceItemsLicenseExpression -> Yojson.Safe.t
val licenseChoiceItemsLicenseExpression_of_json : string -> licenseChoiceItemsLicenseExpression
val json_of_licenseChoiceItemsLicenseExpression : licenseChoiceItemsLicenseExpression -> string

module LicenseChoiceItemsLicenseExpression : sig
  type nonrec t = licenseChoiceItemsLicenseExpression
  val create : expression:string -> ?expressionDetails:licenseChoiceItemsLicenseExpressionExpressionDetails list -> ?acknowledgement:licenseAcknowledgementEnumeration -> ?bomref:refType -> ?licensing:licensing -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type licenseChoiceItems =
  | License of licenseChoiceItemsLicense
  | LicenseExpression of licenseChoiceItemsLicenseExpression

val licenseChoiceItems_of_yojson : Yojson.Safe.t -> licenseChoiceItems
val yojson_of_licenseChoiceItems : licenseChoiceItems -> Yojson.Safe.t
val licenseChoiceItems_of_json : string -> licenseChoiceItems
val json_of_licenseChoiceItems : licenseChoiceItems -> string

module LicenseChoiceItems : sig
  type nonrec t = licenseChoiceItems
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   A list of SPDX licenses and/or named licenses and/or SPDX License
   Expression.
*)
type licenseChoice = licenseChoiceItems list

val licenseChoice_of_yojson : Yojson.Safe.t -> licenseChoice
val yojson_of_licenseChoice : licenseChoice -> Yojson.Safe.t
val licenseChoice_of_json : string -> licenseChoice
val json_of_licenseChoice : licenseChoice -> string

module LicenseChoice : sig
  type nonrec t = licenseChoice
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_componentEvidence : ?identity:componentEvidenceIdentity -> ?occurrences:componentEvidenceOccurrences list -> ?callstack:componentEvidenceCallstack -> ?licenses:licenseChoice -> ?copyright:copyright list -> unit -> componentEvidence
val componentEvidence_of_yojson : Yojson.Safe.t -> componentEvidence
val yojson_of_componentEvidence : componentEvidence -> Yojson.Safe.t
val componentEvidence_of_json : string -> componentEvidence
val json_of_componentEvidence : componentEvidence -> string

module ComponentEvidence : sig
  type nonrec t = componentEvidence
  val create : ?identity:componentEvidenceIdentity -> ?occurrences:componentEvidenceOccurrences list -> ?callstack:componentEvidenceCallstack -> ?licenses:licenseChoice -> ?copyright:copyright list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type modelCardModelParametersDatasets =
  | ComponentData of componentData
  | DataReference of modelCardModelParametersDatasetsDataReference

val modelCardModelParametersDatasets_of_yojson : Yojson.Safe.t -> modelCardModelParametersDatasets
val yojson_of_modelCardModelParametersDatasets : modelCardModelParametersDatasets -> Yojson.Safe.t
val modelCardModelParametersDatasets_of_json : string -> modelCardModelParametersDatasets
val json_of_modelCardModelParametersDatasets : modelCardModelParametersDatasets -> string

module ModelCardModelParametersDatasets : sig
  type nonrec t = modelCardModelParametersDatasets
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_modelCardModelParameters : ?approach:modelCardModelParametersApproach -> ?task:string -> ?architectureFamily:string -> ?modelArchitecture:string -> ?datasets:modelCardModelParametersDatasets list -> ?inputs:inputOutputMLParameters list -> ?outputs:inputOutputMLParameters list -> unit -> modelCardModelParameters
val modelCardModelParameters_of_yojson : Yojson.Safe.t -> modelCardModelParameters
val yojson_of_modelCardModelParameters : modelCardModelParameters -> Yojson.Safe.t
val modelCardModelParameters_of_json : string -> modelCardModelParameters
val json_of_modelCardModelParameters : modelCardModelParameters -> string

module ModelCardModelParameters : sig
  type nonrec t = modelCardModelParameters
  val create : ?approach:modelCardModelParametersApproach -> ?task:string -> ?architectureFamily:string -> ?modelArchitecture:string -> ?datasets:modelCardModelParametersDatasets list -> ?inputs:inputOutputMLParameters list -> ?outputs:inputOutputMLParameters list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type organizationalContact = {
  bomref: refType option;
  name: string option;  (** The name of a contact *)
  email: string option;  (** The email address of the contact. *)
  phone: string option;  (** The phone number of the contact. *)
}

val create_organizationalContact : ?bomref:refType -> ?name:string -> ?email:string -> ?phone:string -> unit -> organizationalContact
val organizationalContact_of_yojson : Yojson.Safe.t -> organizationalContact
val yojson_of_organizationalContact : organizationalContact -> Yojson.Safe.t
val organizationalContact_of_json : string -> organizationalContact
val json_of_organizationalContact : organizationalContact -> string

module OrganizationalContact : sig
  type nonrec t = organizationalContact
  val create : ?bomref:refType -> ?name:string -> ?email:string -> ?phone:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_postalAddress : ?bomref:refType -> ?country:string -> ?region:string -> ?locality:string -> ?postOfficeBoxNumber:string -> ?postalCode:string -> ?streetAddress:string -> unit -> postalAddress
val postalAddress_of_yojson : Yojson.Safe.t -> postalAddress
val yojson_of_postalAddress : postalAddress -> Yojson.Safe.t
val postalAddress_of_json : string -> postalAddress
val json_of_postalAddress : postalAddress -> string

module PostalAddress : sig
  type nonrec t = postalAddress
  val create : ?bomref:refType -> ?country:string -> ?region:string -> ?locality:string -> ?postOfficeBoxNumber:string -> ?postalCode:string -> ?streetAddress:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type organizationalEntity = {
  bomref: refType option;
  name: string option;  (** The name of the organization *)
  address: postalAddress option;
  url: string list option;  (** The URL of the organization. Multiple URLs are allowed. *)
  contact: organizationalContact list option;  (** A contact at the organization. Multiple contacts are allowed. *)
}

val create_organizationalEntity : ?bomref:refType -> ?name:string -> ?address:postalAddress -> ?url:string list -> ?contact:organizationalContact list -> unit -> organizationalEntity
val organizationalEntity_of_yojson : Yojson.Safe.t -> organizationalEntity
val yojson_of_organizationalEntity : organizationalEntity -> Yojson.Safe.t
val organizationalEntity_of_json : string -> organizationalEntity
val json_of_organizationalEntity : organizationalEntity -> string

module OrganizationalEntity : sig
  type nonrec t = organizationalEntity
  val create : ?bomref:refType -> ?name:string -> ?address:postalAddress -> ?url:string list -> ?contact:organizationalContact list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_energyProvider : ?bomref:refType -> ?description:string -> organization:organizationalEntity -> energySource:energyProviderEnergySource -> energyProvided:energyMeasure -> ?externalReferences:externalReference list -> unit -> energyProvider
val energyProvider_of_yojson : Yojson.Safe.t -> energyProvider
val yojson_of_energyProvider : energyProvider -> Yojson.Safe.t
val energyProvider_of_json : string -> energyProvider
val json_of_energyProvider : energyProvider -> string

module EnergyProvider : sig
  type nonrec t = energyProvider
  val create : ?bomref:refType -> ?description:string -> organization:organizationalEntity -> energySource:energyProviderEnergySource -> energyProvided:energyMeasure -> ?externalReferences:externalReference list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_energyConsumption : activity:energyConsumptionActivity -> energyProviders:energyProvider list -> activityEnergyCost:energyMeasure -> ?co2CostEquivalent:co2Measure -> ?co2CostOffset:co2Measure -> ?properties:property list -> unit -> energyConsumption
val energyConsumption_of_yojson : Yojson.Safe.t -> energyConsumption
val yojson_of_energyConsumption : energyConsumption -> Yojson.Safe.t
val energyConsumption_of_json : string -> energyConsumption
val json_of_energyConsumption : energyConsumption -> string

module EnergyConsumption : sig
  type nonrec t = energyConsumption
  val create : activity:energyConsumptionActivity -> energyProviders:energyProvider list -> activityEnergyCost:energyMeasure -> ?co2CostEquivalent:co2Measure -> ?co2CostOffset:co2Measure -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_environmentalConsiderations : ?energyConsumptions:energyConsumption list -> ?properties:property list -> unit -> environmentalConsiderations
val environmentalConsiderations_of_yojson : Yojson.Safe.t -> environmentalConsiderations
val yojson_of_environmentalConsiderations : environmentalConsiderations -> Yojson.Safe.t
val environmentalConsiderations_of_json : string -> environmentalConsiderations
val json_of_environmentalConsiderations : environmentalConsiderations -> string

module EnvironmentalConsiderations : sig
  type nonrec t = environmentalConsiderations
  val create : ?energyConsumptions:energyConsumption list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type patentAssertionsItemsAsserter =
  | OrganizationalEntity of organizationalEntity
  | OrganizationalContact of organizationalContact
  | RefLinkType of refLinkType

val patentAssertionsItemsAsserter_of_yojson : Yojson.Safe.t -> patentAssertionsItemsAsserter
val yojson_of_patentAssertionsItemsAsserter : patentAssertionsItemsAsserter -> Yojson.Safe.t
val patentAssertionsItemsAsserter_of_json : string -> patentAssertionsItemsAsserter
val json_of_patentAssertionsItemsAsserter : patentAssertionsItemsAsserter -> string

module PatentAssertionsItemsAsserter : sig
  type nonrec t = patentAssertionsItemsAsserter
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   An assertion linking a patent or patent family to this component or
   service.
*)
type patentAssertionsItems = {
  bomref: refType option;
  assertionType: patentAssertionsItemsAssertionType;
  (**
     The type of assertion being made about the patent or patent family.
     Examples include ownership, licensing, and standards inclusion.
  *)
  patentRefs: refType list option;
  (**
     A list of BOM references (`bom-ref`) linking to patents or patent
     families associated with this assertion.
  *)
  asserter: patentAssertionsItemsAsserter;
  notes: string option;
  (**
     Additional notes or clarifications regarding the assertion, if
     necessary. For example, geographical restrictions, duration, or
     limitations of a license.
  *)
}

val create_patentAssertionsItems : ?bomref:refType -> assertionType:patentAssertionsItemsAssertionType -> ?patentRefs:refType list -> asserter:patentAssertionsItemsAsserter -> ?notes:string -> unit -> patentAssertionsItems
val patentAssertionsItems_of_yojson : Yojson.Safe.t -> patentAssertionsItems
val yojson_of_patentAssertionsItems : patentAssertionsItems -> Yojson.Safe.t
val patentAssertionsItems_of_json : string -> patentAssertionsItems
val json_of_patentAssertionsItems : patentAssertionsItems -> string

module PatentAssertionsItems : sig
  type nonrec t = patentAssertionsItems
  val create : ?bomref:refType -> assertionType:patentAssertionsItemsAssertionType -> ?patentRefs:refType list -> asserter:patentAssertionsItemsAsserter -> ?notes:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   A list of assertions made regarding patents associated with this
   component or service. Assertions distinguish between ownership,
   licensing, and other relevant interactions with patents.
*)
type patentAssertions = patentAssertionsItems list

val patentAssertions_of_yojson : Yojson.Safe.t -> patentAssertions
val yojson_of_patentAssertions : patentAssertions -> Yojson.Safe.t
val patentAssertions_of_json : string -> patentAssertions
val json_of_patentAssertions : patentAssertions -> string

module PatentAssertions : sig
  type nonrec t = patentAssertions
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A cryptographic assets related to this component. *)
type relatedCryptographicAsset = {
  type_: string option;
  (**
     Specifies the mechanism by which the cryptographic asset is secured
     by.
  *)
  ref: refType option;
}

val create_relatedCryptographicAsset : ?type_:string -> ?ref:refType -> unit -> relatedCryptographicAsset
val relatedCryptographicAsset_of_yojson : Yojson.Safe.t -> relatedCryptographicAsset
val yojson_of_relatedCryptographicAsset : relatedCryptographicAsset -> Yojson.Safe.t
val relatedCryptographicAsset_of_json : string -> relatedCryptographicAsset
val json_of_relatedCryptographicAsset : relatedCryptographicAsset -> string

module RelatedCryptographicAsset : sig
  type nonrec t = relatedCryptographicAsset
  val create : ?type_:string -> ?ref:refType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A list of cryptographic assets related to this component. *)
type relatedCryptographicAssets = relatedCryptographicAsset list

val relatedCryptographicAssets_of_yojson : Yojson.Safe.t -> relatedCryptographicAssets
val yojson_of_relatedCryptographicAssets : relatedCryptographicAssets -> Yojson.Safe.t
val relatedCryptographicAssets_of_json : string -> relatedCryptographicAssets
val json_of_relatedCryptographicAssets : relatedCryptographicAssets -> string

module RelatedCryptographicAssets : sig
  type nonrec t = relatedCryptographicAssets
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Properties for cryptographic assets of asset type 'certificate' *)
type cryptoPropertiesCertificateProperties = {
  serialNumber: string option;
  (**
     The serial number is a unique identifier for the certificate issued by
     a CA.
  *)
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
  certificateExtension: string option;
  (**
     \[DEPRECATED\] This will be removed in a future version. Use
     `\@.certificateFileExtension` instead. The file extension of the
     certificate
  *)
  certificateFileExtension: string option;  (** The file extension of the certificate. *)
  fingerprint: hash option;
  certificateState: cryptoPropertiesCertificatePropertiesCertificateState list option;
  (**
     The certificate lifecycle is a comprehensive process that manages
     digital certificates from their initial creation to eventual
     expiration or revocation. It typically involves several stages
  *)
  creationDate: string option;
  (**
     The date and time (timestamp) when the certificate was created or
     pre-activated.
  *)
  activationDate: string option;  (** The date and time (timestamp) when the certificate was activated. *)
  deactivationDate: string option;
  (**
     The date and time (timestamp) when the related certificate was
     deactivated.
  *)
  revocationDate: string option;  (** The date and time (timestamp) when the certificate was revoked. *)
  destructionDate: string option;  (** The date and time (timestamp) when the certificate was destroyed. *)
  certificateExtensions: cryptoPropertiesCertificatePropertiesCertificateExtensions list option;
  (**
     A certificate extension is a field that provides additional
     information about the certificate or its use. Extensions are used to
     convey additional information beyond the standard fields.
  *)
  relatedCryptographicAssets: relatedCryptographicAssets option;
}

val create_cryptoPropertiesCertificateProperties : ?serialNumber:string -> ?subjectName:string -> ?issuerName:string -> ?notValidBefore:string -> ?notValidAfter:string -> ?signatureAlgorithmRef:refType -> ?subjectPublicKeyRef:refType -> ?certificateFormat:string -> ?certificateExtension:string -> ?certificateFileExtension:string -> ?fingerprint:hash -> ?certificateState:cryptoPropertiesCertificatePropertiesCertificateState list -> ?creationDate:string -> ?activationDate:string -> ?deactivationDate:string -> ?revocationDate:string -> ?destructionDate:string -> ?certificateExtensions:cryptoPropertiesCertificatePropertiesCertificateExtensions list -> ?relatedCryptographicAssets:relatedCryptographicAssets -> unit -> cryptoPropertiesCertificateProperties
val cryptoPropertiesCertificateProperties_of_yojson : Yojson.Safe.t -> cryptoPropertiesCertificateProperties
val yojson_of_cryptoPropertiesCertificateProperties : cryptoPropertiesCertificateProperties -> Yojson.Safe.t
val cryptoPropertiesCertificateProperties_of_json : string -> cryptoPropertiesCertificateProperties
val json_of_cryptoPropertiesCertificateProperties : cryptoPropertiesCertificateProperties -> string

module CryptoPropertiesCertificateProperties : sig
  type nonrec t = cryptoPropertiesCertificateProperties
  val create : ?serialNumber:string -> ?subjectName:string -> ?issuerName:string -> ?notValidBefore:string -> ?notValidAfter:string -> ?signatureAlgorithmRef:refType -> ?subjectPublicKeyRef:refType -> ?certificateFormat:string -> ?certificateExtension:string -> ?certificateFileExtension:string -> ?fingerprint:hash -> ?certificateState:cryptoPropertiesCertificatePropertiesCertificateState list -> ?creationDate:string -> ?activationDate:string -> ?deactivationDate:string -> ?revocationDate:string -> ?destructionDate:string -> ?certificateExtensions:cryptoPropertiesCertificatePropertiesCertificateExtensions list -> ?relatedCryptographicAssets:relatedCryptographicAssets -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  relatedCryptographicAssets: relatedCryptographicAssets option;
}

val create_cryptoPropertiesProtocolProperties : ?type_:cryptoPropertiesProtocolPropertiesType -> ?version:string -> ?cipherSuites:cipherSuite list -> ?ikev2TransformTypes:cryptoPropertiesProtocolPropertiesIkev2TransformTypes -> ?cryptoRefArray:cryptoRefArray -> ?relatedCryptographicAssets:relatedCryptographicAssets -> unit -> cryptoPropertiesProtocolProperties
val cryptoPropertiesProtocolProperties_of_yojson : Yojson.Safe.t -> cryptoPropertiesProtocolProperties
val yojson_of_cryptoPropertiesProtocolProperties : cryptoPropertiesProtocolProperties -> Yojson.Safe.t
val cryptoPropertiesProtocolProperties_of_json : string -> cryptoPropertiesProtocolProperties
val json_of_cryptoPropertiesProtocolProperties : cryptoPropertiesProtocolProperties -> string

module CryptoPropertiesProtocolProperties : sig
  type nonrec t = cryptoPropertiesProtocolProperties
  val create : ?type_:cryptoPropertiesProtocolPropertiesType -> ?version:string -> ?cipherSuites:cipherSuite list -> ?ikev2TransformTypes:cryptoPropertiesProtocolPropertiesIkev2TransformTypes -> ?cryptoRefArray:cryptoRefArray -> ?relatedCryptographicAssets:relatedCryptographicAssets -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
type releaseType = private string

val create_releaseType : string -> releaseType
val releaseType_of_yojson : Yojson.Safe.t -> releaseType
val yojson_of_releaseType : releaseType -> Yojson.Safe.t
val releaseType_of_json : string -> releaseType
val json_of_releaseType : releaseType -> string

module ReleaseType : sig
  type nonrec t = releaseType
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type risk = {
  name: string option;  (** The name of the risk. *)
  mitigationStrategy: string option;  (** Strategy used to address this risk. *)
}

val create_risk : ?name:string -> ?mitigationStrategy:string -> unit -> risk
val risk_of_yojson : Yojson.Safe.t -> risk
val yojson_of_risk : risk -> Yojson.Safe.t
val risk_of_json : string -> risk
val json_of_risk : risk -> string

module Risk : sig
  type nonrec t = risk
  val create : ?name:string -> ?mitigationStrategy:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_modelCardConsiderations : ?users:string list -> ?useCases:string list -> ?technicalLimitations:string list -> ?performanceTradeoffs:string list -> ?ethicalConsiderations:risk list -> ?environmentalConsiderations:environmentalConsiderations -> ?fairnessAssessments:fairnessAssessment list -> unit -> modelCardConsiderations
val modelCardConsiderations_of_yojson : Yojson.Safe.t -> modelCardConsiderations
val yojson_of_modelCardConsiderations : modelCardConsiderations -> Yojson.Safe.t
val modelCardConsiderations_of_json : string -> modelCardConsiderations
val json_of_modelCardConsiderations : modelCardConsiderations -> string

module ModelCardConsiderations : sig
  type nonrec t = modelCardConsiderations
  val create : ?users:string list -> ?useCases:string list -> ?technicalLimitations:string list -> ?performanceTradeoffs:string list -> ?ethicalConsiderations:risk list -> ?environmentalConsiderations:environmentalConsiderations -> ?fairnessAssessments:fairnessAssessment list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_modelCard : ?bomref:refType -> ?modelParameters:modelCardModelParameters -> ?quantitativeAnalysis:modelCardQuantitativeAnalysis -> ?considerations:modelCardConsiderations -> ?properties:property list -> unit -> modelCard
val modelCard_of_yojson : Yojson.Safe.t -> modelCard
val yojson_of_modelCard : modelCard -> Yojson.Safe.t
val modelCard_of_json : string -> modelCard
val json_of_modelCard : modelCard -> string

module ModelCard : sig
  type nonrec t = modelCard
  val create : ?bomref:refType -> ?modelParameters:modelCardModelParameters -> ?quantitativeAnalysis:modelCardQuantitativeAnalysis -> ?considerations:modelCardConsiderations -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_securedBy : ?mechanism:string -> ?algorithmRef:refType -> unit -> securedBy
val securedBy_of_yojson : Yojson.Safe.t -> securedBy
val yojson_of_securedBy : securedBy -> Yojson.Safe.t
val securedBy_of_json : string -> securedBy
val json_of_securedBy : securedBy -> string

module SecuredBy : sig
  type nonrec t = securedBy
  val create : ?mechanism:string -> ?algorithmRef:refType -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Properties for cryptographic assets of asset type:
   `related-crypto-material`
*)
type cryptoPropertiesRelatedCryptoMaterialProperties = {
  type_: cryptoPropertiesRelatedCryptoMaterialPropertiesType option;  (** The type for the related cryptographic material *)
  id: string option;  (** The unique identifier for the related cryptographic material. *)
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
  fingerprint: hash option;
  relatedCryptographicAssets: relatedCryptographicAssets option;
}

val create_cryptoPropertiesRelatedCryptoMaterialProperties : ?type_:cryptoPropertiesRelatedCryptoMaterialPropertiesType -> ?id:string -> ?state:cryptoPropertiesRelatedCryptoMaterialPropertiesState -> ?algorithmRef:refType -> ?creationDate:string -> ?activationDate:string -> ?updateDate:string -> ?expirationDate:string -> ?value:string -> ?size:int -> ?format:string -> ?securedBy:securedBy -> ?fingerprint:hash -> ?relatedCryptographicAssets:relatedCryptographicAssets -> unit -> cryptoPropertiesRelatedCryptoMaterialProperties
val cryptoPropertiesRelatedCryptoMaterialProperties_of_yojson : Yojson.Safe.t -> cryptoPropertiesRelatedCryptoMaterialProperties
val yojson_of_cryptoPropertiesRelatedCryptoMaterialProperties : cryptoPropertiesRelatedCryptoMaterialProperties -> Yojson.Safe.t
val cryptoPropertiesRelatedCryptoMaterialProperties_of_json : string -> cryptoPropertiesRelatedCryptoMaterialProperties
val json_of_cryptoPropertiesRelatedCryptoMaterialProperties : cryptoPropertiesRelatedCryptoMaterialProperties -> string

module CryptoPropertiesRelatedCryptoMaterialProperties : sig
  type nonrec t = cryptoPropertiesRelatedCryptoMaterialProperties
  val create : ?type_:cryptoPropertiesRelatedCryptoMaterialPropertiesType -> ?id:string -> ?state:cryptoPropertiesRelatedCryptoMaterialPropertiesState -> ?algorithmRef:refType -> ?creationDate:string -> ?activationDate:string -> ?updateDate:string -> ?expirationDate:string -> ?value:string -> ?size:int -> ?format:string -> ?securedBy:securedBy -> ?fingerprint:hash -> ?relatedCryptographicAssets:relatedCryptographicAssets -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cryptoProperties : assetType:cryptoPropertiesAssetType -> ?algorithmProperties:cryptoPropertiesAlgorithmProperties -> ?certificateProperties:cryptoPropertiesCertificateProperties -> ?relatedCryptoMaterialProperties:cryptoPropertiesRelatedCryptoMaterialProperties -> ?protocolProperties:cryptoPropertiesProtocolProperties -> ?oid:string -> unit -> cryptoProperties
val cryptoProperties_of_yojson : Yojson.Safe.t -> cryptoProperties
val yojson_of_cryptoProperties : cryptoProperties -> Yojson.Safe.t
val cryptoProperties_of_json : string -> cryptoProperties
val json_of_cryptoProperties : cryptoProperties -> string

module CryptoProperties : sig
  type nonrec t = cryptoProperties
  val create : assetType:cryptoPropertiesAssetType -> ?algorithmProperties:cryptoPropertiesAlgorithmProperties -> ?certificateProperties:cryptoPropertiesCertificateProperties -> ?relatedCryptoMaterialProperties:cryptoPropertiesRelatedCryptoMaterialProperties -> ?protocolProperties:cryptoPropertiesProtocolProperties -> ?oid:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type serviceDataDestination =
  | String of string
  | BomLinkElementType of bomLinkElementType

val serviceDataDestination_of_yojson : Yojson.Safe.t -> serviceDataDestination
val yojson_of_serviceDataDestination : serviceDataDestination -> Yojson.Safe.t
val serviceDataDestination_of_json : string -> serviceDataDestination
val json_of_serviceDataDestination : serviceDataDestination -> string

module ServiceDataDestination : sig
  type nonrec t = serviceDataDestination
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type serviceDataSource =
  | String of string
  | BomLinkElementType of bomLinkElementType

val serviceDataSource_of_yojson : Yojson.Safe.t -> serviceDataSource
val yojson_of_serviceDataSource : serviceDataSource -> Yojson.Safe.t
val serviceDataSource_of_json : string -> serviceDataSource
val json_of_serviceDataSource : serviceDataSource -> string

module ServiceDataSource : sig
  type nonrec t = serviceDataSource
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_serviceData : flow:dataFlowDirection -> classification:dataClassification -> ?name:string -> ?description:string -> ?governance:dataGovernance -> ?source:serviceDataSource list -> ?destination:serviceDataDestination list -> unit -> serviceData
val serviceData_of_yojson : Yojson.Safe.t -> serviceData
val yojson_of_serviceData : serviceData -> Yojson.Safe.t
val serviceData_of_json : string -> serviceData
val json_of_serviceData : serviceData -> string

module ServiceData : sig
  type nonrec t = serviceData
  val create : flow:dataFlowDirection -> classification:dataClassification -> ?name:string -> ?description:string -> ?governance:dataGovernance -> ?source:serviceDataSource list -> ?destination:serviceDataDestination list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Enveloped signature in \[JSON Signature Format
   (JSF)\](https://cyberphone.github.io/doc/security/jsf.html).
*)
type signature = json_

val signature_of_yojson : Yojson.Safe.t -> signature
val yojson_of_signature : signature -> Yojson.Safe.t
val signature_of_json : string -> signature
val json_of_signature : signature -> string

module Signature : sig
  type nonrec t = signature
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_swid : tagId:string -> name:string -> ?version:string -> ?tagVersion:int -> ?patch:bool -> ?text:attachment -> ?url:string -> unit -> swid
val swid_of_yojson : Yojson.Safe.t -> swid
val yojson_of_swid : swid -> Yojson.Safe.t
val swid_of_json : string -> swid
val json_of_swid : swid -> string

module Swid : sig
  type nonrec t = swid
  val create : tagId:string -> name:string -> ?version:string -> ?tagVersion:int -> ?patch:bool -> ?text:attachment -> ?url:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Textual strings that aid in discovery, search, and retrieval of the
   associated object. Tags often serve as a way to group or categorize
   similar or related objects by various attributes.
*)
type tags = string list

val tags_of_yojson : Yojson.Safe.t -> tags
val yojson_of_tags : tags -> Yojson.Safe.t
val tags_of_json : string -> tags
val json_of_tags : tags -> string

module Tags : sig
  type nonrec t = tags
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_releaseNotes : type_:releaseType -> ?title:string -> ?featuredImage:string -> ?socialImage:string -> ?description:string -> ?timestamp:string -> ?aliases:string list -> ?tags:tags -> ?resolves:issue list -> ?notes:note list -> ?properties:property list -> unit -> releaseNotes
val releaseNotes_of_yojson : Yojson.Safe.t -> releaseNotes
val yojson_of_releaseNotes : releaseNotes -> Yojson.Safe.t
val releaseNotes_of_json : string -> releaseNotes
val json_of_releaseNotes : releaseNotes -> string

module ReleaseNotes : sig
  type nonrec t = releaseNotes
  val create : type_:releaseType -> ?title:string -> ?featuredImage:string -> ?socialImage:string -> ?description:string -> ?timestamp:string -> ?aliases:string list -> ?tags:tags -> ?resolves:issue list -> ?notes:note list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A single disjunctive version identifier, for a component or service. *)
type version = private string

val create_version : string -> version
val version_of_yojson : Yojson.Safe.t -> version
val yojson_of_version : version -> Yojson.Safe.t
val version_of_json : string -> version
val json_of_version : version -> string

module Version : sig
  type nonrec t = version
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   A version range specified in Package URL Version Range syntax (vers)
   which is defined at https://github.com/package-url/vers-spec
*)
type versionRange = private string

val create_versionRange : string -> versionRange
val versionRange_of_yojson : Yojson.Safe.t -> versionRange
val yojson_of_versionRange : versionRange -> Yojson.Safe.t
val versionRange_of_json : string -> versionRange
val json_of_versionRange : versionRange -> string

module VersionRange : sig
  type nonrec t = versionRange
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  patentAssertions: patentAssertions option;
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

val create_service : ?bomref:refType -> ?provider:organizationalEntity -> ?group:string -> name:string -> ?version:version -> ?description:string -> ?endpoints:string list -> ?authenticated:bool -> ?xtrustboundary:bool -> ?trustZone:string -> ?data:serviceData list -> ?licenses:licenseChoice -> ?patentAssertions:patentAssertions -> ?externalReferences:externalReference list -> ?services:service list -> ?releaseNotes:releaseNotes -> ?properties:property list -> ?tags:tags -> ?signature:signature -> unit -> service
val service_of_yojson : Yojson.Safe.t -> service
val yojson_of_service : service -> Yojson.Safe.t
val service_of_json : string -> service
val json_of_service : service -> string

module Service : sig
  type nonrec t = service
  val create : ?bomref:refType -> ?provider:organizationalEntity -> ?group:string -> name:string -> ?version:version -> ?description:string -> ?endpoints:string list -> ?authenticated:bool -> ?xtrustboundary:bool -> ?trustZone:string -> ?data:serviceData list -> ?licenses:licenseChoice -> ?patentAssertions:patentAssertions -> ?externalReferences:externalReference list -> ?services:service list -> ?releaseNotes:releaseNotes -> ?properties:property list -> ?tags:tags -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
     The mime-type of the component. When used on file components, the
     mime-type can provide additional context about the kind of file being
     represented, such as an image, font, or executable. Some library or
     framework components may also have an associated mime-type.
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
  versionRange: versionRange option;
  isExternal: bool;
  (**
     Determine whether this component is external. An external component is
     one that is not part of an assembly, but is expected to be provided by
     the environment, regardless of the component's `.scope`. This setting
     can be useful for distinguishing which components are bundled with the
     product and which can be relied upon to be present in the deployment
     environment. This may be set to `true` for runtime components only.
     For `$.metadata.component`, it must be set to `false`.
  *)
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
  patentAssertions: patentAssertions option;
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
     where the forked version contains an ancestor node containing the
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
     A list of zero or more patches describing how the component deviates
     from an ancestor, descendant, or variant. Patches may be complementary
     to commits or may be used in place of commits.
  *)
  notes: string option;
  (**
     Notes, observations, and other non-structured commentary describing
     the components pedigree.
  *)
}

val create_component : type_:componentType -> ?mimetype:string -> ?bomref:refType -> ?supplier:organizationalEntity -> ?manufacturer:organizationalEntity -> ?authors:organizationalContact list -> ?author:string -> ?publisher:string -> ?group:string -> name:string -> ?version:version -> ?versionRange:versionRange -> ?isExternal:bool -> ?description:string -> ?scope:componentScope -> ?hashes:hash list -> ?licenses:licenseChoice -> ?copyright:string -> ?patentAssertions:patentAssertions -> ?cpe:string -> ?purl:string -> ?omniborId:string list -> ?swhid:string list -> ?swid:swid -> ?modified:bool -> ?pedigree:componentPedigree -> ?externalReferences:externalReference list -> ?components:component list -> ?evidence:componentEvidence -> ?releaseNotes:releaseNotes -> ?modelCard:modelCard -> ?data:componentData list -> ?cryptoProperties:cryptoProperties -> ?properties:property list -> ?tags:tags -> ?signature:signature -> unit -> component
val component_of_yojson : Yojson.Safe.t -> component
val yojson_of_component : component -> Yojson.Safe.t
val component_of_json : string -> component
val json_of_component : component -> string

val create_componentPedigree : ?ancestors:component list -> ?descendants:component list -> ?variants:component list -> ?commits:commit list -> ?patches:patch list -> ?notes:string -> unit -> componentPedigree
val componentPedigree_of_yojson : Yojson.Safe.t -> componentPedigree
val yojson_of_componentPedigree : componentPedigree -> Yojson.Safe.t
val componentPedigree_of_json : string -> componentPedigree
val json_of_componentPedigree : componentPedigree -> string

module Component : sig
  type nonrec t = component
  val create : type_:componentType -> ?mimetype:string -> ?bomref:refType -> ?supplier:organizationalEntity -> ?manufacturer:organizationalEntity -> ?authors:organizationalContact list -> ?author:string -> ?publisher:string -> ?group:string -> name:string -> ?version:version -> ?versionRange:versionRange -> ?isExternal:bool -> ?description:string -> ?scope:componentScope -> ?hashes:hash list -> ?licenses:licenseChoice -> ?copyright:string -> ?patentAssertions:patentAssertions -> ?cpe:string -> ?purl:string -> ?omniborId:string list -> ?swhid:string list -> ?swid:swid -> ?modified:bool -> ?pedigree:componentPedigree -> ?externalReferences:externalReference list -> ?components:component list -> ?evidence:componentEvidence -> ?releaseNotes:releaseNotes -> ?modelCard:modelCard -> ?data:componentData list -> ?cryptoProperties:cryptoProperties -> ?properties:property list -> ?tags:tags -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

module ComponentPedigree : sig
  type nonrec t = componentPedigree
  val create : ?ancestors:component list -> ?descendants:component list -> ?variants:component list -> ?commits:commit list -> ?patches:patch list -> ?notes:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val workspaceAccessMode_of_yojson : Yojson.Safe.t -> workspaceAccessMode
val yojson_of_workspaceAccessMode : workspaceAccessMode -> Yojson.Safe.t
val workspaceAccessMode_of_json : string -> workspaceAccessMode
val json_of_workspaceAccessMode : workspaceAccessMode -> string

module WorkspaceAccessMode : sig
  type nonrec t = workspaceAccessMode
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The mode for the volume instance. *)
type volumeMode =
  | Filesystem
  | Block

val volumeMode_of_yojson : Yojson.Safe.t -> volumeMode
val yojson_of_volumeMode : volumeMode -> Yojson.Safe.t
val volumeMode_of_json : string -> volumeMode
val json_of_volumeMode : volumeMode -> string

module VolumeMode : sig
  type nonrec t = volumeMode
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_volume : ?uid:string -> ?name:string -> ?mode:volumeMode -> ?path:string -> ?sizeAllocated:string -> ?persistent:bool -> ?remote:bool -> ?properties:property list -> unit -> volume
val volume_of_yojson : Yojson.Safe.t -> volume
val yojson_of_volume : volume -> Yojson.Safe.t
val volume_of_json : string -> volume
val json_of_volume : volume -> string

module Volume : sig
  type nonrec t = volume
  val create : ?uid:string -> ?name:string -> ?mode:volumeMode -> ?path:string -> ?sizeAllocated:string -> ?persistent:bool -> ?remote:bool -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   A reference to a locally defined resource (e.g., a bom-ref) or an
   externally accessible resource.
*)
type resourceReferenceChoice =
  | JsonresourceReferenceChoice_1 of json_
  | JsonresourceReferenceChoice_2 of json_

val resourceReferenceChoice_of_yojson : Yojson.Safe.t -> resourceReferenceChoice
val yojson_of_resourceReferenceChoice : resourceReferenceChoice -> Yojson.Safe.t
val resourceReferenceChoice_of_json : string -> resourceReferenceChoice
val json_of_resourceReferenceChoice : resourceReferenceChoice -> string

module ResourceReferenceChoice : sig
  type nonrec t = resourceReferenceChoice
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_workspace : bomref:refType -> uid:string -> ?name:string -> ?aliases:string list -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> ?accessMode:workspaceAccessMode -> ?mountPath:string -> ?managedDataType:string -> ?volumeRequest:string -> ?volume:volume -> ?properties:property list -> unit -> workspace
val workspace_of_yojson : Yojson.Safe.t -> workspace
val yojson_of_workspace : workspace -> Yojson.Safe.t
val workspace_of_json : string -> workspace
val json_of_workspace : workspace -> string

module Workspace : sig
  type nonrec t = workspace
  val create : bomref:refType -> uid:string -> ?name:string -> ?aliases:string list -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> ?accessMode:workspaceAccessMode -> ?mountPath:string -> ?managedDataType:string -> ?volumeRequest:string -> ?volume:volume -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The source type of event which caused the trigger to fire. *)
type triggerType =
  | Manual
  | Api
  | Webhook
  | Scheduled

val triggerType_of_yojson : Yojson.Safe.t -> triggerType
val yojson_of_triggerType : triggerType -> Yojson.Safe.t
val triggerType_of_json : string -> triggerType
val json_of_triggerType : triggerType -> string

module TriggerType : sig
  type nonrec t = triggerType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type outputType =
  | JsonoutputType_1 of json_
  | JsonoutputType_2 of json_
  | JsonoutputType_3 of json_

val outputType_of_yojson : Yojson.Safe.t -> outputType
val yojson_of_outputType : outputType -> Yojson.Safe.t
val outputType_of_json : string -> outputType
val json_of_outputType : outputType -> string

module OutputType : sig
  type nonrec t = outputType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Type that represents various input data types and formats. *)
type inputType =
  | JsoninputType_1 of json_
  | JsoninputType_2 of json_
  | JsoninputType_3 of json_
  | JsoninputType_4 of json_

val inputType_of_yojson : Yojson.Safe.t -> inputType
val yojson_of_inputType : inputType -> Yojson.Safe.t
val inputType_of_json : string -> inputType
val json_of_inputType : inputType -> string

module InputType : sig
  type nonrec t = inputType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_event : ?uid:string -> ?description:string -> ?timeReceived:string -> ?data:attachment -> ?source:resourceReferenceChoice -> ?target:resourceReferenceChoice -> ?properties:property list -> unit -> event
val event_of_yojson : Yojson.Safe.t -> event
val yojson_of_event : event -> Yojson.Safe.t
val event_of_json : string -> event
val json_of_event : event -> string

module Event : sig
  type nonrec t = event
  val create : ?uid:string -> ?description:string -> ?timeReceived:string -> ?data:attachment -> ?source:resourceReferenceChoice -> ?target:resourceReferenceChoice -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_condition : ?description:string -> ?expression:string -> ?properties:property list -> unit -> condition
val condition_of_yojson : Yojson.Safe.t -> condition
val yojson_of_condition : condition -> Yojson.Safe.t
val condition_of_json : string -> condition
val json_of_condition : condition -> string

module Condition : sig
  type nonrec t = condition
  val create : ?description:string -> ?expression:string -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_trigger : bomref:refType -> uid:string -> ?name:string -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> type_:triggerType -> ?event:event -> ?conditions:condition list -> ?timeActivated:string -> ?inputs:inputType list -> ?outputs:outputType list -> ?properties:property list -> unit -> trigger
val trigger_of_yojson : Yojson.Safe.t -> trigger
val yojson_of_trigger : trigger -> Yojson.Safe.t
val trigger_of_json : string -> trigger
val json_of_trigger : trigger -> string

module Trigger : sig
  type nonrec t = trigger
  val create : bomref:refType -> uid:string -> ?name:string -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> type_:triggerType -> ?event:event -> ?conditions:condition list -> ?timeActivated:string -> ?inputs:inputType list -> ?outputs:outputType list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val taskType_of_yojson : Yojson.Safe.t -> taskType
val yojson_of_taskType : taskType -> Yojson.Safe.t
val taskType_of_json : string -> taskType
val json_of_taskType : taskType -> string

module TaskType : sig
  type nonrec t = taskType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_command : ?executed:string -> ?properties:property list -> unit -> command
val command_of_yojson : Yojson.Safe.t -> command
val yojson_of_command : command -> Yojson.Safe.t
val command_of_json : string -> command
val json_of_command : command -> string

module Command : sig
  type nonrec t = command
  val create : ?executed:string -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_step : ?name:string -> ?description:string -> ?commands:command list -> ?properties:property list -> unit -> step
val step_of_yojson : Yojson.Safe.t -> step
val yojson_of_step : step -> Yojson.Safe.t
val step_of_json : string -> step
val json_of_step : step -> string

module Step : sig
  type nonrec t = step
  val create : ?name:string -> ?description:string -> ?commands:command list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_dependency : ref:refLinkType -> ?dependsOn:refLinkType list -> ?provides:refLinkType list -> unit -> dependency
val dependency_of_yojson : Yojson.Safe.t -> dependency
val yojson_of_dependency : dependency -> Yojson.Safe.t
val dependency_of_json : string -> dependency
val json_of_dependency : dependency -> string

module Dependency : sig
  type nonrec t = dependency
  val create : ref:refLinkType -> ?dependsOn:refLinkType list -> ?provides:refLinkType list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_task : bomref:refType -> uid:string -> ?name:string -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> taskTypes:taskType list -> ?trigger:trigger -> ?steps:step list -> ?inputs:inputType list -> ?outputs:outputType list -> ?timeStart:string -> ?timeEnd:string -> ?workspaces:workspace list -> ?runtimeTopology:dependency list -> ?properties:property list -> unit -> task
val task_of_yojson : Yojson.Safe.t -> task
val yojson_of_task : task -> Yojson.Safe.t
val task_of_json : string -> task
val json_of_task : task -> string

module Task : sig
  type nonrec t = task
  val create : bomref:refType -> uid:string -> ?name:string -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> taskTypes:taskType list -> ?trigger:trigger -> ?steps:step list -> ?inputs:inputType list -> ?outputs:outputType list -> ?timeStart:string -> ?timeEnd:string -> ?workspaces:workspace list -> ?runtimeTopology:dependency list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_workflow : bomref:refType -> uid:string -> ?name:string -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> ?tasks:task list -> ?taskDependencies:dependency list -> taskTypes:taskType list -> ?trigger:trigger -> ?steps:step list -> ?inputs:inputType list -> ?outputs:outputType list -> ?timeStart:string -> ?timeEnd:string -> ?workspaces:workspace list -> ?runtimeTopology:dependency list -> ?properties:property list -> unit -> workflow
val workflow_of_yojson : Yojson.Safe.t -> workflow
val yojson_of_workflow : workflow -> Yojson.Safe.t
val workflow_of_json : string -> workflow
val json_of_workflow : workflow -> string

module Workflow : sig
  type nonrec t = workflow
  val create : bomref:refType -> uid:string -> ?name:string -> ?description:string -> ?resourceReferences:resourceReferenceChoice list -> ?tasks:task list -> ?taskDependencies:dependency list -> taskTypes:taskType list -> ?trigger:trigger -> ?steps:step list -> ?inputs:inputType list -> ?outputs:outputType list -> ?timeStart:string -> ?timeEnd:string -> ?workspaces:workspace list -> ?runtimeTopology:dependency list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_vulnerabilityToolsTools : ?components:component list -> ?services:service list -> unit -> vulnerabilityToolsTools
val vulnerabilityToolsTools_of_yojson : Yojson.Safe.t -> vulnerabilityToolsTools
val yojson_of_vulnerabilityToolsTools : vulnerabilityToolsTools -> Yojson.Safe.t
val vulnerabilityToolsTools_of_json : string -> vulnerabilityToolsTools
val json_of_vulnerabilityToolsTools : vulnerabilityToolsTools -> string

module VulnerabilityToolsTools : sig
  type nonrec t = vulnerabilityToolsTools
  val create : ?components:component list -> ?services:service list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_tool : ?vendor:string -> ?name:string -> ?version:version -> ?hashes:hash list -> ?externalReferences:externalReference list -> unit -> tool
val tool_of_yojson : Yojson.Safe.t -> tool
val yojson_of_tool : tool -> Yojson.Safe.t
val tool_of_json : string -> tool
val json_of_tool : tool -> string

module Tool : sig
  type nonrec t = tool
  val create : ?vendor:string -> ?name:string -> ?version:version -> ?hashes:hash list -> ?externalReferences:externalReference list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The tool(s) used to identify, confirm, or score the vulnerability. *)
type vulnerabilityTools =
  | Tools of vulnerabilityToolsTools
  | ToolList of tool list

val vulnerabilityTools_of_yojson : Yojson.Safe.t -> vulnerabilityTools
val yojson_of_vulnerabilityTools : vulnerabilityTools -> Yojson.Safe.t
val vulnerabilityTools_of_json : string -> vulnerabilityTools
val json_of_vulnerabilityTools : vulnerabilityTools -> string

module VulnerabilityTools : sig
  type nonrec t = vulnerabilityTools
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The source of vulnerability information. This is often the
   organization that published the vulnerability.
*)
type vulnerabilitySource = {
  url: string option;  (** The url of the vulnerability documentation as provided by the source. *)
  name: string option;  (** The name of the source. *)
}

val create_vulnerabilitySource : ?url:string -> ?name:string -> unit -> vulnerabilitySource
val vulnerabilitySource_of_yojson : Yojson.Safe.t -> vulnerabilitySource
val yojson_of_vulnerabilitySource : vulnerabilitySource -> Yojson.Safe.t
val vulnerabilitySource_of_json : string -> vulnerabilitySource
val json_of_vulnerabilitySource : vulnerabilitySource -> string

module VulnerabilitySource : sig
  type nonrec t = vulnerabilitySource
  val create : ?url:string -> ?name:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type vulnerabilityReferences = {
  id: string;  (** An identifier that uniquely identifies the vulnerability. *)
  source: vulnerabilitySource;
}

val create_vulnerabilityReferences : id:string -> source:vulnerabilitySource -> unit -> vulnerabilityReferences
val vulnerabilityReferences_of_yojson : Yojson.Safe.t -> vulnerabilityReferences
val yojson_of_vulnerabilityReferences : vulnerabilityReferences -> Yojson.Safe.t
val vulnerabilityReferences_of_json : string -> vulnerabilityReferences
val json_of_vulnerabilityReferences : vulnerabilityReferences -> string

module VulnerabilityReferences : sig
  type nonrec t = vulnerabilityReferences
  val create : id:string -> source:vulnerabilitySource -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_vulnerabilityProofOfConcept : ?reproductionSteps:string -> ?environment:string -> ?supportingMaterial:attachment list -> unit -> vulnerabilityProofOfConcept
val vulnerabilityProofOfConcept_of_yojson : Yojson.Safe.t -> vulnerabilityProofOfConcept
val yojson_of_vulnerabilityProofOfConcept : vulnerabilityProofOfConcept -> Yojson.Safe.t
val vulnerabilityProofOfConcept_of_json : string -> vulnerabilityProofOfConcept
val json_of_vulnerabilityProofOfConcept : vulnerabilityProofOfConcept -> string

module VulnerabilityProofOfConcept : sig
  type nonrec t = vulnerabilityProofOfConcept
  val create : ?reproductionSteps:string -> ?environment:string -> ?supportingMaterial:attachment list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_vulnerabilityCredits : ?organizations:organizationalEntity list -> ?individuals:organizationalContact list -> unit -> vulnerabilityCredits
val vulnerabilityCredits_of_yojson : Yojson.Safe.t -> vulnerabilityCredits
val yojson_of_vulnerabilityCredits : vulnerabilityCredits -> Yojson.Safe.t
val vulnerabilityCredits_of_json : string -> vulnerabilityCredits
val json_of_vulnerabilityCredits : vulnerabilityCredits -> string

module VulnerabilityCredits : sig
  type nonrec t = vulnerabilityCredits
  val create : ?organizations:organizationalEntity list -> ?individuals:organizationalContact list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type vulnerabilityAnalysisResponse =
  | Can_not_fix
  | Will_not_fix
  | Update
  | Rollback
  | Workaround_available

val vulnerabilityAnalysisResponse_of_yojson : Yojson.Safe.t -> vulnerabilityAnalysisResponse
val yojson_of_vulnerabilityAnalysisResponse : vulnerabilityAnalysisResponse -> Yojson.Safe.t
val vulnerabilityAnalysisResponse_of_json : string -> vulnerabilityAnalysisResponse
val json_of_vulnerabilityAnalysisResponse : vulnerabilityAnalysisResponse -> string

module VulnerabilityAnalysisResponse : sig
  type nonrec t = vulnerabilityAnalysisResponse
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val impactAnalysisState_of_yojson : Yojson.Safe.t -> impactAnalysisState
val yojson_of_impactAnalysisState : impactAnalysisState -> Yojson.Safe.t
val impactAnalysisState_of_json : string -> impactAnalysisState
val json_of_impactAnalysisState : impactAnalysisState -> string

module ImpactAnalysisState : sig
  type nonrec t = impactAnalysisState
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val impactAnalysisJustification_of_yojson : Yojson.Safe.t -> impactAnalysisJustification
val yojson_of_impactAnalysisJustification : impactAnalysisJustification -> Yojson.Safe.t
val impactAnalysisJustification_of_json : string -> impactAnalysisJustification
val json_of_impactAnalysisJustification : impactAnalysisJustification -> string

module ImpactAnalysisJustification : sig
  type nonrec t = impactAnalysisJustification
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_vulnerabilityAnalysis : ?state:impactAnalysisState -> ?justification:impactAnalysisJustification -> ?response:vulnerabilityAnalysisResponse list -> ?detail:string -> ?firstIssued:string -> ?lastUpdated:string -> unit -> vulnerabilityAnalysis
val vulnerabilityAnalysis_of_yojson : Yojson.Safe.t -> vulnerabilityAnalysis
val yojson_of_vulnerabilityAnalysis : vulnerabilityAnalysis -> Yojson.Safe.t
val vulnerabilityAnalysis_of_json : string -> vulnerabilityAnalysis
val json_of_vulnerabilityAnalysis : vulnerabilityAnalysis -> string

module VulnerabilityAnalysis : sig
  type nonrec t = vulnerabilityAnalysis
  val create : ?state:impactAnalysisState -> ?justification:impactAnalysisJustification -> ?response:vulnerabilityAnalysisResponse list -> ?detail:string -> ?firstIssued:string -> ?lastUpdated:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type vulnerabilityAffectsVersions =
  | Jsonvulnerabilityaffectsversions_1 of json_
  | Jsonvulnerabilityaffectsversions_2 of json_

val vulnerabilityAffectsVersions_of_yojson : Yojson.Safe.t -> vulnerabilityAffectsVersions
val yojson_of_vulnerabilityAffectsVersions : vulnerabilityAffectsVersions -> Yojson.Safe.t
val vulnerabilityAffectsVersions_of_json : string -> vulnerabilityAffectsVersions
val json_of_vulnerabilityAffectsVersions : vulnerabilityAffectsVersions -> string

module VulnerabilityAffectsVersions : sig
  type nonrec t = vulnerabilityAffectsVersions
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** References a component or service by the objects bom-ref *)
type vulnerabilityAffectsRef =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

val vulnerabilityAffectsRef_of_yojson : Yojson.Safe.t -> vulnerabilityAffectsRef
val yojson_of_vulnerabilityAffectsRef : vulnerabilityAffectsRef -> Yojson.Safe.t
val vulnerabilityAffectsRef_of_json : string -> vulnerabilityAffectsRef
val json_of_vulnerabilityAffectsRef : vulnerabilityAffectsRef -> string

module VulnerabilityAffectsRef : sig
  type nonrec t = vulnerabilityAffectsRef
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type vulnerabilityAffects = {
  ref: vulnerabilityAffectsRef;  (** References a component or service by the objects bom-ref *)
  versions: vulnerabilityAffectsVersions list option;  (** Zero or more individual versions or range of versions. *)
}

val create_vulnerabilityAffects : ref:vulnerabilityAffectsRef -> ?versions:vulnerabilityAffectsVersions list -> unit -> vulnerabilityAffects
val vulnerabilityAffects_of_yojson : Yojson.Safe.t -> vulnerabilityAffects
val yojson_of_vulnerabilityAffects : vulnerabilityAffects -> Yojson.Safe.t
val vulnerabilityAffects_of_json : string -> vulnerabilityAffects
val json_of_vulnerabilityAffects : vulnerabilityAffects -> string

module VulnerabilityAffects : sig
  type nonrec t = vulnerabilityAffects
  val create : ref:vulnerabilityAffectsRef -> ?versions:vulnerabilityAffectsVersions list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val severity_of_yojson : Yojson.Safe.t -> severity
val yojson_of_severity : severity -> Yojson.Safe.t
val severity_of_json : string -> severity
val json_of_severity : severity -> string

module Severity : sig
  type nonrec t = severity
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val scoreMethod_of_yojson : Yojson.Safe.t -> scoreMethod
val yojson_of_scoreMethod : scoreMethod -> Yojson.Safe.t
val scoreMethod_of_json : string -> scoreMethod
val json_of_scoreMethod : scoreMethod -> string

module ScoreMethod : sig
  type nonrec t = scoreMethod
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  justification: string option;  (** A reason for rating the vulnerability as it was *)
}

val create_rating : ?source:vulnerabilitySource -> ?score:float -> ?severity:severity -> ?method_:scoreMethod -> ?vector:string -> ?justification:string -> unit -> rating
val rating_of_yojson : Yojson.Safe.t -> rating
val yojson_of_rating : rating -> Yojson.Safe.t
val rating_of_json : string -> rating
val json_of_rating : rating -> string

module Rating : sig
  type nonrec t = rating
  val create : ?source:vulnerabilitySource -> ?score:float -> ?severity:severity -> ?method_:scoreMethod -> ?vector:string -> ?justification:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Integer representation of a Common Weaknesses Enumerations (CWE). For
   example 399 (of https://cwe.mitre.org/data/definitions/399.html)
*)
type cwe = private int

val create_cwe : int -> cwe
val cwe_of_yojson : Yojson.Safe.t -> cwe
val yojson_of_cwe : cwe -> Yojson.Safe.t
val cwe_of_json : string -> cwe
val json_of_cwe : cwe -> string

module Cwe : sig
  type nonrec t = cwe
  val create : int -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Title and location where advisory information can be obtained. An
   advisory is a notification of a threat to a component, service, or
   system.
*)
type advisory = {
  title: string option;  (** A name of the advisory. *)
  url: string;  (** Location where the advisory can be obtained. *)
}

val create_advisory : ?title:string -> url:string -> unit -> advisory
val advisory_of_yojson : Yojson.Safe.t -> advisory
val yojson_of_advisory : advisory -> Yojson.Safe.t
val advisory_of_json : string -> advisory
val json_of_advisory : advisory -> string

module Advisory : sig
  type nonrec t = advisory
  val create : ?title:string -> url:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_vulnerability : ?bomref:refType -> ?id:string -> ?source:vulnerabilitySource -> ?references:vulnerabilityReferences list -> ?ratings:rating list -> ?cwes:cwe list -> ?description:string -> ?detail:string -> ?recommendation:string -> ?workaround:string -> ?proofOfConcept:vulnerabilityProofOfConcept -> ?advisories:advisory list -> ?created:string -> ?published:string -> ?updated:string -> ?rejected:string -> ?credits:vulnerabilityCredits -> ?tools:vulnerabilityTools -> ?analysis:vulnerabilityAnalysis -> ?affects:vulnerabilityAffects list -> ?properties:property list -> unit -> vulnerability
val vulnerability_of_yojson : Yojson.Safe.t -> vulnerability
val yojson_of_vulnerability : vulnerability -> Yojson.Safe.t
val vulnerability_of_json : string -> vulnerability
val json_of_vulnerability : vulnerability -> string

module Vulnerability : sig
  type nonrec t = vulnerability
  val create : ?bomref:refType -> ?id:string -> ?source:vulnerabilitySource -> ?references:vulnerabilityReferences list -> ?ratings:rating list -> ?cwes:cwe list -> ?description:string -> ?detail:string -> ?recommendation:string -> ?workaround:string -> ?proofOfConcept:vulnerabilityProofOfConcept -> ?advisories:advisory list -> ?created:string -> ?published:string -> ?updated:string -> ?rejected:string -> ?credits:vulnerabilityCredits -> ?tools:vulnerabilityTools -> ?analysis:vulnerabilityAnalysis -> ?affects:vulnerabilityAffects list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Traffic Light Protocol (TLP) is a classification system for
   identifying the potential risk associated with artefact, including
   whether it is subject to certain types of legal, financial, or
   technical threats. Refer to
   \[https://www.first.org/tlp/\](https://www.first.org/tlp/) for further
   information. The default classification is "CLEAR"
*)
type tlpClassification =
  | CLEAR
  | GREEN
  | AMBER
  | AMBER_AND_STRICT
  | RED

val tlpClassification_of_yojson : Yojson.Safe.t -> tlpClassification
val yojson_of_tlpClassification : tlpClassification -> Yojson.Safe.t
val tlpClassification_of_json : string -> tlpClassification
val json_of_tlpClassification : tlpClassification -> string

module TlpClassification : sig
  type nonrec t = tlpClassification
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_standardRequirements : ?bomref:refType -> ?identifier:string -> ?title:string -> ?text:string -> ?descriptions:string list -> ?openCre:string list -> ?parent:refLinkType -> ?properties:property list -> ?externalReferences:externalReference list -> unit -> standardRequirements
val standardRequirements_of_yojson : Yojson.Safe.t -> standardRequirements
val yojson_of_standardRequirements : standardRequirements -> Yojson.Safe.t
val standardRequirements_of_json : string -> standardRequirements
val json_of_standardRequirements : standardRequirements -> string

module StandardRequirements : sig
  type nonrec t = standardRequirements
  val create : ?bomref:refType -> ?identifier:string -> ?title:string -> ?text:string -> ?descriptions:string list -> ?openCre:string list -> ?parent:refLinkType -> ?properties:property list -> ?externalReferences:externalReference list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type standardLevels = {
  bomref: refType option;
  identifier: string option;  (** The identifier used in the standard to identify a specific level. *)
  title: string option;  (** The title of the level. *)
  description: string option;  (** The description of the level. *)
  requirements: refLinkType list option;  (** The list of requirement `bom-ref`s that comprise the level. *)
}

val create_standardLevels : ?bomref:refType -> ?identifier:string -> ?title:string -> ?description:string -> ?requirements:refLinkType list -> unit -> standardLevels
val standardLevels_of_yojson : Yojson.Safe.t -> standardLevels
val yojson_of_standardLevels : standardLevels -> Yojson.Safe.t
val standardLevels_of_json : string -> standardLevels
val json_of_standardLevels : standardLevels -> string

module StandardLevels : sig
  type nonrec t = standardLevels
  val create : ?bomref:refType -> ?identifier:string -> ?title:string -> ?description:string -> ?requirements:refLinkType list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_standard : ?bomref:refType -> ?name:string -> ?version:string -> ?description:string -> ?owner:string -> ?requirements:standardRequirements list -> ?levels:standardLevels list -> ?externalReferences:externalReference list -> ?signature:signature -> unit -> standard
val standard_of_yojson : Yojson.Safe.t -> standard
val yojson_of_standard : standard -> Yojson.Safe.t
val standard_of_json : string -> standard
val json_of_standard : standard -> string

module Standard : sig
  type nonrec t = standard
  val create : ?bomref:refType -> ?name:string -> ?version:string -> ?description:string -> ?owner:string -> ?requirements:standardRequirements list -> ?levels:standardLevels list -> ?externalReferences:externalReference list -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** Deprecated definition. use definition `versionRange` instead. *)
type range = json_

val range_of_yojson : Yojson.Safe.t -> range
val yojson_of_range : range -> Yojson.Safe.t
val range_of_json : string -> range
val json_of_range : range -> string

module Range : sig
  type nonrec t = range
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The jurisdiction or patent office where the priority application was
   filed, specified using WIPO ST.3 codes. Aligned with `IPOfficeCode` in
   ST.96. Refer to \[IPOfficeCode in
   ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Common/IPOfficeCode.xsd).
*)
type patentJurisdiction = private string

val create_patentJurisdiction : string -> patentJurisdiction
val patentJurisdiction_of_yojson : Yojson.Safe.t -> patentJurisdiction
val yojson_of_patentJurisdiction : patentJurisdiction -> Yojson.Safe.t
val patentJurisdiction_of_json : string -> patentJurisdiction
val json_of_patentJurisdiction : patentJurisdiction -> string

module PatentJurisdiction : sig
  type nonrec t = patentJurisdiction
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The date the priority application was filed, aligned with `FilingDate`
   in ST.96. Refer to \[FilingDate in
   ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/FilingDate.xsd).
*)
type patentFilingDate = private string

val create_patentFilingDate : string -> patentFilingDate
val patentFilingDate_of_yojson : Yojson.Safe.t -> patentFilingDate
val yojson_of_patentFilingDate : patentFilingDate -> Yojson.Safe.t
val patentFilingDate_of_json : string -> patentFilingDate
val json_of_patentFilingDate : patentFilingDate -> string

module PatentFilingDate : sig
  type nonrec t = patentFilingDate
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The unique number assigned to a patent application when it is filed
   with a patent office. It is used to identify the specific application
   and track its progress through the examination process. Aligned with
   `ApplicationNumber` in ST.96. Refer to \[ApplicationIdentificationType
   in
   ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/ApplicationIdentificationType.xsd).
*)
type patentApplicationNumber = private string

val create_patentApplicationNumber : string -> patentApplicationNumber
val patentApplicationNumber_of_yojson : Yojson.Safe.t -> patentApplicationNumber
val yojson_of_patentApplicationNumber : patentApplicationNumber -> Yojson.Safe.t
val patentApplicationNumber_of_json : string -> patentApplicationNumber
val json_of_patentApplicationNumber : patentApplicationNumber -> string

module PatentApplicationNumber : sig
  type nonrec t = patentApplicationNumber
  val create : string -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The priorityApplication contains the essential data necessary to
   identify and reference an earlier patent filing for priority rights.
   In line with WIPO ST.96 guidelines, it includes the jurisdiction
   (office code), application number, and filing date-the three key
   elements that uniquely specify the priority application in a global
   patent context.
*)
type priorityApplication = {
  applicationNumber: patentApplicationNumber;
  jurisdiction: patentJurisdiction;
  filingDate: patentFilingDate;
}

val create_priorityApplication : applicationNumber:patentApplicationNumber -> jurisdiction:patentJurisdiction -> filingDate:patentFilingDate -> unit -> priorityApplication
val priorityApplication_of_yojson : Yojson.Safe.t -> priorityApplication
val yojson_of_priorityApplication : priorityApplication -> Yojson.Safe.t
val priorityApplication_of_json : string -> priorityApplication
val json_of_priorityApplication : priorityApplication -> string

module PriorityApplication : sig
  type nonrec t = priorityApplication
  val create : applicationNumber:patentApplicationNumber -> jurisdiction:patentJurisdiction -> filingDate:patentFilingDate -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Indicates the current legal status of the patent or patent
   application, based on the WIPO ST.27 standard. This status reflects
   administrative, procedural, or legal events. Values include both
   active and inactive states and are useful for determining
   enforceability, procedural history, and maintenance status.
*)
type patentPatentLegalStatus =
  | Pending
  | Granted
  | Revoked
  | Expired
  | Lapsed
  | Withdrawn
  | Abandoned
  | Suspended
  | Reinstated
  | Opposed
  | Terminated
  | Invalidated
  | Inforce

val patentPatentLegalStatus_of_yojson : Yojson.Safe.t -> patentPatentLegalStatus
val yojson_of_patentPatentLegalStatus : patentPatentLegalStatus -> Yojson.Safe.t
val patentPatentLegalStatus_of_json : string -> patentPatentLegalStatus
val json_of_patentPatentLegalStatus : patentPatentLegalStatus -> string

module PatentPatentLegalStatus : sig
  type nonrec t = patentPatentLegalStatus
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type patentPatentAssignee =
  | OrganizationalContact of organizationalContact
  | OrganizationalEntity of organizationalEntity

val patentPatentAssignee_of_yojson : Yojson.Safe.t -> patentPatentAssignee
val yojson_of_patentPatentAssignee : patentPatentAssignee -> Yojson.Safe.t
val patentPatentAssignee_of_json : string -> patentPatentAssignee
val json_of_patentPatentAssignee : patentPatentAssignee -> string

module PatentPatentAssignee : sig
  type nonrec t = patentPatentAssignee
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   A patent family is a group of related patent applications or granted
   patents that cover the same or similar invention. These patents are
   filed in multiple jurisdictions to protect the invention across
   different regions or countries. A patent family typically includes
   patents that share a common priority date, originating from the same
   initial application, and may vary slightly in scope or claims to
   comply with regional legal frameworks. Fields align with WIPO ST.96
   standards where applicable.
*)
type patentFamily = {
  bomref: refType option;
  familyId: string;
  (**
     The unique identifier for the patent family, aligned with the `id`
     attribute in WIPO ST.96 v8.0's `PatentFamilyType`. Refer to
     \[PatentFamilyType in
     ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/PatentFamilyType.xsd).
  *)
  priorityApplication: priorityApplication option;
  members: refLinkType list option;
  (**
     A collection of patents or applications that belong to this family,
     each identified by a `bom-ref` pointing to a patent object defined
     elsewhere in the BOM.
  *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
}

val create_patentFamily : ?bomref:refType -> familyId:string -> ?priorityApplication:priorityApplication -> ?members:refLinkType list -> ?externalReferences:externalReference list -> unit -> patentFamily
val patentFamily_of_yojson : Yojson.Safe.t -> patentFamily
val yojson_of_patentFamily : patentFamily -> Yojson.Safe.t
val patentFamily_of_json : string -> patentFamily
val json_of_patentFamily : patentFamily -> string

module PatentFamily : sig
  type nonrec t = patentFamily
  val create : ?bomref:refType -> familyId:string -> ?priorityApplication:priorityApplication -> ?members:refLinkType list -> ?externalReferences:externalReference list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   A patent is a legal instrument, granted by an authority, that confers
   certain rights over an invention for a specified period, contingent on
   public disclosure and adherence to relevant legal requirements. The
   summary information in this object is aligned with \[WIPO
   ST.96\](https://www.wipo.int/standards/en/st96/) principles where
   applicable.
*)
type patent = {
  bomref: refType option;
  patentNumber: string;
  (**
     The unique number assigned to the granted patent by the issuing
     authority. Aligned with `PatentNumber` in WIPO ST.96. Refer to
     \[PatentNumber in
     ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/PatentNumber.xsd).
  *)
  applicationNumber: patentApplicationNumber option;
  jurisdiction: patentJurisdiction;
  priorityApplication: priorityApplication option;
  publicationNumber: string option;
  (**
     This is the number assigned to a patent application once it is
     published. Patent applications are generally published 18 months after
     filing (unless an applicant requests non-publication). This number is
     distinct from the application number.

     Purpose: Identifies the publicly available version of the application.

     Format: Varies by jurisdiction, often similar to application numbers
     but includes an additional suffix indicating publication.

     Example: - US: US20240000123A1 (indicates the first publication of
     application US20240000123) - Europe: EP23123456A1 (first publication
     of European application EP23123456).

     WIPO ST.96 v8.0: - Publication Number field:
     https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/PublicationNumber.xsd
  *)
  title: string option;
  (**
     The title of the patent, summarising the invention it protects.
     Aligned with `InventionTitle` in WIPO ST.96. Refer to \[InventionTitle
     in
     ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/InventionTitle.xsd).
  *)
  abstract: string option;
  (**
     A brief summary of the invention described in the patent. Aligned with
     `Abstract` and `P` in WIPO ST.96. Refer to \[Abstract in
     ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/Abstract.xsd).
  *)
  filingDate: string option;
  (**
     The date the patent application was filed with the jurisdiction.
     Aligned with `FilingDate` in WIPO ST.96. Refer to \[FilingDate in
     ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/FilingDate.xsd).
  *)
  grantDate: string option;
  (**
     The date the patent was granted by the jurisdiction. Aligned with
     `GrantDate` in WIPO ST.96. Refer to \[GrantDate in
     ST.96\](https://www.wipo.int/standards/XMLSchema/ST96/V8_0/Patent/GrantDate.xsd).
  *)
  patentExpirationDate: string option;
  (**
     The date the patent expires. Derived from grant or filing date
     according to jurisdiction-specific rules.
  *)
  patentLegalStatus: patentPatentLegalStatus;
  (**
     Indicates the current legal status of the patent or patent
     application, based on the WIPO ST.27 standard. This status reflects
     administrative, procedural, or legal events. Values include both
     active and inactive states and are useful for determining
     enforceability, procedural history, and maintenance status.
  *)
  patentAssignee: patentPatentAssignee list option;
  (**
     A collection of organisations or individuals to whom the patent rights
     are assigned. This supports joint ownership and allows for flexible
     representation of both corporate entities and individual inventors.
  *)
  externalReferences: externalReference list option;
  (**
     External references provide a way to document systems, sites, and
     information that may be relevant but are not included with the BOM.
     They may also establish specific relationships within or external to
     the BOM.
  *)
}

val create_patent : ?bomref:refType -> patentNumber:string -> ?applicationNumber:patentApplicationNumber -> jurisdiction:patentJurisdiction -> ?priorityApplication:priorityApplication -> ?publicationNumber:string -> ?title:string -> ?abstract:string -> ?filingDate:string -> ?grantDate:string -> ?patentExpirationDate:string -> patentLegalStatus:patentPatentLegalStatus -> ?patentAssignee:patentPatentAssignee list -> ?externalReferences:externalReference list -> unit -> patent
val patent_of_yojson : Yojson.Safe.t -> patent
val yojson_of_patent : patent -> Yojson.Safe.t
val patent_of_json : string -> patent
val json_of_patent : patent -> string

module Patent : sig
  type nonrec t = patent
  val create : ?bomref:refType -> patentNumber:string -> ?applicationNumber:patentApplicationNumber -> jurisdiction:patentJurisdiction -> ?priorityApplication:priorityApplication -> ?publicationNumber:string -> ?title:string -> ?abstract:string -> ?filingDate:string -> ?grantDate:string -> ?patentExpirationDate:string -> patentLegalStatus:patentPatentLegalStatus -> ?patentAssignee:patentPatentAssignee list -> ?externalReferences:externalReference list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** A representation of a functional parameter. *)
type parameter = {
  name: string option;  (** The name of the parameter. *)
  value: string option;  (** The value of the parameter. *)
  dataType: string option;  (** The data type of the parameter. *)
}

val create_parameter : ?name:string -> ?value:string -> ?dataType:string -> unit -> parameter
val parameter_of_yojson : Yojson.Safe.t -> parameter
val yojson_of_parameter : parameter -> Yojson.Safe.t
val parameter_of_json : string -> parameter
val json_of_parameter : parameter -> string

module Parameter : sig
  type nonrec t = parameter
  val create : ?name:string -> ?value:string -> ?dataType:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_metadataToolsTools : ?components:component list -> ?services:service list -> unit -> metadataToolsTools
val metadataToolsTools_of_yojson : Yojson.Safe.t -> metadataToolsTools
val yojson_of_metadataToolsTools : metadataToolsTools -> Yojson.Safe.t
val metadataToolsTools_of_json : string -> metadataToolsTools
val json_of_metadataToolsTools : metadataToolsTools -> string

module MetadataToolsTools : sig
  type nonrec t = metadataToolsTools
  val create : ?components:component list -> ?services:service list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The tool(s) used in the creation, enrichment, and validation of the
   BOM.
*)
type metadataTools =
  | Tools of metadataToolsTools
  | ToolList of tool list

val metadataTools_of_yojson : Yojson.Safe.t -> metadataTools
val yojson_of_metadataTools : metadataTools -> Yojson.Safe.t
val metadataTools_of_json : string -> metadataTools
val json_of_metadataTools : metadataTools -> string

module MetadataTools : sig
  type nonrec t = metadataTools
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The product lifecycle(s) that this BOM represents. *)
type metadataLifecycles =
  | Jsonmetadatalifecycles_1 of json_
  | Jsonmetadatalifecycles_2 of json_

val metadataLifecycles_of_yojson : Yojson.Safe.t -> metadataLifecycles
val yojson_of_metadataLifecycles : metadataLifecycles -> Yojson.Safe.t
val metadataLifecycles_of_json : string -> metadataLifecycles
val json_of_metadataLifecycles : metadataLifecycles -> string

module MetadataLifecycles : sig
  type nonrec t = metadataLifecycles
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Conditions and constraints governing the sharing and distribution of
   the data or components described by this BOM.
*)
type metadataDistributionConstraints = {
  tlp: tlpClassification option;
}

val create_metadataDistributionConstraints : ?tlp:tlpClassification -> unit -> metadataDistributionConstraints
val metadataDistributionConstraints_of_yojson : Yojson.Safe.t -> metadataDistributionConstraints
val yojson_of_metadataDistributionConstraints : metadataDistributionConstraints -> Yojson.Safe.t
val metadataDistributionConstraints_of_json : string -> metadataDistributionConstraints
val json_of_metadataDistributionConstraints : metadataDistributionConstraints -> string

module MetadataDistributionConstraints : sig
  type nonrec t = metadataDistributionConstraints
  val create : ?tlp:tlpClassification -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  distributionConstraints: metadataDistributionConstraints option;
  (**
     Conditions and constraints governing the sharing and distribution of
     the data or components described by this BOM.
  *)
}

val create_metadata : ?timestamp:string -> ?lifecycles:metadataLifecycles list -> ?tools:metadataTools -> ?manufacturer:organizationalEntity -> ?authors:organizationalContact list -> ?component:component -> ?manufacture:organizationalEntity -> ?supplier:organizationalEntity -> ?licenses:licenseChoice -> ?properties:property list -> ?distributionConstraints:metadataDistributionConstraints -> unit -> metadata
val metadata_of_yojson : Yojson.Safe.t -> metadata
val yojson_of_metadata : metadata -> Yojson.Safe.t
val metadata_of_json : string -> metadata
val json_of_metadata : metadata -> string

module Metadata : sig
  type nonrec t = metadata
  val create : ?timestamp:string -> ?lifecycles:metadataLifecycles list -> ?tools:metadataTools -> ?manufacturer:organizationalEntity -> ?authors:organizationalContact list -> ?component:component -> ?manufacture:organizationalEntity -> ?supplier:organizationalEntity -> ?licenses:licenseChoice -> ?properties:property list -> ?distributionConstraints:metadataDistributionConstraints -> unit -> t
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

val create_formula : ?bomref:refType -> ?components:component list -> ?services:service list -> ?workflows:workflow list -> ?properties:property list -> unit -> formula
val formula_of_yojson : Yojson.Safe.t -> formula
val yojson_of_formula : formula -> Yojson.Safe.t
val formula_of_json : string -> formula
val json_of_formula : formula -> string

module Formula : sig
  type nonrec t = formula
  val create : ?bomref:refType -> ?components:component list -> ?services:service list -> ?workflows:workflow list -> ?properties:property list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type cycloneDXBillofMaterialsStandardDefinitionsPatents =
  | Patent of patent
  | PatentFamily of patentFamily

val cycloneDXBillofMaterialsStandardDefinitionsPatents_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDefinitionsPatents
val yojson_of_cycloneDXBillofMaterialsStandardDefinitionsPatents : cycloneDXBillofMaterialsStandardDefinitionsPatents -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDefinitionsPatents_of_json : string -> cycloneDXBillofMaterialsStandardDefinitionsPatents
val json_of_cycloneDXBillofMaterialsStandardDefinitionsPatents : cycloneDXBillofMaterialsStandardDefinitionsPatents -> string

module CycloneDXBillofMaterialsStandardDefinitionsPatents : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDefinitionsPatents
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  patents: cycloneDXBillofMaterialsStandardDefinitionsPatents list option;  (** The list of either individual patents or patent families. *)
}

val create_cycloneDXBillofMaterialsStandardDefinitions : ?standards:standard list -> ?patents:cycloneDXBillofMaterialsStandardDefinitionsPatents list -> unit -> cycloneDXBillofMaterialsStandardDefinitions
val cycloneDXBillofMaterialsStandardDefinitions_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDefinitions
val yojson_of_cycloneDXBillofMaterialsStandardDefinitions : cycloneDXBillofMaterialsStandardDefinitions -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDefinitions_of_json : string -> cycloneDXBillofMaterialsStandardDefinitions
val json_of_cycloneDXBillofMaterialsStandardDefinitions : cycloneDXBillofMaterialsStandardDefinitions -> string

module CycloneDXBillofMaterialsStandardDefinitions : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDefinitions
  val create : ?standards:standard list -> ?patents:cycloneDXBillofMaterialsStandardDefinitionsPatents list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(** The list of targets which claims are made against. *)
type cycloneDXBillofMaterialsStandardDeclarationsTargets = {
  organizations: organizationalEntity list option;  (** The list of organizations which claims are made against. *)
  components: component list option;  (** The list of components which claims are made against. *)
  services: service list option;  (** The list of services which claims are made against. *)
}

val create_cycloneDXBillofMaterialsStandardDeclarationsTargets : ?organizations:organizationalEntity list -> ?components:component list -> ?services:service list -> unit -> cycloneDXBillofMaterialsStandardDeclarationsTargets
val cycloneDXBillofMaterialsStandardDeclarationsTargets_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsTargets
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsTargets : cycloneDXBillofMaterialsStandardDeclarationsTargets -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsTargets_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsTargets
val json_of_cycloneDXBillofMaterialsStandardDeclarationsTargets : cycloneDXBillofMaterialsStandardDeclarationsTargets -> string

module CycloneDXBillofMaterialsStandardDeclarationsTargets : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsTargets
  val create : ?organizations:organizationalEntity list -> ?components:component list -> ?services:service list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   The contents or references to the contents of the data being
   described.
*)
type cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents = {
  attachment: attachment option;
  url: string option;  (** The URL to where the data can be retrieved. *)
}

val create_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents : ?attachment:attachment -> ?url:string -> unit -> cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
val cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents : cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
val json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents : cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents -> string

module CycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents
  val create : ?attachment:attachment -> ?url:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData : ?name:string -> ?contents:cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents -> ?classification:dataClassification -> ?sensitiveData:string list -> ?governance:dataGovernance -> unit -> cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
val cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData : cycloneDXBillofMaterialsStandardDeclarationsEvidenceData -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsEvidenceData_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
val json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidenceData : cycloneDXBillofMaterialsStandardDeclarationsEvidenceData -> string

module CycloneDXBillofMaterialsStandardDeclarationsEvidenceData : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsEvidenceData
  val create : ?name:string -> ?contents:cycloneDXBillofMaterialsStandardDeclarationsEvidenceDataContents -> ?classification:dataClassification -> ?sensitiveData:string list -> ?governance:dataGovernance -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
  expires: string option;  (** The date and time (timestamp) when the evidence is no longer valid. *)
  author: organizationalContact option;
  reviewer: organizationalContact option;
  signature: signature option;
}

val create_cycloneDXBillofMaterialsStandardDeclarationsEvidence : ?bomref:refType -> ?propertyName:string -> ?description:string -> ?data:cycloneDXBillofMaterialsStandardDeclarationsEvidenceData list -> ?created:string -> ?expires:string -> ?author:organizationalContact -> ?reviewer:organizationalContact -> ?signature:signature -> unit -> cycloneDXBillofMaterialsStandardDeclarationsEvidence
val cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsEvidence
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence : cycloneDXBillofMaterialsStandardDeclarationsEvidence -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsEvidence_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsEvidence
val json_of_cycloneDXBillofMaterialsStandardDeclarationsEvidence : cycloneDXBillofMaterialsStandardDeclarationsEvidence -> string

module CycloneDXBillofMaterialsStandardDeclarationsEvidence : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsEvidence
  val create : ?bomref:refType -> ?propertyName:string -> ?description:string -> ?data:cycloneDXBillofMaterialsStandardDeclarationsEvidenceData list -> ?created:string -> ?expires:string -> ?author:organizationalContact -> ?reviewer:organizationalContact -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarationsClaims : ?bomref:refType -> ?target:refLinkType -> ?predicate:string -> ?mitigationStrategies:refLinkType list -> ?reasoning:string -> ?evidence:refLinkType list -> ?counterEvidence:refLinkType list -> ?externalReferences:externalReference list -> ?signature:signature -> unit -> cycloneDXBillofMaterialsStandardDeclarationsClaims
val cycloneDXBillofMaterialsStandardDeclarationsClaims_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsClaims
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsClaims : cycloneDXBillofMaterialsStandardDeclarationsClaims -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsClaims_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsClaims
val json_of_cycloneDXBillofMaterialsStandardDeclarationsClaims : cycloneDXBillofMaterialsStandardDeclarationsClaims -> string

module CycloneDXBillofMaterialsStandardDeclarationsClaims : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsClaims
  val create : ?bomref:refType -> ?target:refLinkType -> ?predicate:string -> ?mitigationStrategies:refLinkType list -> ?reasoning:string -> ?evidence:refLinkType list -> ?counterEvidence:refLinkType list -> ?externalReferences:externalReference list -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance : ?score:float -> ?rationale:string -> ?mitigationStrategies:refLinkType list -> unit -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
val cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
val json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance -> string

module CycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance
  val create : ?score:float -> ?rationale:string -> ?mitigationStrategies:refLinkType list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence : ?score:float -> ?rationale:string -> unit -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
val cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
val json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence -> string

module CycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence
  val create : ?score:float -> ?rationale:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap = {
  requirement: refLinkType option;
  claims: refLinkType list option;  (** The list of `bom-ref` to the claims being attested to. *)
  counterClaims: refLinkType list option;  (** The list of `bom-ref` to the counter claims being attested to. *)
  conformance: cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance option;  (** The conformance of the claim meeting a requirement. *)
  confidence: cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence option;  (** The confidence of the claim meeting the requirement. *)
}

val create_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap : ?requirement:refLinkType -> ?claims:refLinkType list -> ?counterClaims:refLinkType list -> ?conformance:cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance -> ?confidence:cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence -> unit -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
val cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
val json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap : cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap -> string

module CycloneDXBillofMaterialsStandardDeclarationsAttestationsMap : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap
  val create : ?requirement:refLinkType -> ?claims:refLinkType list -> ?counterClaims:refLinkType list -> ?conformance:cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConformance -> ?confidence:cycloneDXBillofMaterialsStandardDeclarationsAttestationsMapConfidence -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarationsAttestations : ?summary:string -> ?assessor:refLinkType -> ?map:cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap list -> ?signature:signature -> unit -> cycloneDXBillofMaterialsStandardDeclarationsAttestations
val cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsAttestations
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations : cycloneDXBillofMaterialsStandardDeclarationsAttestations -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsAttestations_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsAttestations
val json_of_cycloneDXBillofMaterialsStandardDeclarationsAttestations : cycloneDXBillofMaterialsStandardDeclarationsAttestations -> string

module CycloneDXBillofMaterialsStandardDeclarationsAttestations : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAttestations
  val create : ?summary:string -> ?assessor:refLinkType -> ?map:cycloneDXBillofMaterialsStandardDeclarationsAttestationsMap list -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarationsAssessors : ?bomref:refType -> ?thirdParty:bool -> ?organization:organizationalEntity -> unit -> cycloneDXBillofMaterialsStandardDeclarationsAssessors
val cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsAssessors
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors : cycloneDXBillofMaterialsStandardDeclarationsAssessors -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsAssessors_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsAssessors
val json_of_cycloneDXBillofMaterialsStandardDeclarationsAssessors : cycloneDXBillofMaterialsStandardDeclarationsAssessors -> string

module CycloneDXBillofMaterialsStandardDeclarationsAssessors : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAssessors
  val create : ?bomref:refType -> ?thirdParty:bool -> ?organization:organizationalEntity -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories =
  | JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_1 of json_
  | JsonCycloneDXBillofMaterialsStandarddeclarationsaffirmationsignatories_2 of json_

val cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories : cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories
val json_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories : cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories -> string

module CycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarationsAffirmation : ?statement:string -> ?signatories:cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories list -> ?signature:signature -> unit -> cycloneDXBillofMaterialsStandardDeclarationsAffirmation
val cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarationsAffirmation
val yojson_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation : cycloneDXBillofMaterialsStandardDeclarationsAffirmation -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarationsAffirmation_of_json : string -> cycloneDXBillofMaterialsStandardDeclarationsAffirmation
val json_of_cycloneDXBillofMaterialsStandardDeclarationsAffirmation : cycloneDXBillofMaterialsStandardDeclarationsAffirmation -> string

module CycloneDXBillofMaterialsStandardDeclarationsAffirmation : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarationsAffirmation
  val create : ?statement:string -> ?signatories:cycloneDXBillofMaterialsStandardDeclarationsAffirmationSignatories list -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_cycloneDXBillofMaterialsStandardDeclarations : ?assessors:cycloneDXBillofMaterialsStandardDeclarationsAssessors list -> ?attestations:cycloneDXBillofMaterialsStandardDeclarationsAttestations list -> ?claims:cycloneDXBillofMaterialsStandardDeclarationsClaims list -> ?evidence:cycloneDXBillofMaterialsStandardDeclarationsEvidence list -> ?targets:cycloneDXBillofMaterialsStandardDeclarationsTargets -> ?affirmation:cycloneDXBillofMaterialsStandardDeclarationsAffirmation -> ?signature:signature -> unit -> cycloneDXBillofMaterialsStandardDeclarations
val cycloneDXBillofMaterialsStandardDeclarations_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardDeclarations
val yojson_of_cycloneDXBillofMaterialsStandardDeclarations : cycloneDXBillofMaterialsStandardDeclarations -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardDeclarations_of_json : string -> cycloneDXBillofMaterialsStandardDeclarations
val json_of_cycloneDXBillofMaterialsStandardDeclarations : cycloneDXBillofMaterialsStandardDeclarations -> string

module CycloneDXBillofMaterialsStandardDeclarations : sig
  type nonrec t = cycloneDXBillofMaterialsStandardDeclarations
  val create : ?assessors:cycloneDXBillofMaterialsStandardDeclarationsAssessors list -> ?attestations:cycloneDXBillofMaterialsStandardDeclarationsAttestations list -> ?claims:cycloneDXBillofMaterialsStandardDeclarationsClaims list -> ?evidence:cycloneDXBillofMaterialsStandardDeclarationsEvidence list -> ?targets:cycloneDXBillofMaterialsStandardDeclarationsTargets -> ?affirmation:cycloneDXBillofMaterialsStandardDeclarationsAffirmation -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Specifies the format of the BOM. This helps to identify the file as
   CycloneDX since BOMs do not have a filename convention, nor does JSON
   schema support namespaces. This value must be "CycloneDX".
*)
type cycloneDXBillofMaterialsStandardBomFormat =
  | CycloneDX

val cycloneDXBillofMaterialsStandardBomFormat_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandardBomFormat
val yojson_of_cycloneDXBillofMaterialsStandardBomFormat : cycloneDXBillofMaterialsStandardBomFormat -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandardBomFormat_of_json : string -> cycloneDXBillofMaterialsStandardBomFormat
val json_of_cycloneDXBillofMaterialsStandardBomFormat : cycloneDXBillofMaterialsStandardBomFormat -> string

module CycloneDXBillofMaterialsStandardBomFormat : sig
  type nonrec t = cycloneDXBillofMaterialsStandardBomFormat
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type compositionsAssemblies =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

val compositionsAssemblies_of_yojson : Yojson.Safe.t -> compositionsAssemblies
val yojson_of_compositionsAssemblies : compositionsAssemblies -> Yojson.Safe.t
val compositionsAssemblies_of_json : string -> compositionsAssemblies
val json_of_compositionsAssemblies : compositionsAssemblies -> string

module CompositionsAssemblies : sig
  type nonrec t = compositionsAssemblies
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val aggregateType_of_yojson : Yojson.Safe.t -> aggregateType
val yojson_of_aggregateType : aggregateType -> Yojson.Safe.t
val aggregateType_of_json : string -> aggregateType
val json_of_aggregateType : aggregateType -> string

module AggregateType : sig
  type nonrec t = aggregateType
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_compositions : ?bomref:refType -> aggregate:aggregateType -> ?assemblies:compositionsAssemblies list -> ?dependencies:string list -> ?vulnerabilities:string list -> ?signature:signature -> unit -> compositions
val compositions_of_yojson : Yojson.Safe.t -> compositions
val yojson_of_compositions : compositions -> Yojson.Safe.t
val compositions_of_json : string -> compositions
val json_of_compositions : compositions -> string

module Compositions : sig
  type nonrec t = compositions
  val create : ?bomref:refType -> aggregate:aggregateType -> ?assemblies:compositionsAssemblies list -> ?dependencies:string list -> ?vulnerabilities:string list -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

(**
   Details a specific attribution of data within the BOM to a
   contributing entity or process.
*)
type citation =
  | Jsoncitation_1 of json_
  | Jsoncitation_2 of json_

val citation_of_yojson : Yojson.Safe.t -> citation
val yojson_of_citation : citation -> Yojson.Safe.t
val citation_of_json : string -> citation
val json_of_citation : citation -> string

module Citation : sig
  type nonrec t = citation
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type annotationsSubjects =
  | RefLinkType of refLinkType
  | BomLinkElementType of bomLinkElementType

val annotationsSubjects_of_yojson : Yojson.Safe.t -> annotationsSubjects
val yojson_of_annotationsSubjects : annotationsSubjects -> Yojson.Safe.t
val annotationsSubjects_of_json : string -> annotationsSubjects
val json_of_annotationsSubjects : annotationsSubjects -> string

module AnnotationsSubjects : sig
  type nonrec t = annotationsSubjects
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val annotationsAnnotator_of_yojson : Yojson.Safe.t -> annotationsAnnotator
val yojson_of_annotationsAnnotator : annotationsAnnotator -> Yojson.Safe.t
val annotationsAnnotator_of_json : string -> annotationsAnnotator
val json_of_annotationsAnnotator : annotationsAnnotator -> string

module AnnotationsAnnotator : sig
  type nonrec t = annotationsAnnotator
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_annotations : ?bomref:refType -> subjects:annotationsSubjects list -> annotator:annotationsAnnotator -> timestamp:string -> text:string -> ?signature:signature -> unit -> annotations
val annotations_of_yojson : Yojson.Safe.t -> annotations
val yojson_of_annotations : annotations -> Yojson.Safe.t
val annotations_of_json : string -> annotations
val json_of_annotations : annotations -> string

module Annotations : sig
  type nonrec t = annotations
  val create : ?bomref:refType -> subjects:annotationsSubjects list -> annotator:annotationsAnnotator -> timestamp:string -> text:string -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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
     Describes the formulation of any referencable object within the BOM,
     including components, services, metadata, declarations, or the BOM
     itself. This may encompass how the object was created, assembled,
     deployed, tested, certified, or otherwise brought into its present
     form. Common examples include software build pipelines, deployment
     processes, AI/ML model training, cryptographic key generation or
     certification, and third-party audits. Processes are modeled using
     declared and observed formulas, composed of workflows, tasks, and
     individual steps.
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
  citations: citation list option;
  (**
     A collection of attributions indicating which entity supplied
     information for specific fields within the BOM.
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

val create_cycloneDXBillofMaterialsStandard : ?schema:string -> bomFormat:cycloneDXBillofMaterialsStandardBomFormat -> specVersion:string -> ?serialNumber:string -> ?version:int -> ?metadata:metadata -> ?components:component list -> ?services:service list -> ?externalReferences:externalReference list -> ?dependencies:dependency list -> ?compositions:compositions list -> ?vulnerabilities:vulnerability list -> ?annotations:annotations list -> ?formulation:formula list -> ?declarations:cycloneDXBillofMaterialsStandardDeclarations -> ?definitions:cycloneDXBillofMaterialsStandardDefinitions -> ?citations:citation list -> ?properties:property list -> ?signature:signature -> unit -> cycloneDXBillofMaterialsStandard
val cycloneDXBillofMaterialsStandard_of_yojson : Yojson.Safe.t -> cycloneDXBillofMaterialsStandard
val yojson_of_cycloneDXBillofMaterialsStandard : cycloneDXBillofMaterialsStandard -> Yojson.Safe.t
val cycloneDXBillofMaterialsStandard_of_json : string -> cycloneDXBillofMaterialsStandard
val json_of_cycloneDXBillofMaterialsStandard : cycloneDXBillofMaterialsStandard -> string

module CycloneDXBillofMaterialsStandard : sig
  type nonrec t = cycloneDXBillofMaterialsStandard
  val create : ?schema:string -> bomFormat:cycloneDXBillofMaterialsStandardBomFormat -> specVersion:string -> ?serialNumber:string -> ?version:int -> ?metadata:metadata -> ?components:component list -> ?services:service list -> ?externalReferences:externalReference list -> ?dependencies:dependency list -> ?compositions:compositions list -> ?vulnerabilities:vulnerability list -> ?annotations:annotations list -> ?formulation:formula list -> ?declarations:cycloneDXBillofMaterialsStandardDeclarations -> ?definitions:cycloneDXBillofMaterialsStandardDefinitions -> ?citations:citation list -> ?properties:property list -> ?signature:signature -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val affectedStatus_of_yojson : Yojson.Safe.t -> affectedStatus
val yojson_of_affectedStatus : affectedStatus -> Yojson.Safe.t
val affectedStatus_of_json : string -> affectedStatus
val json_of_affectedStatus : affectedStatus -> string

module AffectedStatus : sig
  type nonrec t = affectedStatus
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

