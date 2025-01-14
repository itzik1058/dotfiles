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
  imports = [
    ./gnome/home.nix
    ./hyprland/home.nix
    ./hyprlock/home.nix
    ./swaync/home.nix
    ./waybar/home.nix
  ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      vesktop
      bitwarden-desktop
      telegram-desktop
      qbittorrent
      libreoffice
      onlyoffice-bin
      notes
      nvtopPackages.full
      scrcpy
    ];

    programs = {
      java.enable = true;
      firefox.enable = true;
      mpv = {
        enable = true;
        scriptOpts = {
          ytdl_hook = {
            ytdl_path = "${lib.getExe config.programs.yt-dlp.package}";
          };
        };
      };
      yt-dlp.enable = true;
    };

    profiles.desktop.gnome.enable = true;
    profiles.terminal.defaultTerminal = "ghostty";
  };
}
