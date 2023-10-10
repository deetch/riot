open Riot

let main () =
  let this = self () in
  let pid = spawn (fun () -> ()) in
  monitor this pid;

  match receive () with
  | Process.Messages.Monitor (Process_down pid2) when Pid.equal pid pid2 ->
      Logger.info (fun f -> f "was notified of process death");
      shutdown ()
  | _ ->
      Logger.info (fun f -> f "was NOT notified of process death");
      Stdlib.exit 1

let () =
  Logger.set_log_level (Some Info);
  Riot.run @@ main
