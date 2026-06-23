(* Execute a command synchronously

    This is meant to be reusable as a standalone library that only depends
    on the Unix library.
*)

type input =
  | Default
  | File of string
  | Data of string

type output =
  | Default
  | File of string
  | Buffer of Buffer.t
  | Ignore

(* A pipe task kept alive in the select loop *)
type pipe_task =
  | Write of Unix.file_descr * bytes * int ref
    (* write remaining bytes starting at offset *)
  | Read of Unix.file_descr * Buffer.t option
    (* read until EOF into buffer if one is provided *)

let setup_cmd_input (inp : input) =
  match inp with
  | Default ->
      Unix.stdin, (fun () -> ()), None
  | File path ->
      let fd = Unix.openfile path [Unix.O_RDONLY] 0 in
      fd, (fun () -> Unix.close fd), None
  | Data data ->
      let (pipe_r, pipe_w) = Unix.pipe () in
      Unix.set_close_on_exec pipe_w;
      let buf = Bytes.of_string data in
      pipe_r, (fun () -> Unix.close pipe_r), Some (Write (pipe_w, buf, ref 0))

let setup_optional_output_buffer opt_buf =
  let pipe_r, pipe_w = Unix.pipe () in
  Unix.set_close_on_exec pipe_r;
  pipe_w, (fun () -> Unix.close pipe_w), Some (Read (pipe_r, opt_buf))

let setup_cmd_output ~default:default_fd (out : output) =
  match out with
  | Default ->
      default_fd, (fun () -> ()), None
  | File path ->
      let fd =
        Unix.openfile path
          [Unix.O_WRONLY; Unix.O_CREAT; Unix.O_TRUNC] 0o666 in
      fd, (fun () -> Unix.close fd), None
  | Buffer buf ->
      setup_optional_output_buffer (Some buf)
  | Ignore ->
      (* emulate writing to /dev/null on Windows *)
      setup_optional_output_buffer None

(* Drive all pipe tasks to completion using select, without blocking. *)
let drain_pipes tasks =
  let tmp = Bytes.create 65536 in
  let tasks = ref tasks in
  while !tasks <> [] do
    let read_fds = List.filter_map (function
        | Read (fd, _) -> Some fd | Write _ -> None) !tasks in
    let write_fds = List.filter_map (function
        | Write (fd, _, _) -> Some fd | Read _ -> None) !tasks in
    let readable, writable, _ = Unix.select read_fds write_fds [] (-1.0) in
    tasks := List.filter_map (fun task ->
      match task with
      | Read (fd, opt_buf) when List.mem fd readable ->
          let n = Unix.read fd tmp 0 (Bytes.length tmp) in
          if n = 0 then (Unix.close fd; None)
          else (
            (match opt_buf with
             | Some buf ->
                 Buffer.add_subbytes buf tmp 0 n
             | None ->
                 (* discard data *)
                 ()
            );
            Some task
          )
      | Write (fd, data, offset) when List.mem fd writable ->
          let remaining = Bytes.length data - !offset in
          let n = Unix.write fd data !offset remaining in
          offset := !offset + n;
          if !offset >= Bytes.length data then (Unix.close fd; None)
          else Some task
      | task -> Some task
    ) !tasks
  done

let run
    ?(input : input = Default)
    ?(output : output = Default)
    ?(error_output : output = Default)
    ?name
    argv =
  match argv with
  | [] -> invalid_arg "Command.run: empty argv"
  | prog :: _ ->
      let cmd_name = match name with Some n -> n | None -> prog in
      let child_stdin, close_child_stdin, stdin_task =
        setup_cmd_input input in
      let child_stdout, close_child_stdout, stdout_task =
        setup_cmd_output ~default:Unix.stdout output in
      let child_stderr, close_child_stderr, stderr_task =
        setup_cmd_output ~default:Unix.stderr error_output in
      let argv_arr = Array.of_list argv in
      let pid =
        Unix.create_process
          cmd_name argv_arr child_stdin child_stdout child_stderr
      in
      (* Close the child-side fds in the parent so pipes get proper EOF *)
      close_child_stdin ();
      close_child_stdout ();
      close_child_stderr ();
      let tasks =
        List.filter_map Fun.id [stdin_task; stdout_task; stderr_task]
      in
      drain_pipes tasks;
      let _pid, status = Unix.waitpid [] pid in
      match status with
      | Unix.WEXITED code -> code
      | Unix.WSIGNALED n -> 128 + n
      | Unix.WSTOPPED n -> 128 + n
