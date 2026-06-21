(* Entry point and command-line interface for the 'ocaml-sbom' command. *)

open Printf
open Cmdliner

(****************************************************************************)
(* Shared terms *)
(****************************************************************************)

let output_file_term : string option Term.t =
  let info =
    Arg.info [ "o"; "output" ] ~docv:"FILE"
      ~doc:
        "Write output to $(docv). Defaults to standard output when omitted."
  in
  Arg.value (Arg.opt (Arg.some Arg.string) None info)

let overlay_file_term : string option Term.t =
  let info =
    Arg.info [ "overlay" ] ~docv:"FILE"
      ~doc:
        "Use $(docv) to amend the generated SBOM. \
         See online documentation for syntax and examples."
  in
  Arg.value (Arg.opt (Arg.some Arg.file) None info)

(****************************************************************************)
(* 'gen' subcommand — generate an SBOM from a Dune project *)
(****************************************************************************)

module Gen = struct
  type conf = {
    project_root : Fpath.t; (* must exist *)
    output_file : Fpath.t option;
    overlay_file : Fpath.t option; (* must exist if provided *)
  }

  let run (conf : conf) =
    match
      Sbom_gen.Gen.generate_sbom
        ?output_file:conf.output_file
        ?overlay_file:conf.overlay_file
        ~project_root:conf.project_root
        ()
    with
    | exception exn ->
        eprintf "Error: %s\n" (Printexc.to_string exn);
        flush stderr;
        exit 1
    | warnings ->
        List.iter (fun w -> eprintf "Warning: %s\n" w) warnings;
        flush stderr;
        if warnings <> [] then exit 1

  let project_root_term : string Term.t =
    let info =
      Arg.info [] ~docv:"PROJECT_ROOT"
        ~doc:
          "Root directory of the Dune project to analyze. Defaults to the \
           current directory."
    in
    Arg.value (Arg.pos 0 Arg.file "." info)

  let cmd_term =
    let combine project_root output_file overlay_file =
      run {
        project_root = Fpath.v project_root;
        output_file = Option.map Fpath.v output_file;
        overlay_file = Option.map Fpath.v overlay_file;
      }
    in
    Term.(const combine $ project_root_term $ output_file_term $ overlay_file_term)

  let doc = "generate an SBOM for a Dune project"

  let man =
    [
      `S Manpage.s_description;
      `P
        "Analyze the Dune project rooted at $(b,PROJECT_ROOT) and write a \
         Software Bill of Materials to $(b,--output) (or standard output). \
         The SBOM is written in $(mname)'s internal JSON format, which can \
         later be converted to a standard format with the $(b,export) \
         subcommand.";
      `P
        "The project's opam metadata and lock files are used to enumerate \
         direct and transitive dependencies. Run $(b,dune build) first to \
         ensure metadata is up to date.";
      `S Manpage.s_examples;
      `Pre "$(mname) gen";
      `Pre "$(mname) gen . -o my-project.sbom.json";
      `Pre "$(mname) gen /path/to/project -o sbom.json";
    ]

  let cmd =
    let info = Cmd.info "gen" ~doc ~man in
    Cmd.v info cmd_term
end

(****************************************************************************)
(* 'export' subcommand — convert internal SBOM to a standard format *)
(****************************************************************************)

module Export = struct
  type output_format = CycloneDX (* | SPDX *)

  type conf = {
    input : string;
    output : string option;
    format : output_format;
  }

  let format_conv =
    let parse = function
      | "cyclonedx" -> Ok CycloneDX
      | s -> Error (`Msg (sprintf "unknown format %S, expected 'cyclonedx'" s))
    in
    let print ppf = function
      | CycloneDX -> Format.pp_print_string ppf "cyclonedx"
    in
    Arg.conv ~docv:"FORMAT" (parse, print)

  let run (conf : conf) =
    let oc =
      match conf.output with
      | None -> stdout
      | Some path -> open_out path
    in
    (* TODO: deserialize conf.input as a [Sbom.document] and call the
       appropriate exporter (e.g. Cdx.of_document). *)
    let format_name =
      match conf.format with
      | CycloneDX -> "cyclonedx"
    in
    fprintf oc
      "{ \"_note\": \"export not yet implemented\", \"input\": %S, \
       \"format\": %S }\n"
      conf.input format_name;
    if conf.output <> None then close_out oc

  let input_term : string Term.t =
    let info =
      Arg.info [] ~docv:"INPUT"
        ~doc:
          "Path to an SBOM file in $(mname)'s internal format, as produced by \
           $(b,ocaml-sbom gen)."
    in
    Arg.required (Arg.pos 0 (Arg.some Arg.string) None info)

  let format_term : output_format Term.t =
    let info =
      Arg.info [ "format" ] ~docv:"FORMAT"
        ~doc:
          "Output format. Currently the only supported value is \
           $(b,cyclonedx) (default)."
    in
    Arg.value (Arg.opt format_conv CycloneDX info)

  let cmd_term =
    let combine input output format = run { input; output; format } in
    Term.(const combine $ input_term $ output_file_term $ format_term)

  let doc = "export an SBOM to a standard format"

  let man =
    [
      `S Manpage.s_description;
      `P
        "Read an SBOM from $(b,INPUT) (a file written by $(b,ocaml-sbom gen)) \
         and convert it to a standard format, writing the result to \
         $(b,--output) (or standard output).";
      `P
        "The only supported output format is currently $(b,cyclonedx) \
         (CycloneDX 1.6 JSON). More formats may be added in the future.";
      `S Manpage.s_examples;
      `Pre "$(mname) export sbom.json";
      `Pre "$(mname) export sbom.json --format cyclonedx -o bom.json";
    ]

  let cmd =
    let info = Cmd.info "export" ~doc ~man in
    Cmd.v info cmd_term
end

(****************************************************************************)
(* Root command *)
(****************************************************************************)

let doc = "generate and export SBOMs for OCaml/Dune projects"

let man =
  [
    `S Manpage.s_description;
    `P
      "$(mname) generates a Software Bill of Materials (SBOM) for OCaml \
       projects that use the Dune build system and opam for package \
       management.";
    `P
      "The typical workflow has two steps. First, generate the SBOM in the \
       internal format:";
    `Pre "$(mname) gen . -o my-project.sbom.json";
    `P
      "Then export it to a standard format such as CycloneDX for consumption \
       by other tools:";
    `Pre "$(mname) export my-project.sbom.json -o bom.json";
    `P
      "Running $(mname) without a subcommand is equivalent to running \
       $(b,ocaml-sbom gen) with the same arguments.";
    `S Manpage.s_bugs;
    `P "Report issues at https://github.com/mjambon/ocaml-sbom/issues.";
  ]

let subcommands = [ Gen.cmd; Export.cmd ]

let () =
  let info = Cmd.info "ocaml-sbom" ~version:"dev" ~doc ~man in
  Cmd.group ~default:Gen.cmd_term info subcommands |> Cmd.eval |> exit
