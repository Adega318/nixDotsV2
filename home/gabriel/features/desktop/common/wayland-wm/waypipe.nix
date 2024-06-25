{pkgs, lib, ...}: {
  home.packages = [pkgs.waypipe];
  systemd.user.services = {
    waypipe-client = {
      Unit.Description = "Runs waypipe on startup to support SSH forwarding";
      Service = {
        ExecStartPre = "${lib.getExe' pkgs.coreutils "mkdir"} %h/.waypipe -p";
        ExecStart = "${lib.getExe pkgs.waypipe} --socket %h/.waypipe/client.sock client";
        ExecStopPost = "${lib.getExe' pkgs.coreutils "rm"} -f %h/.waypipe/client.sock";
      };
      Install.WantedBy = ["default.target"];
    };
    waypipe-server = {
      Unit.Description = "Runs waypipe on startup to support SSH forwarding";
      Service = {
        Type = "simple";
        ExecStartPre = "${lib.getExe' pkgs.coreutils "mkdir"} %h/.waypipe -p";
        ExecStart = "${lib.getExe pkgs.waypipe} --socket %h/.waypipe/server.sock --title-prefix '[%H] ' --login-shell --display %h/.waypipe/display server -- ${lib.getExe' pkgs.coreutils "sleep"} infinity";
        ExecStopPost = "${lib.getExe' pkgs.coreutils "rm"} -f %h/.waypipe/server.sock %h/.waypipe/display";
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
