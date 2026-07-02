(*
   Apply a human-maintained overlay to a generated SBOM document, allowing
   corrections and additions that the automated analysis cannot derive.

   The overlay format is defined in 'lib/types/ocaml_sbom_overlay.atd'.
*)

open Printf
module S = Sbom_types.Ocaml_sbom
module O = Sbom_types.Ocaml_sbom_overlay

let ( !! ) = Fpath.to_string
let default_name = "ocaml-sbom.overlay.json"
let overlay_format_version = "ocaml-sbom-overlay/1.0"

(* --- SPDX license parsing ------------------------------------------------ *)

(* Duplicated from Gen.ml because Gen.ml depends on Overlay, not vice versa. *)

let spdx_simple (sl : Spdx_licenses.simple_license) : S.license_atom =
  match sl with
  | LicenseID id -> S.Spdx_id id
  | LicenseIDPlus id -> S.Spdx_id (id ^ "+")
  | LicenseRef { document_ref = None; license_ref } ->
      S.License_ref (S.create_license_ref ~id:("LicenseRef-" ^ license_ref) ())
  | LicenseRef { document_ref = Some doc; license_ref } ->
      S.License_ref
        (S.create_license_ref
           ~id:("DocumentRef-" ^ doc ^ ":LicenseRef-" ^ license_ref)
           ())

let spdx_addition : Spdx_licenses.addition -> string = function
  | Exception id -> id
  | AdditionRef { document_ref = None; addition_ref } ->
      "AdditionRef-" ^ addition_ref
  | AdditionRef { document_ref = Some doc; addition_ref } ->
      "DocumentRef-" ^ doc ^ ":AdditionRef-" ^ addition_ref

let rec spdx_expr (expr : Spdx_licenses.t) : S.license_expr =
  match expr with
  | Simple sl -> S.Atom (spdx_simple sl)
  | WITH (sl, a) -> S.With (spdx_simple sl, spdx_addition a)
  | AND (a, b) -> S.And (spdx_expr a, spdx_expr b)
  | OR (a, b) -> S.Or (spdx_expr a, spdx_expr b)

