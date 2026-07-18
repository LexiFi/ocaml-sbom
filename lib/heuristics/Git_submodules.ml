(*
   Read .gitmodules file to discover Git submodules,
   then repeat on each submodule
*)

open Sbom_util.Path.Ops

type git_submodule = {
  path : Fpath.t;
      (* in the final result returned by 'scan',
                     holds the full fs path *)
  url : string;
  repo_name : string;
}

let repo_name_of_url url =
  let base = Filename.basename url in
  if Filename.check_suffix base ".git" then Filename.chop_suffix base ".git"
  else base

(* Parse a .gitmodules file into a list of submodule records *)
let parse_gitmodules content =
  let lines = String.split_on_char '\n' content in
  let subs = ref [] in
  let cur_path = ref None in
  let cur_url = ref None in
  let flush () =
    match (!cur_path, !cur_url) with
    | Some p, Some u ->
        subs :=
          { path = Fpath.v p; url = u; repo_name = repo_name_of_url u } :: !subs;
        cur_path := None;
        cur_url := None
    | _ -> ()
  in
  lines
  |> List.iter (fun line ->
      let line = String.trim line in
      if String.length line > 0 then
        if line.[0] = '[' then flush ()
        else
          match String.split_on_char '=' line with
          | key :: rest ->
              let key = String.trim key in
              let value = String.trim (String.concat "=" rest) in
              if key = "path" then cur_path := Some value
              else if key = "url" then cur_url := Some value
          | [] -> ());
  flush ();
  List.rev !subs

let rec scan ~(root : Fpath.t option) =
  let gitmodules = root /? ".gitmodules" in
  if Sys.file_exists !!gitmodules then
    let contents = Sbom_util.File.read gitmodules in
    let subs = parse_gitmodules contents in
    subs
    |> List.concat_map (fun sub ->
        let rooted_path = root //? sub.path in
        let sub = { sub with path = rooted_path } in
        sub :: scan ~root:(Some rooted_path))
  else []
