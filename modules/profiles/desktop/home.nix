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
      libreoffice
      onlyoffice-bin
      notes
    ];

    programs.firefox.enable = true;
    programs.mpv.enable = true;
    programs.eza.enable = true;

    profiles.desktop.gnome.enable = true;
    profiles.terminal.alacritty.enable = true;
  };
}
