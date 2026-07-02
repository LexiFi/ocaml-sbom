(*
   Sanity checks to run before importing or exporting
*)

open Printf
module S = Ocaml_sbom

(* Check that each component's key encodes the same name and version as the
   component's own name and version fields. *)
let check_component_purls (doc : S.document) : string list =
  List.filter_map
    (fun (c : S.component) ->
      match Opam_purl.create ~name:c.name ~version:c.version with
      | Error msg -> Some (sprintf "component %S: %s" (c.key :> string) msg)
      | Ok expected ->
          if (c.key :> string) <> (expected :> string) then
            Some
              (sprintf
                 "component key %S does not match name %S and version %S \
                  (expected %S)"
                 (c.key :> string)
                 c.name c.version
                 (expected :> string))
          else None)
    doc.components

(* Check that every src and dst in dep_edges refers to a known component. *)
let check_no_unknown_edges (doc : S.document) : string list =
  let known = Hashtbl.create 64 in
  List.iter
    (fun (c : S.component) -> Hashtbl.replace known c.key ())
    doc.components;
  List.filter_map
    (fun (e : S.dep_edge) ->
      if not (Hashtbl.mem known e.src) then
        Some
          (sprintf "edge from %S to %S: unknown source component"
             (e.src :> string)
             (e.dst :> string))
      else if not (Hashtbl.mem known e.dst) then
        Some
          (sprintf "edge from %S to %S: unknown destination component"
             (e.src :> string)
             (e.dst :> string))
      else None)
    doc.dep_edges

(* Check that every component is either a root component or the dst of at
   least one edge (i.e. something depends on it). *)
let check_no_orphans (doc : S.document) : string list =
  let reachable = Hashtbl.create 64 in
  List.iter
    (fun (p : Purl.t) -> Hashtbl.replace reachable p ())
    doc.root_components;
  List.iter
    (fun (e : S.dep_edge) -> Hashtbl.replace reachable e.dst ())
    doc.dep_edges;
  List.filter_map
    (fun (c : S.component) ->
      if not (Hashtbl.mem reachable c.key) then
        Some
          (sprintf
             "component %S is neither a root component nor a dependency of any \
              other component"
             (c.key :> string))
      else None)
    doc.components

let make_graph (doc : S.document) : (Purl.t, Purl.t list) Hashtbl.t =
  let graph = Hashtbl.create 100 in
  List.iter
    (fun (c : S.component) ->
      if not (Hashtbl.mem graph c.key) then Hashtbl.replace graph c.key [])
    doc.components;
  List.iter
    (fun (e : S.dep_edge) ->
      let edges = Option.value ~default:[] (Hashtbl.find_opt graph e.src) in
      Hashtbl.replace graph e.src (e.dst :: edges))
    doc.dep_edges;
  graph

(* Cycle detection using DFS with three-colour marking.
   When a back edge is found (grey -> grey), reconstruct the cycle from the
   live DFS path and emit one error per cycle. *)
let check_no_cycles (doc : S.document) : string list =
  let adj = make_graph doc in
  (* None = unvisited, Some false = in-progress (grey), Some true = done (black) *)
  let state : (Purl.t, bool) Hashtbl.t = Hashtbl.create 64 in
  let path : Purl.t list ref = ref [] in
  let errors = ref [] in
  let rec visit node =
    match Hashtbl.find_opt state node with
    | Some true -> ()
    | Some false ->
        (* Back edge: node is an ancestor of the current node. Reconstruct the
           cycle by taking the DFS path prefix down to node. *)
        let rec take_until acc = function
          | [] -> acc
          | h :: t ->
              let acc' = h :: acc in
              if h = node then acc' else take_until acc' t
        in
        let cycle = take_until [] !path in
        let cycle_str =
          String.concat " -> "
            (List.map (fun (p : Purl.t) -> (p :> string)) cycle
            @ [ (node :> string) ])
        in
        errors := sprintf "dependency cycle: %s" cycle_str :: !errors
    | None ->
        Hashtbl.replace state node false;
        path := node :: !path;
        List.iter visit (Option.value ~default:[] (Hashtbl.find_opt adj node));
        path := List.tl !path;
        Hashtbl.replace state node true
  in
  List.iter (fun (c : S.component) -> visit c.key) doc.components;
  !errors

let sbom (doc : S.Document.t) : (unit, string) result =
  let errors =
    check_component_purls doc @ check_no_unknown_edges doc
    @ check_no_orphans doc @ check_no_cycles doc
  in
  match errors with
  | [] -> Ok ()
  | _ -> Error (String.concat "\n" errors)
