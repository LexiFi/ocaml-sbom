(*
   Test suite
*)

open Printf

let test_capture_stdout =
  Testo.create
    "capture stdout"
    (fun () ->
       let buf = Buffer.create 10 in
       (match
          Sbom_util.Command.run
            ~output:(Buffer buf)
            ["echo"; "hello"]
        with
        | 0 -> ()
        | n -> ksprintf Testo.fail "command exited with code %i" n
       );
       Testo.(check string) "hello\n" (Buffer.contents buf)
    )

let test_read_from_string =
  Testo.create
    "read from string"
    (fun () ->
       let buf = Buffer.create 10 in
       (match
          Sbom_util.Command.run
            ~input:(Data "the input")
            ~output:(Buffer buf)
            ["cat"]
        with
        | 0 -> ()
        | n -> ksprintf Testo.fail "command exited with code %i" n
       );
       Testo.(check string) "the input" (Buffer.contents buf)
    )

let test_missing_command =
  Testo.create
    "missing command"
    (fun () ->
       match Sbom_util.Command.run ["xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"] with
       | exception Unix.Unix_error (ENOENT, _, _) -> ()
       | n -> ksprintf Testo.fail "command unexpectedly exited, with code %i" n
    )

(* TODO: more tests + make 'Command' its own opam package? *)
let command_tests = [
  test_capture_stdout;
  test_read_from_string;
  test_missing_command;
]
  |> Testo.categorize "command"

let tests _env = command_tests

let () =
  Testo.interpret_argv
    ~project_name:"ocaml-sbom"
    tests
