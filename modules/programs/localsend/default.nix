{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.programs.localsend;
in
{
  options.programs.localsend = {
    enable = mkEnableOption "LocalSend";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 53317 ];
    environment.systemPackages = [ pkgs.localsend ];
  };
}
