{ lib, config, ... }:
let
  cfg = config.profiles.autostart;
in
{
  options.profiles.autostart = {
    enable = lib.mkEnableOption "autostart profile";
  };

  config = lib.mkIf cfg.enable {
    home.file."${config.xdg.configHome}/autostart" = {
      source = ./applications;
      recursive = true;
    };
  };
}
