{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.desktop;
in
{
  imports = [ ./gnome ];

  options.profiles.desktop = {
    enable = mkEnableOption "desktop profile";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    profiles.desktop.gnome.enable = true;

    programs.java.enable = true;
    programs.localsend.enable = true;
  };
}
