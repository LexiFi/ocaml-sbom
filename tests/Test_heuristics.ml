(*
   Tests for the heuristics that detect suspected vendored components.

   These tests operate on the fake Git repo 'test-repo'.
*)

open Sbom_util.Path.Ops

let test_repo = Fpath.v "tests" / "test-repo"

(* for use by Testo.check *)
let fpath = Testo.testable Fpath.to_string Fpath.equal

(* Build a minimal empty SBOM document for use in tests *)
let empty_sbom () : Sbom_types.Ocaml_sbom.document =
  Sbom_types.Ocaml_sbom.create_document ~format:"ocaml-sbom/1.0"
    ~namespace:"test" ~root_components:[] ~components:[] ~dep_edges:[] ()

let test_scan_file_tree =
  Testo.create "scan_file_tree finds files and dirs" (fun () ->
      let found = ref [] in
      Sbom_heuristics.Scan_file_tree.scan ~root:test_repo (fun file ->
          found := file.name :: !found);
      let found = List.sort String.compare !found in
      (* Test repo contains these files/dirs *)
      List.iter
        (fun name ->
          if not (List.mem name found) then
            Testo.fail ("Expected to find: " ^ name))
        [ "vendor"; "third_party"; "mylib"; "anotherlib"; "extlib" ])

let test_license_file_detection =
  Testo.create "license_files detects LICENSE variants" (fun () ->
      let make_reg name =
        Sbom_heuristics.Scan_file_tree.
          { name; proj_path = Fpath.v name; kind = Reg (lazy "") }
      in
      let make_dir name =
        Sbom_heuristics.Scan_file_tree.
          { name; proj_path = Fpath.v name; kind = Dir }
      in
      let is = Sbom_heuristics.License_files.is_likely_license_file in
      assert (is (make_reg "LICENSE"));
      assert (is (make_reg "LICENSE.txt"));
      assert (is (make_reg "LICENSE.md"));
      assert (is (make_reg "LICENCE"));
      assert (is (make_reg "COPYING"));
      assert (is (make_reg "COPYRIGHT"));
      assert (is (make_reg "NOTICE"));
      assert (not (is (make_reg "README.md")));
      assert (not (is (make_dir "LICENSE"))))

let test_vendored_dir_detection =
  Testo.create "vendored_dirs detects vendor children" (fun () ->
      let make_dir path =
        let name = Fpath.basename (Fpath.v path) in
        Sbom_heuristics.Scan_file_tree.
          { name; proj_path = Fpath.v path; kind = Dir }
      in
      let is = Sbom_heuristics.Vendored_dirs.is_likely_vendored_dir in
      assert (is (make_dir "vendor/mylib"));
      assert (is (make_dir "third_party/extlib"));
      assert (is (make_dir "external/somelib"));
      assert (not (is (make_dir "vendor")));
      assert (not (is (make_dir "src"))))

let test_dune_vendored_dirs =
  Testo.create "dune_vendored_dirs parses (vendored_dirs ...)" (fun () ->
      let content =
        "(vendored_dirs vendor thirdparty)\n\n(library (name foo))\n"
      in
      let file =
        Sbom_heuristics.Scan_file_tree.
          {
            name = "dune";
            proj_path = Fpath.v "subdir" / "dune";
            kind = Reg (lazy content);
          }
      in
      match
        Sbom_heuristics.Dune_vendored_dirs.extract_vendored_dirs_from_dune_file
          file
      with
      | None -> Testo.fail "expected Some"
      | Some paths ->
          let paths = List.sort Fpath.compare paths in
          Testo.(check (list fpath))
            [ Fpath.v "subdir" / "thirdparty"; Fpath.v "subdir" / "vendor" ]
            paths)

let test_dune_vendored_dirs_non_dune =
  Testo.create "dune_vendored_dirs ignores non-dune files" (fun () ->
      let file =
        Sbom_heuristics.Scan_file_tree.
          {
            name = "dune-project";
            proj_path = Fpath.v "dune-project";
            kind = Reg (lazy "(vendored_dirs vendor)");
          }
      in
      match
        Sbom_heuristics.Dune_vendored_dirs.extract_vendored_dirs_from_dune_file
          file
      with
      | None -> ()
      | Some _ -> Testo.fail "should not parse dune-project files")

let test_git_submodules =
  Testo.create "git_submodules scans .gitmodules" (fun () ->
      let subs = Sbom_heuristics.Git_submodules.scan ~root:(Some test_repo) in
      match subs with
      | [] -> Testo.fail "expected at least one submodule"
      | sub :: _ ->
          Testo.(check fpath)
            (Fpath.v "submodules" / "submodproject")
            sub.proj_path;
          Testo.(check string) "submodproject" sub.repo_name)

let test_check_project =
  Testo.create "check_project finds suspected components" (fun () ->
      let warnings =
        Sbom_gen.Check_project.scan ~roots:[ Some test_repo ] (empty_sbom ())
      in
      if warnings = [] then
        Testo.fail "expected heuristics to produce at least one warning";
      List.iter
        (fun w ->
          if not (String.length w > 0) then Testo.fail "empty warning string")
        warnings)

let tests =
  [
    test_scan_file_tree;
    test_license_file_detection;
    test_vendored_dir_detection;
    test_dune_vendored_dirs;
    test_dune_vendored_dirs_non_dune;
    test_git_submodules;
    test_check_project;
  ]
  |> Testo.categorize "heuristics"
