(*
   CycloneDX 1.6 export.

   Converts an internal ocaml-sbom document to a CycloneDX 1.6 BOM.

   References:
   - Specification overview: https://cyclonedx.org/specification/overview/
   - JSON schema: https://cyclonedx.org/schema/bom-1.6.schema.json
   - License representation: https://cyclonedx.org/docs/1.6/json/#components_items_licenses
   - Dependency graph: https://cyclonedx.org/docs/1.6/json/#dependencies
*)

module S = Sbom_types.Ocaml_sbom
module C = CycloneDX_1_6

let deduplicate xs =
  let seen = Hashtbl.create 10 in
  xs
  |> List.filter (fun x ->
      if Hashtbl.mem seen x then false
      else (
        Hashtbl.add seen x ();
        true))

(* --- Licenses ------------------------------------------------------------ *)

let license_atom_to_string (atom : S.license_atom) : string =
  match atom with
  | Spdx_id id -> id
  | License_ref lr -> lr.id

let rec license_expr_to_string (expr : S.license_expr) : string =
  match expr with
  | Atom atom -> license_atom_to_string atom
  | And (a, b) ->
      Printf.sprintf "(%s AND %s)" (license_expr_to_string a)
        (license_expr_to_string b)
  | Or (a, b) ->
      Printf.sprintf "(%s OR %s)" (license_expr_to_string a)
        (license_expr_to_string b)
  | With (atom, exception_id) ->
      Printf.sprintf "%s WITH %s" (license_atom_to_string atom) exception_id

(* CDX 1.6 SPDX expression form: [{"expression": "...", "acknowledgement": "..."}].
   The JsonList variant of licenseChoice carries this as raw JSON. *)
