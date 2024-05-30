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
  imports = [ ./gnome/home.nix ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
      telegram-desktop
      qbittorrent
      libreoffice
      onlyoffice-bin
      notes
      yt-dlp
    ];

    programs.java.enable = true;
    programs.firefox.enable = true;
    programs.mpv.enable = true;
    programs.eza.enable = true;

    profiles.desktop.gnome.enable = true;
    profiles.terminal.alacritty.enable = true;
  };
}
