{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.programs.grim-dawn;
in
{
  options.programs.grim-dawn = {
    enable = mkEnableOption "Grim Dawn";
  };

  config = mkIf cfg.enable { networking.firewall.allowedUDPPorts = [ 27016 ]; };
}
