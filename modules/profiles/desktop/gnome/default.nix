{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.desktop.gnome;
in
{
  options.profiles.desktop.gnome = {
    enable = mkEnableOption "gnome desktop profile";
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm = {
          enable = true;
          autoSuspend = false;
        };
        desktopManager.gnome.enable = true;
      };
      udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    };
  };
}
