(*
   SPDX 2.3.1 and 3.0.1 export.

   References:
   - SPDX 2.3 specification: https://spdx.github.io/spdx-spec/v2.3/
   - SPDX 3.0.1 specification: https://spdx.github.io/spdx-3-model/
*)

module S = Sbom_types.Ocaml_sbom
module P = Spdx_2_3_1_dev
module T = Spdx_3_0_1

(* --- Shared utilities ------------------------------------------------------ *)

let current_timestamp () =
  let tm = Unix.gmtime (Unix.gettimeofday ()) in
  Printf.sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ" (tm.Unix.tm_year + 1900)
    (tm.Unix.tm_mon + 1) tm.Unix.tm_mday tm.Unix.tm_hour tm.Unix.tm_min
    tm.Unix.tm_sec

(* Replace characters not legal in SPDX element IDs with '-'. *)
let sanitize_for_id s =
  String.map
    (fun c ->
      if
        (c >= 'a' && c <= 'z')
        || (c >= 'A' && c <= 'Z')
        || (c >= '0' && c <= '9')
        || c = '-' || c = '.'
      then c
      else '-')
    s

let spdx_ref_of_purl (purl : Sbom_types.Purl.t) =
  "SPDXRef-" ^ sanitize_for_id (purl :> string)

let license_atom_to_string (atom : S.license_atom) =
  match atom with
  | Spdx_id id -> id
  | License_ref lr -> lr.id

let rec license_expr_to_string (expr : S.license_expr) =
  match expr with
  | Atom atom -> license_atom_to_string atom
  | And (a, b) ->
      Printf.sprintf "(%s AND %s)" (license_expr_to_string a)
        (license_expr_to_string b)
  | Or (a, b) ->
      Printf.sprintf "(%s OR %s)" (license_expr_to_string a)
        (license_expr_to_string b)
  | With (atom, exc) ->
      Printf.sprintf "%s WITH %s" (license_atom_to_string atom) exc

let known_license_str (k : S.license_expr S.known) =
  match k with
  | Known expr -> Some (license_expr_to_string expr)
  | _ -> None

let known_license_str_noassertion (k : S.license_expr S.known) =
  match known_license_str k with
  | Some s -> s
  | None -> "NOASSERTION"

(* SPDX's downloadLocation must be NONE, NOASSERTION, or a URL matching a
   strict pattern that excludes file:// paths. Return None for URLs we cannot
   use, so callers can substitute NOASSERTION or omit the field. *)
let spdx_download_url (url : string) : string option =
  if url = "" || (String.length url >= 7 && String.sub url 0 7 = "file://") then
    None
  else Some url

let doc_name (doc : S.document) =
  match doc.components with
  | [] -> "SBOM"
  | c :: _ -> c.name

(* --- SPDX 2.3 export ------------------------------------------------------- *)

(* Return type annotation disambiguates MD5/SHA256/SHA512 across generated types. *)
let checksum_alg_2_3 (kind : S.checksum_kind) :
    P.sPDX231devPackagesChecksumsAlgorithm =
  match kind with
  | MD5 -> MD5
  | SHA256 -> SHA256
  | SHA512 -> SHA512

let scope_to_rel_type (scope : S.dep_scope) =
  match scope with
  | All -> P.DEPENDENCY_OF
  | Build -> P.BUILD_DEPENDENCY_OF
  | Test -> P.TEST_DEPENDENCY_OF
  | Dev -> P.DEV_DEPENDENCY_OF
  | Doc -> P.OPTIONAL_DEPENDENCY_OF

