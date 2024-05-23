{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.localsend;
in
{
  options.programs.localsend = {
    enable = lib.mkEnableOption "LocalSend";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 53317 ];
    environment.systemPackages = [ pkgs.localsend ];
  };
}
