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
    home.packages = with pkgs; [
      bitwarden-desktop
      onlyoffice-bin
    ];

    programs.firefox.enable = true;
    programs.mpv.enable = true;

    profiles.desktop.gnome.enable = true;
    profiles.desktop.terminal.alacritty.enable = true;
  };
}
