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
  options.profiles.desktop = {
    enable = mkEnableOption "desktop profile";
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

    environment.systemPackages = [ pkgs.localsend ];

    networking.firewall.allowedTCPPorts = [
      53317 # Local Send
    ];
  };
}