let license_expr_of_spdx_string s : S.license_expr =
  match Spdx_licenses.parse s with
  | Ok expr -> spdx_expr expr
  | Error (`InvalidLicenseID id) ->
      ksprintf failwith
        "overlay: invalid SPDX expression %S: unknown license ID %S" s id
  | Error (`InvalidExceptionID id) ->
      ksprintf failwith
        "overlay: invalid SPDX expression %S: unknown exception ID %S" s id
  | Error `ParseError ->
      ksprintf failwith "overlay: invalid SPDX expression %S: parse error" s

(* --- Filter matching ----------------------------------------------------- *)

let matches_filter ~(key : Sbom_types.Purl.t option) ~(name : string option)
    (c : S.component) : bool =
  let key_match =
    match key with
    | None -> true
    | Some k -> c.key = k
  in
  let name_match =
    match name with
    | None -> true
    | Some n -> c.name = n
  in
  key_match && name_match

(* --- Remove_component ---------------------------------------------------- *)

(* Build a map: component PURL string → set of component PURL strings that
   depend on it (i.e., incoming edge sources). *)
let build_dependents_map (edges : S.dep_edge list) :
    (Sbom_types.Purl.t, Sbom_types.Purl.t list) Hashtbl.t =
  let tbl = Hashtbl.create 64 in
  List.iter
    (fun (e : S.dep_edge) ->
      let src = e.src and dst = e.dst in
      let prev = Option.value ~default:[] (Hashtbl.find_opt tbl dst) in
      Hashtbl.replace tbl dst (src :: prev))
    edges;
  tbl

(* Algorithm:
   1. Seed to_remove with every component that matches the filter.
   2. Repeat until stable: for each remaining non-root component, if every
      component that directly depends on it is already in to_remove (or it
      has no dependents at all), add it too.
   3. Drop from components, root_components, and dep_edges anything whose
      key, src, or dst is in to_remove. *)
let apply_remove_component (op : O.component_filter) (doc : S.document) :
    S.document =
  let to_remove = Hashtbl.create 16 in
  List.iter
    (fun (c : S.component) ->
      if matches_filter ~key:op.key ~name:op.name c then
        Hashtbl.replace to_remove c.key ())
    doc.components;
  let roots =
    let tbl = Hashtbl.create 8 in
    List.iter
      (fun (p : Sbom_types.Purl.t) -> Hashtbl.replace tbl p ())
      doc.root_components;
    tbl
  in
  let changed = ref true in
  while !changed do
    changed := false;
    let dep_map = build_dependents_map doc.dep_edges in
    List.iter
      (fun c ->
        let k = c.S.key in
        if (not (Hashtbl.mem to_remove k)) && not (Hashtbl.mem roots k) then begin
          let dependents =
            Option.value ~default:[] (Hashtbl.find_opt dep_map k)
          in
          if List.for_all (Hashtbl.mem to_remove) dependents then begin
            Hashtbl.replace to_remove k ();
            changed := true
          end
        end)
      doc.components
  done;
  let is_kept c = not (Hashtbl.mem to_remove c.S.key) in
  let components = List.filter is_kept doc.components in
  let root_components =
    List.filter
      (fun (p : Sbom_types.Purl.t) -> not (Hashtbl.mem to_remove p))
      doc.root_components
  in
  let dep_edges =
    List.filter
      (fun (e : S.dep_edge) ->
        (not (Hashtbl.mem to_remove e.src)) && not (Hashtbl.mem to_remove e.dst))
      doc.dep_edges
  in
  { doc with root_components; components; dep_edges }

(* --- Set_properties ------------------------------------------------------- *)

let apply_set_properties_to_component (spec : O.set_component_properties)
    (c : S.component) : S.component =
  let c =
    match spec.opam_package_kind with
    | None -> c
    | Some k -> { c with kind = Opam_package (Known k) }
  in
  let c =
    match spec.licensing with
    | None -> c
    | Some lic -> { c with licensing = lic }
  in
  let c =
    match spec.spdx_license with
    | None -> c
    | Some s ->
        let expr = license_expr_of_spdx_string s in
        let licensing = { c.licensing with declared = S.Known expr } in
        { c with licensing }
  in
  let c =
    match spec.authors with
    | None -> c
    | Some authors -> { c with authors }
  in
  let c =
    match spec.maintainers with
    | None -> c
    | Some maintainers -> { c with maintainers }
  in
  c

let apply_set_properties (spec : O.set_component_properties) (doc : S.document)
    : S.document =
  let components =
    List.map
      (fun c ->
        if matches_filter ~key:spec.key ~name:spec.name c then
          apply_set_properties_to_component spec c
        else c)
      doc.components
  in
  { doc with components }

(* --- Add_component -------------------------------------------------------- *)

let apply_add_component (comp : S.component) (doc : S.document) : S.document =
  let key_str = (comp.key :> string) in
  if List.exists (fun c -> (c.S.key :> string) = key_str) doc.components then
    ksprintf failwith
      "overlay: cannot add component %S: a component with this key already \
       exists"
      key_str;
  {
    doc with
    components = doc.components @ [ comp ];
    root_components = doc.root_components @ [ comp.key ];
  }

(* --- Top-level ----------------------------------------------------------- *)

let apply_action (doc : S.document) (action : O.action) : S.document =
  match action with
  | Remove_component op -> apply_remove_component op doc
  | Set_component_properties spec -> apply_set_properties spec doc
  | Add_component comp -> apply_add_component comp doc

let apply (doc : S.document) (overlay : O.document_overlay) ~overlay_path :
    S.document =
  if overlay.format <> overlay_format_version then
    ksprintf failwith "overlay: unsupported format %S (expected %S)"
      overlay.format overlay_format_version;
  let doc = List.fold_left apply_action doc overlay.actions in
  (match Sbom_types.Validate.sbom doc with
  | Ok () -> ()
  | Error msg ->
      ksprintf failwith "malformed SBOM after applying the overlay '%s': %s"
        !!overlay_path msg);
  doc

let load path =
  try
    In_channel.with_open_text !!path In_channel.input_all
    |> O.Document_overlay.of_json
  with
  | Failure msg ->
      ksprintf failwith "cannot load overlay file '%s': %s" !!path msg
  | exn ->
      ksprintf failwith "cannot load overlay file '%s': exception %s" !!path
        (Printexc.to_string exn)
