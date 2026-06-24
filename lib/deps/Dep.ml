(* see mli *)

type package_namespace = Opam

type source =
  | Lockfiles of Fpath.t list
  | Dry_install of Fpath.t list

type scope = {
  install: bool;
  build: bool;
  dev: bool;
  doc: bool;
  test: bool;
}

type component = {
  kind: package_namespace;
  name: string;
  version: string;
}

type t = {
  src: component;
  dst: component;
  scope: scope;
}
