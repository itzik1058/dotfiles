{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.desktop.gnome;
in
{
  options.profiles.desktop.gnome = {
    enable = lib.mkEnableOption "gnome desktop profile";
  };

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
        debug = true;
      };
      desktopManager.gnome.enable = true;
      gnome.gnome-keyring.enable = true;
      udev.packages = with pkgs; [ gnome-settings-daemon ];
    };

    environment.gnome.excludePackages = with pkgs; [ gnome-console ];
  };
}
