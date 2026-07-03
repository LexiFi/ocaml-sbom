(* see mli *)

type package_namespace = Opam

type scopes = {
  runtime : bool;
  build : bool;
  doc : bool;
  test : bool;
  dev : bool;
}

type component = { kind : package_namespace; name : string; version : string }
type t = { src : component; dst : component; scopes : scopes }

let compare_component a b =
  let c = String.compare a.name b.name in
  if c <> 0 then c
  else
    let c = String.compare a.version b.version in
    if c <> 0 then c else compare a b

let compare_t a b =
  let c = compare_component a.src b.src in
  if c <> 0 then c
  else
    let c = compare_component a.dst b.dst in
    if c <> 0 then c else compare a b
