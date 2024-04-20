{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.gnome;
in
{
  options.profiles.gnome = {
    enable = mkEnableOption "gnome profile";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
