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
  imports = [ ./gnome/home.nix ];

  options.profiles.desktop = {
    enable = mkEnableOption "desktop profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ onlyoffice-bin ];

    profiles.desktop.gnome.enable = true;
  };
}
