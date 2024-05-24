{ lib, config, ... }:
let
  cfg = config.programs.grim-dawn;
in
{
  options.programs.grim-dawn = {
    enable = lib.mkEnableOption "Grim Dawn";
  };

  config = lib.mkIf cfg.enable { networking.firewall.allowedUDPPorts = [ 27016 ]; };
}
