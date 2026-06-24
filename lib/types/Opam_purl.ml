(*
   Create valid Opam PURLs

   PURL spec: https://ecma-international.org/wp-content/uploads/ECMA-427_1st_edition_december_2025.pdf

   Opam-specific PURL spec:
   https://github.com/package-url/purl-spec/blob/main/types/opam-definition.json

   Permitted characters in a PURL (quoted from the spec):

   A canonical PURL is composed of these permitted ASCII characters:
   - the Alphanumeric Characters: A to Z, a to z, 0 to 9
   - the Punctuation Characters: .-_~ (period '.', dash '-', underscore '_'
     and tilde '~')
   - the Percent Character: % (percent sign '%')
   - the Separator Characters :/@?=&# (colon ':', slash '/', at sign '@',
     question mark '?', equal sign '=', ampersand '&' and hash sign '#')

   Since all the characters that may occur in an Opam package name
   or its version are also valid PURL characters, there is no need
   to percent-encode them.
*)

open Printf

(* opam name constraints, from src/format/opamPackage.ml in the opam source:
   - allowed characters: letters (a-z, A-Z), digits (0-9), '-', '_', '+'
   - must contain at least one letter

   Source: https://github.com/ocaml/opam/blob/65fa20ed7d17aa13482d60962924ff61888b87de/src/format/opamPackage.ml#L67-L81
*)
let valid_name name =
  name <> "" &&
  String.for_all (fun c ->
    match c with
    | 'a'..'z' | 'A'..'Z' | '0'..'9' | '-' | '_' | '+' -> true
    | _ -> false
  ) name &&
  String.exists (fun c ->
    match c with
    | 'a'..'z' | 'A'..'Z' -> true
    | _ -> false
  ) name

(* opam version constraints, from src/format/opamPackage.ml in the opam source:
   - allowed characters: letters (a-z, A-Z), digits (0-9), '-', '_', '+', '.', '~'
   - must be non-empty

   Source: https://github.com/ocaml/opam/blob/65fa20ed7d17aa13482d60962924ff61888b87de/src/format/opamPackage.ml#L23-L32
 *)
let valid_version version =
  version <> "" &&
  String.for_all (fun c ->
    match c with
    | 'a'..'z' | 'A'..'Z' | '0'..'9' | '-' | '_' | '+' | '.' | '~' -> true
    | _ -> false
  ) version

let create ~name ~version =
  if not (valid_name name) then
    Error (sprintf "invalid opam package name: %S" name)
  else if not (valid_version version) then
    Error (sprintf "invalid opam package version: %S" version)
  else
    (* no percent-encoding is needed for valid opam names and versions *)
    Ok (Purl.create_t (sprintf "pkg:opam/%s@%s" name version))
