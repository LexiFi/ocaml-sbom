(* Entry point and command-line interface for the 'ocaml-sbom' command. *)

open Printf
open Cmdliner

(****************************************************************************)
(* Shared terms *)
(****************************************************************************)

let output_file_term : string option Term.t =
  let info =
    Arg.info [ "o"; "output" ] ~docv:"FILE"
      ~doc:"Write output to $(docv). Defaults to standard output when omitted."
  in
  Arg.value (Arg.opt (Arg.some Arg.string) None info)

let overlay_file_term : string option Term.t =
  let info =
    Arg.info [ "overlay" ] ~docv:"FILE"
      ~doc:
        "Use $(docv) to amend the generated SBOM. See online documentation for \
         syntax and examples."
  in
  Arg.value (Arg.opt (Arg.some Arg.file) None info)

let verbose_term : bool Term.t =
  let info = Arg.info [ "verbose"; "v" ] ~doc:"Enable verbose output." in
  Arg.value (Arg.flag info)

(****************************************************************************)
(* 'gen' subcommand — generate an SBOM from a Dune project *)
(****************************************************************************)

module Gen = struct
  type conf = {
    project_roots : Fpath.t option list; (* each must exist *)
    output_file : Fpath.t option;
    overlay_file : Fpath.t option; (* must exist if provided *)
    use_lockfiles : Sbom_deps.Opam_resolve.use_lockfiles;
    tolerate_warnings : bool;
    ignore_all_suspected_components : bool;
    ignored_suspected_component_paths : Fpath.t list; (* as given by the user *)
    verbose : bool;
  }

  let run (conf : conf) =
    Sbom_util.Global.verbose := conf.verbose;
    match
      Sbom_gen.Gen.generate_sbom
        ~ignore_all_suspected_components:conf.ignore_all_suspected_components
        ~ignored_suspected_component_paths:
          conf.ignored_suspected_component_paths ?output_file:conf.output_file
        ?overlay_file:conf.overlay_file ~use_lockfiles:conf.use_lockfiles
        ~project_roots:conf.project_roots ()
    with
    | exception exn ->
        let msg =
          match exn with
          | Failure msg -> msg
          | exn -> Printexc.to_string exn
        in
        eprintf "Error: %s\n" msg;
        flush stderr;
        exit 1
    | warnings ->
        List.iter (fun w -> eprintf "*** Warning: %s\n" w) warnings;
        flush stderr;
        if warnings <> [] && not conf.tolerate_warnings then exit 1

  (* We represent the default project root as 'None' rather than "."
     so as to avoid ending up with spurious leading './' in file paths.
     However, if the user specifies '.' as the root, we honor that
     and it will show up as a path prefix. *)
  let project_roots_term : string option list Term.t =
    let info =
      Arg.info [] ~docv:"PROJECT_ROOT"
        ~doc:
          "Root directory of a Dune project to analyze. May be repeated to \
           analyze multiple projects at once (useful when local packages \
           depend on each other). Defaults to the current directory."
    in
    Arg.value (Arg.pos_all (Arg.some Arg.file) [ None ] info)

  let use_lockfiles_term =
    let open Sbom_deps.Opam_resolve in
    let conv =
      Arg.conv ~docv:"MODE"
        ( (function
          | "auto" -> Ok Use_lockfiles_if_available
          | "require" -> Ok Require_lockfiles
          | "ignore" -> Ok Ignore_lockfiles
          | s ->
              Error
                (`Msg
                   (sprintf
                      "unknown lockfile mode %S, expected 'auto', 'require', \
                       or 'ignore'"
                      s))),
          fun ppf v ->
            Format.pp_print_string ppf
              (match v with
              | Use_lockfiles_if_available -> "auto"
              | Require_lockfiles -> "require"
              | Ignore_lockfiles -> "ignore") )
    in
    let info =
      Arg.info [ "lockfiles" ] ~docv:"MODE"
        ~doc:
          "How to handle opam lockfiles. $(b,auto) (default): use lockfiles \
           when available, fall back to opam files and emit a warning when \
           some are missing. $(b,require): fail if any lockfile is missing. \
           $(b,ignore): always use opam files, even when lockfiles exist."
    in
    Arg.value (Arg.opt conv Use_lockfiles_if_available info)

  let tolerate_warnings_term : bool Term.t =
    let info =
      Arg.info [ "tolerate-warnings" ]
        ~doc:
          "Do not exit with a nonzero status when warnings are emitted. By \
           default, any warning causes a nonzero exit code."
    in
    Arg.value (Arg.flag info)

  let ignore_all_suspected_components_term : bool Term.t =
    let info =
      Arg.info
        [ "ignore-all-suspected-components" ]
        ~doc:
          "Skip all checks that produce warnings about suspected unlisted \
           components. Overrides any $(b,--ignore-suspected-component) flags."
    in
    Arg.value (Arg.flag info)

  let ignored_suspected_component_paths_term : string list Term.t =
    let info =
      Arg.info
        [ "ignore-suspected-component" ]
        ~docv:"PATH"
        ~doc:
          "Suppress the warning for the suspected unlisted component at \
           $(docv). The path must exist on disk and is resolved to an absolute \
           path via $(b,realpath) before comparison. May be repeated to ignore \
           multiple components."
    in
    Arg.value (Arg.opt_all Arg.file [] info)

  let cmd_term =
    let combine ignore_all_suspected_components
        ignored_suspected_component_paths output_file overlay_file project_roots
        use_lockfiles tolerate_warnings verbose =
      run
        {
          ignore_all_suspected_components;
          ignored_suspected_component_paths =
            List.map Fpath.v ignored_suspected_component_paths;
          project_roots = List.map (Option.map Fpath.v) project_roots;
          output_file = Option.map Fpath.v output_file;
          overlay_file = Option.map Fpath.v overlay_file;
          use_lockfiles;
          tolerate_warnings;
          verbose;
        }
    in
    Term.(
      const combine $ ignore_all_suspected_components_term
      $ ignored_suspected_component_paths_term $ output_file_term
      $ overlay_file_term $ project_roots_term $ use_lockfiles_term
      $ tolerate_warnings_term $ verbose_term)

  let doc = "generate an SBOM for a Dune project"

  let man =
    [
      `S Manpage.s_description;
      `P
        "Analyze one or more Dune projects rooted at the given \
         $(b,PROJECT_ROOT) directories and write a combined Software Bill of \
         Materials to $(b,--output) (or standard output). The SBOM is written \
         in $(mname)'s internal JSON format, which can later be converted to a \
         standard format with the $(b,export) subcommand.";
      `P
        "Passing multiple roots is useful when local packages depend on each \
         other: all roots are analyzed in a single opam resolution pass so \
         cross-root dependencies are resolved correctly.";
      `P
        "The project's opam metadata and lock files are used to enumerate \
         direct and transitive dependencies. Run $(b,dune build) first to \
         ensure metadata is up to date.";
      `S Manpage.s_examples;
      `Pre "$(mname) gen";
      `Pre "$(mname) gen . -o my-project.sbom.json";
      `Pre "$(mname) gen /path/to/project -o sbom.json";
      `Pre "$(mname) gen /path/to/a /path/to/b -o combined.sbom.json";
    ]

  let cmd =
    let info = Cmd.info "gen" ~doc ~man in
    Cmd.v info cmd_term
end

(****************************************************************************)
(* 'export' subcommand — convert internal SBOM to a standard format *)
(****************************************************************************)

module Export = struct
  type output_format = CycloneDX_1_6 | SPDX_2_3 | SPDX_3_0

  type conf = {
    input : string option; (* None = read from stdin *)
    output : string option;
    format : output_format;
    verbose : bool;
  }

  let all_formats =
    [
      ("cyclonedx-1.6", CycloneDX_1_6);
      ("spdx-2.3", SPDX_2_3);
      ("spdx-3.0", SPDX_3_0);
    ]

  let format_conv =
    let names = all_formats |> List.map fst |> String.concat ", " in
    let parse s =
      match List.assoc_opt s all_formats with
      | Some f -> Ok f
      | None ->
          Error
            (`Msg (sprintf "unknown format %S; expected one of: %s" s names))
    in
    let print ppf f =
      let s = fst (List.find (fun (_, f') -> f' = f) all_formats) in
      Format.pp_print_string ppf s
    in
    Arg.conv ~docv:"FORMAT" (parse, print)

  let run (conf : conf) =
    Sbom_util.Global.verbose := conf.verbose;
    let source, json_str =
      match conf.input with
      | None -> ("<stdin>", In_channel.input_all stdin)
      | Some path -> (path, In_channel.with_open_text path In_channel.input_all)
    in
    let document = Sbom_types.Ocaml_sbom.Document.of_json json_str in
    (match Sbom_types.Validate.sbom document with
    | Ok () -> ()
    | Error msg -> ksprintf failwith "malformed SBOM '%s': %s" source msg);
    let output_str =
      match conf.format with
      | CycloneDX_1_6 ->
          Cdx.Cdx_export.of_document document
          |> Cdx.CycloneDX_1_6.yojson_of_cycloneDXBillofMaterialsStandard
          |> Yojson.Safe.pretty_to_string
      | SPDX_2_3 ->
          Spdx.Spdx_export.to_spdx_2_3 document
          |> Spdx.Spdx_2_3_1_dev.yojson_of_sPDX231dev
          |> Yojson.Safe.pretty_to_string
      | SPDX_3_0 ->
          Spdx.Spdx_export.to_spdx_3_0 document
          |> Spdx.Spdx_3_0_1.yojson_of_root_json |> Yojson.Safe.pretty_to_string
    in
    let oc =
      match conf.output with
      | None -> stdout
      | Some path -> open_out path
    in
    fprintf oc "%s\n" output_str;
    if conf.output <> None then close_out oc

  let input_term : string option Term.t =
    let info =
      Arg.info [] ~docv:"INPUT"
        ~doc:
          "Path to an SBOM file in $(mname)'s internal format, as produced by \
           $(b,ocaml-sbom gen). Reads from standard input when omitted, \
           enabling piped workflows such as $(b,ocaml-sbom gen | ocaml-sbom \
           export)."
    in
    Arg.value (Arg.pos 0 (Arg.some Arg.string) None info)

  let format_term : output_format Term.t =
    let info =
      Arg.info [ "format" ] ~docv:"FORMAT"
        ~doc:
          "Output format. Supported values: $(b,cyclonedx-1.6) (CycloneDX 1.6 \
           JSON, default), $(b,spdx-2.3) (SPDX 2.3 tag-value or JSON), \
           $(b,spdx-3.0) (SPDX 3.0 JSON-LD)."
    in
    Arg.value (Arg.opt format_conv CycloneDX_1_6 info)

  let cmd_term =
    let combine input output format verbose =
      run { input; output; format; verbose }
    in
    Term.(
      const combine $ input_term $ output_file_term $ format_term $ verbose_term)

  let doc = "export an SBOM to a standard format"

  let man =
    [
      `S Manpage.s_description;
      `P
        "Read an SBOM from $(b,INPUT) (a file written by $(b,ocaml-sbom gen)) \
         and convert it to a standard format, writing the result to \
         $(b,--output) (or standard output).";
      `P "Supported output formats:";
      `I ("$(b,cyclonedx-1.6)", "CycloneDX 1.6 JSON (default).");
      `I ("$(b,spdx-2.3)", "SPDX 2.3.1 JSON.");
      `I ("$(b,spdx-3.0)", "SPDX 3.0.1 JSON-LD.");
      `S Manpage.s_examples;
      `Pre "$(mname) export sbom.json";
      `Pre "$(mname) export sbom.json --format cyclonedx-1.6 -o bom.json";
      `Pre "$(mname) export sbom.json --format spdx-2.3 -o sbom.spdx.json";
      `Pre "$(mname) export sbom.json --format spdx-3.0 -o sbom.spdx.json";
    ]

  let cmd =
    let info = Cmd.info "export" ~doc ~man in
    Cmd.v info cmd_term
end

(****************************************************************************)
(* 'overlay' subcommand — apply an overlay without regenerating the SBOM *)
(****************************************************************************)

module Apply_overlay = struct
  type conf = {
    input : string option; (* None = read from stdin *)
    output : string option;
    overlay_file : Fpath.t option;
    verbose : bool;
  }

  let run (conf : conf) =
    Sbom_util.Global.verbose := conf.verbose;
    try
      let json_str =
        match conf.input with
        | None -> In_channel.input_all stdin
        | Some path -> In_channel.with_open_text path In_channel.input_all
      in
      let document = Sbom_types.Ocaml_sbom.Document.of_json json_str in
      let overlay_path =
        match conf.overlay_file with
        | Some p -> Some p
        | None ->
            let default = Fpath.v Sbom_gen.Overlay.default_name in
            if Sys.file_exists (Fpath.to_string default) then Some default
            else None
      in
      let document =
        match overlay_path with
        | None -> document
        | Some path ->
            let overlay = Sbom_gen.Overlay.load path in
            Sbom_gen.Overlay.apply document overlay ~overlay_path:path
      in
      let output_str =
        Sbom_types.Ocaml_sbom.Document.to_json document |> Yojson.Safe.prettify
      in
      let oc =
        match conf.output with
        | None -> stdout
        | Some path -> open_out path
      in
      fprintf oc "%s\n" output_str;
      if conf.output <> None then close_out oc
    with
    | Failure msg ->
        eprintf "Error: %s\n" msg;
        flush stderr;
        exit 1
    | exn ->
        eprintf "Error: %s\n" (Printexc.to_string exn);
        flush stderr;
        exit 1

  let input_term : string option Term.t =
    let info =
      Arg.info [] ~docv:"INPUT"
        ~doc:
          "Path to an SBOM file in $(mname)'s internal format, as produced by \
           $(b,ocaml-sbom gen). Reads from standard input when omitted."
    in
    Arg.value (Arg.pos 0 (Arg.some Arg.string) None info)

  let cmd_term =
    let combine input output overlay_file verbose =
      run
        {
          input;
          output;
          overlay_file = Option.map Fpath.v overlay_file;
          verbose;
        }
    in
    Term.(
      const combine $ input_term $ output_file_term $ overlay_file_term
      $ verbose_term)

  let doc = "apply an overlay to an existing SBOM"

  let man =
    [
      `S Manpage.s_description;
      `P
        "Read an SBOM from $(b,INPUT) (a file in $(mname)'s internal format) \
         and apply the overlay specified by $(b,--overlay), writing the \
         patched SBOM to $(b,--output) (or standard output).";
      `P
        ("If $(b,--overlay) is not given, the file $(b,"
       ^ Sbom_gen.Overlay.default_name
       ^ ") in the current directory is used when it exists.");
      `P
        "This subcommand is useful for quickly testing the effect of edits in \
         an overlay file without having to re-run the full $(b,gen) step, \
         which invokes opam and can be slow.";
      `S Manpage.s_examples;
      `P "$(b,Basic usage):";
      `Pre "$(mname) overlay sbom.json";
      `Pre "$(mname) overlay sbom.json --overlay fixes.json";
      `Pre "$(mname) overlay sbom.json -o patched.json";
      `Pre "$(mname) gen | $(mname) overlay";
      `S "OVERLAY FILE FORMAT";
      `P
        "An overlay file is a JSON file with a $(b,format) field and an \
         $(b,actions) list. Actions are applied sequentially. The precise \
         specification is the ATD schema at \
         https://github.com/LexiFi/ocaml-sbom/blob/main/lib/types/ocaml_sbom_overlay.atd";
      `P "$(b,Remove a component by name):";
      `Pre
        {|{
  "format": "ocaml-sbom-overlay/1.0",
  "actions": [
    { "Remove_component": { "name": "unwanted-pkg" } }
  ]
}|};
      `P "$(b,Remove a component by PURL key):";
      `Pre
        {|{
  "format": "ocaml-sbom-overlay/1.0",
  "actions": [
    { "Remove_component": { "key": "pkg:opam/unwanted-pkg@1.2.3" } }
  ]
}|};
      `P
        "$(b,Set properties on a component) (e.g. fix a missing or wrong \
         license, add authors):";
      `Pre
        {|{
  "format": "ocaml-sbom-overlay/1.0",
  "actions": [
    {
      "Set_component_properties": {
        "name": "some-pkg",
        "spdx_license": "MIT",
        "authors": [ { "Person": { "name": "Alice", "email": "alice@example.com" } } ],
        "maintainers": [ { "Organization": { "name": "Acme Corp" } } ]
      }
    }
  ]
}|};
      `P
        "$(b,Add a component) that opam does not know about (e.g. a vendored C \
         library):";
      `Pre
        {|{
  "format": "ocaml-sbom-overlay/1.0",
  "actions": [
    {
      "Add_component": {
        "key": "pkg:github/madler/zlib@1.3.1",
        "name": "zlib",
        "version": "1.3.1",
        "kind": { "Opam_package": { "library": true, "executable": false } },
        "licensing": {
          "declared": { "Atom": { "Spdx_id": "Zlib" } },
          "concluded": "Unknown"
        },
        "source_distribution": {
          "url": "https://github.com/madler/zlib/archive/refs/tags/v1.3.1.tar.gz",
          "checksums": []
        }
      }
    }
  ]
}|};
    ]

  let cmd =
    let info = Cmd.info "overlay" ~doc ~man in
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

let subcommands = [ Gen.cmd; Export.cmd; Apply_overlay.cmd ]

let () =
  let info = Cmd.info "ocaml-sbom" ~version:"dev" ~doc ~man in
  Cmd.group ~default:Gen.cmd_term info subcommands |> Cmd.eval |> exit
