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

    fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

    programs.java.enable = true;
    programs.localsend.enable = true;

    profiles.desktop.gnome.enable = true;
  };
}