let component_to_package (c : S.component) : P.sPDX231devPackages =
  let checksums =
    match c.source_distribution.checksums with
    | [] -> None
    | cs ->
        Some
          (List.map
             (fun (cs : S.checksum) ->
               P.create_sPDX231devPackagesChecksums
                 ~algorithm:(checksum_alg_2_3 cs.kind) ~checksumValue:cs.value
                 ())
             cs)
  in
  let download_location =
    Option.value
      (spdx_download_url c.source_distribution.url)
      ~default:"NOASSERTION"
  in
  let external_refs =
    Some
      [
        P.create_sPDX231devPackagesExternalRefs
          ~referenceCategory:PACKAGEMANAGER ~referenceType:"purl"
          ~referenceLocator:(c.key :> string)
          ();
      ]
  in
  P.create_sPDX231devPackages ~sPDXID:(spdx_ref_of_purl c.key) ~name:c.name
    ~versionInfo:c.version ~downloadLocation:download_location
    ~filesAnalyzed:false
    ~licenseDeclared:(known_license_str_noassertion c.licensing.declared)
    ~licenseConcluded:(known_license_str_noassertion c.licensing.concluded)
    ?checksums ?externalRefs:external_refs ?description:c.description ()

let edges_to_relationships (edges : S.dep_edge list) :
    P.sPDX231devRelationships list =
  (* {dst} SCOPE_DEPENDENCY_OF {src} means dst is a dep of src, matching
     our dep_edge direction where src depends on dst. *)
  List.map
    (fun (e : S.dep_edge) ->
      P.create_sPDX231devRelationships ~spdxElementId:(spdx_ref_of_purl e.dst)
        ~relatedSpdxElement:(spdx_ref_of_purl e.src)
        ~relationshipType:(scope_to_rel_type e.scope)
        ())
    edges

let root_relationships (roots : Sbom_types.Purl.t list) :
    P.sPDX231devRelationships list =
  List.map
    (fun purl ->
      P.create_sPDX231devRelationships ~spdxElementId:"SPDXRef-DOCUMENT"
        ~relatedSpdxElement:(spdx_ref_of_purl purl) ~relationshipType:DESCRIBES
        ())
    roots

let to_spdx_2_3 (doc : S.document) : P.sPDX231dev =
  let ts = current_timestamp () in
  let creation_info =
    P.create_sPDX231devCreationInfo ~created:ts ~creators:[ "Tool: ocaml-sbom" ]
      ()
  in
  let packages = List.map component_to_package doc.components in
  let relationships =
    root_relationships doc.root_components
    @ edges_to_relationships doc.dep_edges
  in
  P.create_sPDX231dev ~sPDXID:"SPDXRef-DOCUMENT" ~spdxVersion:"SPDX-2.3"
    ~dataLicense:"CC0-1.0" ~name:(doc_name doc)
    ~documentNamespace:("https://ocaml-sbom.dev/" ^ doc.namespace)
    ~creationInfo:creation_info ~packages ~relationships ()

(* --- SPDX 3.0 export ------------------------------------------------------- *)

let lifecycle_scope_3_0 (scope : S.dep_scope) : T.lifecycle_scope option =
  match scope with
  | All -> None
  | Build -> Some Build
  | Test -> Some Test
  | Dev -> Some Development
  | Doc -> Some Other

