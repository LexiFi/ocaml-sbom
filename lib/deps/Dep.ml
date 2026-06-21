(* see mli *)

type package_namespace = Opam

type source = Lockfiles of string list

type context = {
  install: bool;
  build: bool;
  dev: bool;
  doc: bool;
  test: bool;
}

type t = {
  kind: package_namespace;
  name: string;
  version: string;
  context: context;
  source: source;
}