let make_license_json (expr : S.license_expr) (ack : string) : C.licenseChoice =
  C.JsonList
    [
      `Assoc
        [
          ("expression", `String (license_expr_to_string expr));
          ("acknowledgement", `String ack);
        ];
    ]

(* Prefer declared over concluded; emit nothing if both are Unknown/Known_none. *)
let licensing_to_cdx (lic : S.licensing) : C.licenseChoice option =
  match (lic.declared, lic.concluded) with
  | Known expr, _ -> Some (make_license_json expr "declared")
  | _, Known expr -> Some (make_license_json expr "concluded")
  | _ -> None

(* --- Checksums ----------------------------------------------------------- *)

let checksum_alg (kind : S.checksum_kind) : C.hashalg =
  match kind with
  | MD5 -> C.MD5
  | SHA256 -> C.SHA256
  | SHA512 -> C.SHA512

let checksum_to_cdx (cs : S.checksum) : C.hash =
  C.create_hash ~alg:(checksum_alg cs.kind)
    ~content:(C.create_hashcontent cs.value)
    ()

(* --- External references ------------------------------------------------- *)

let opt_ext_ref (url : string option) (type_ : C.externalReferenceType) :
    C.externalReference option =
  Option.map
    (fun url -> C.create_externalReference ~url:(C.String url) ~type_ ())
    url

let external_refs_of_component (c : S.component) : C.externalReference list =
  let sd = c.source_distribution in
  let src_ref =
    match sd.url with
    | None -> None
    | Some url ->
        let hashes = List.map checksum_to_cdx sd.checksums in
        Some
          (C.create_externalReference ~url:(C.String url)
             ~type_:C.Sourcedistribution ~hashes ())
  in
  List.filter_map Fun.id
    [
      src_ref;
      opt_ext_ref c.homepage_url C.Website;
      opt_ext_ref c.doc_url C.Documentation;
      opt_ext_ref c.bug_reports_url C.Issuetracker;
      opt_ext_ref c.dev_repo_url C.Vcs;
    ]

(* --- Authors ------------------------------------------------------------- *)

let actor_to_contact (actor : S.actor) : C.organizationalContact =
  match actor with
  | Person p -> C.create_organizationalContact ~name:p.name ?email:p.email ()
  | Organization o ->
      C.create_organizationalContact ~name:o.name ?email:o.email ()

(* --- Scope aggregation --------------------------------------------------- *)

(* CDX scope is per-node; ours is per-edge. Derive node scope by aggregating
   all incoming edges: any Runtime or Build edge makes the component Required. *)
let cdx_scope (s : S.dep_scope) : C.componentScope =
  match s with
  | All -> C.Required
  | Build
  | Test
  | Dev
  | Doc ->
      C.Optional

(* Emit a more detailed scope as a custom property. It uses the
   name of the corresponding Opam dependency flags when possible.

   See https://github.com/CycloneDX/cyclonedx-property-taxonomy/blob/main/cdx.md
   TODO: register the "cdx:opam:" namespace at the URL above.
*)
let opam_property_of_scope (scope : S.dep_scope) : C.property =
  let prop value = C.create_property ~name:"cdx:opam:scope" ~value () in
  match scope with
  | All -> prop "all"
  | Build -> prop "build"
  | Test -> prop "with-test"
  | Dev -> prop "with-dev-setup"
  | Doc -> prop "with-doc"

(* Prepare scope list that's as close as possible to Opam's filters *)
let normalize_opam_scopes (scopes : S.dep_scope list) : S.dep_scope list =
  if List.mem S.All scopes then [ S.All ] else scopes

let merge_scopes (scopes : S.dep_scope list) :
    C.componentScope * C.property list =
  let scopes = scopes |> deduplicate |> normalize_opam_scopes in
  let cdx_scopes = List.map cdx_scope scopes in
  let cdx_scope =
    if List.mem C.Required cdx_scopes then C.Required else C.Optional
  in
  let properties = List.map opam_property_of_scope scopes in
  (cdx_scope, properties)

let build_scope_map (edges : S.dep_edge list) :
    (string, S.dep_scope list) Hashtbl.t =
  let tbl = Hashtbl.create 64 in
  List.iter
    (fun (e : S.dep_edge) ->
      let purl = (e.dst :> string) in
      let scope = e.scope in
      match Hashtbl.find_opt tbl purl with
      | None -> Hashtbl.add tbl purl [ scope ]
      | Some scopes -> Hashtbl.replace tbl purl (scope :: scopes))
    edges;
  tbl

(* --- Component conversion ------------------------------------------------ *)

let component_to_cdx (scope_map : (string, S.dep_scope list) Hashtbl.t)
    (c : S.component) : C.component =
  let type_ =
    match c.kind with
    | Opam_package (Known { library = true; executable = false }) -> C.Library
    | Opam_package _ ->
        (* default prescribed by CycloneDX *)
        C.Application
  in
  let purl = (c.key :> string) in
  let licenses = licensing_to_cdx c.licensing in
  let ext_refs =
    match external_refs_of_component c with
    | [] -> None
    | refs -> Some refs
  in
  let authors =
    match c.authors @ c.maintainers |> deduplicate with
    | [] -> None
    | cs -> Some (List.map actor_to_contact cs)
  in
  let hashes =
    match c.source_distribution.checksums with
    | [] -> None
    | cs -> Some (List.map checksum_to_cdx cs)
  in
  let scope, properties =
    match Hashtbl.find_opt scope_map purl with
    | None -> (None, None)
    | Some scopes ->
        let scope, properties = merge_scopes scopes in
        (Some scope, Some properties)
  in
  C.create_component ~type_ ~name:c.name
    ~version:(C.create_version c.version)
    ~bomref:(C.create_refType purl) ?properties ~purl ?scope ?licenses
    ?description:c.description ?authors ?hashes ?externalReferences:ext_refs ()

(* --- Dependency graph ---------------------------------------------------- *)

(* Group edges by src purl to build CDX dependency entries. *)
let build_dependencies (edges : S.dep_edge list) : C.dependency list =
  let tbl : (string, string list) Hashtbl.t = Hashtbl.create 64 in
  List.iter
    (fun (e : S.dep_edge) ->
      let src = (e.src :> string) in
      let dst = (e.dst :> string) in
      let prev = Option.value ~default:[] (Hashtbl.find_opt tbl src) in
      Hashtbl.replace tbl src (dst :: prev))
    edges;
  Hashtbl.fold
    (fun src dsts acc ->
      C.create_dependency ~ref:(`String src)
        ~dependsOn:(List.rev_map (fun d -> (`String d : C.refLinkType)) dsts)
        ()
      :: acc)
    tbl []
  |> List.sort (fun (a : C.dependency) (b : C.dependency) ->
      match (a.ref, b.ref) with
      | `String sa, `String sb -> String.compare sa sb
      | _ -> Stdlib.compare a.ref b.ref)

(* --- Top-level ----------------------------------------------------------- *)

let of_document (doc : S.document) : C.cycloneDXBillofMaterialsStandard =
  let scope_map = build_scope_map doc.dep_edges in
  let components = List.map (component_to_cdx scope_map) doc.components in
  let dependencies = build_dependencies doc.dep_edges in
  C.create_cycloneDXBillofMaterialsStandard ~bomFormat:C.CycloneDX
    ~specVersion:"1.6"
    ~serialNumber:("urn:uuid:" ^ doc.namespace)
    ~version:1 ~components ~dependencies ()
