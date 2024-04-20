{ lib, config, ... }:
with lib;
let
  cfg = config.profiles.autostart;
in
{
  options.profiles.autostart = {
    enable = mkEnableOption "autostart user module";
  };

  config = mkIf cfg.enable {
    home.file."${config.xdg.configHome}/autostart" = {
      source = ./applications;
      recursive = true;
    };
  };
}
