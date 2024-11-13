{ lib, config, ... }:
let
  cfg = config.profiles.autostart;
in
{
  options.profiles.autostart = {
    enable = lib.mkEnableOption "autostart profile";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."autostart" = {
      source = ./applications;
      recursive = true;
    };
  };
}