let to_spdx_3_0 (doc : S.document) : T.root_json =
  let ts = current_timestamp () in
  let ns_base = "https://ocaml-sbom.dev/" ^ doc.namespace in
  let tool_id = T.create_iri (ns_base ^ "#tool") in
  let spdx_id_of_purl (p : Sbom_types.Purl.t) =
    T.create_iri (ns_base ^ "#" ^ sanitize_for_id (p :> string))
  in
  let dep_rel_id i = T.create_iri (Printf.sprintf "%s#rel-%d" ns_base i) in
  let creation_info =
    T.create_creation_info ~type_:"CreationInfo" ~spec_version:"3.0.1"
      ~created:ts ~created_by:[ tool_id ] ()
  in
  let tool =
    T.Tool (T.create_tool ~spdx_id:tool_id ~name:"ocaml-sbom" ~creation_info ())
  in
  (* Build license expression elements.
     Each unique license string becomes one simplelicensing_LicenseExpression
     element. We assign IRIs by index to keep them stable. *)
  let license_strings : (string * T.iri) list =
    let seen = Hashtbl.create 16 in
    let result = ref [] in
    let idx = ref 0 in
    List.iter
      (fun (c : S.component) ->
        List.iter
          (fun s ->
            if not (Hashtbl.mem seen s) then begin
              let iri =
                T.create_iri (Printf.sprintf "%s#lic-%d" ns_base !idx)
              in
              Hashtbl.add seen s iri;
              result := (s, iri) :: !result;
              incr idx
            end)
          (List.filter_map Fun.id
             [
               known_license_str c.licensing.declared;
               known_license_str c.licensing.concluded;
             ]))
      doc.components;
    !result
  in
  let lic_iri_of_str s = List.assoc s license_strings in
  (* License expression graph elements *)
  let lic_elements =
    List.map
      (fun (expr_str, iri) ->
        T.SimpleLicensing_LicenseExpression
          (T.create_simplelicensing_license_expression ~spdx_id:iri
             ~creation_info ~license_expression:expr_str ()))
      license_strings
  in
  (* Per-package hasDeclaredLicense / hasConcludedLicense relationships *)
  let lic_rel_counter = ref 0 in
  let lic_relationships =
    List.concat_map
      (fun (c : S.component) ->
        let make_rel rel_type expr_opt =
          match expr_opt with
          | None -> []
          | Some s ->
              let i = !lic_rel_counter in
              incr lic_rel_counter;
              [
                T.Relationship
                  (T.create_relationship
                     ~spdx_id:
                       (T.create_iri (Printf.sprintf "%s#lic-rel-%d" ns_base i))
                     ~creation_info ~from_:(spdx_id_of_purl c.key)
                     ~to_:[ lic_iri_of_str s ]
                     ~relationship_type:rel_type ());
              ]
        in
        make_rel T.HasDeclaredLicense (known_license_str c.licensing.declared)
        @ make_rel T.HasConcludedLicense
            (known_license_str c.licensing.concluded))
      doc.components
  in
  let lic_element_iris = List.map snd license_strings in
  let lic_rel_iris =
    List.filter_map
      (function
        | T.Relationship r -> Some r.spdx_id
        | _ -> None)
      lic_relationships
  in
  let packages =
    List.map
      (fun (c : S.component) ->
        T.Software_Package
          (T.create_software_package ~spdx_id:(spdx_id_of_purl c.key)
             ~name:c.name ~creation_info ~software_package_version:c.version
             ~software_package_url:(T.create_iri (c.key :> string))
             ?software_download_location:
               (spdx_download_url c.source_distribution.url)
             ?description:c.description ()))
      doc.components
  in
  let dep_relationships =
    List.mapi
      (fun i (e : S.dep_edge) ->
        T.LifecycleScopedRelationship
          (T.create_lifecycle_scoped_relationship ~spdx_id:(dep_rel_id i)
             ~creation_info ~from_:(spdx_id_of_purl e.src)
             ~to_:[ spdx_id_of_purl e.dst ]
             ~relationship_type:DependsOn
             ?scope:(lifecycle_scope_3_0 e.scope)
             ()))
      doc.dep_edges
  in
  let spdx_doc =
    T.SpdxDocument
      (T.create_spdx_document ~spdx_id:(T.create_iri ns_base)
         ~name:(doc_name doc) ~creation_info
         ~element:
           (List.map
              (fun (c : S.component) -> spdx_id_of_purl c.key)
              doc.components
           @ List.mapi (fun i _ -> dep_rel_id i) doc.dep_edges
           @ lic_element_iris @ lic_rel_iris)
         ~root_element:(List.map spdx_id_of_purl doc.root_components)
         ())
  in
  T.create_root_json ~context:"https://spdx.github.io/spdx-3-model/context.json"
    ~graph:
      ([ spdx_doc; tool ] @ packages @ dep_relationships @ lic_elements
     @ lic_relationships)
    ()
