{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.desktop;
in
{
  imports = [ ./gnome ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

    programs.java.enable = true;
    programs.localsend.enable = true;

    profiles.desktop.gnome.enable = true;
  };
}
