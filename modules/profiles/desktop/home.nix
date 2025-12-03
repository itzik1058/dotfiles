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
      bitwarden-desktop
      (discord.override { withVencord = true; })
      libreoffice
      notes
      btop
      nvtopPackages.full
      thunderbird
      obsidian
      onlyoffice-desktopeditors
      qbittorrent
      scrcpy
      telegram-desktop
      wl-clipboard
      pinta
    ];

    programs = {
      firefox.enable = true;
      java.enable = true;
      mpv = {
        enable = true;
        scriptOpts = {
          ytdl_hook = {
            ytdl_path = "${lib.getExe config.programs.yt-dlp.package}";
          };
        };
      };
      yazi.enable = true;
      yt-dlp.enable = true;
    };
    catppuccin.yazi.enable = true;

    profiles.desktop.gnome.enable = true;
    profiles.terminal.defaultTerminal = "ghostty";
  };
}
