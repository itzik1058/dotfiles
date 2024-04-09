{ pkgs, ... }:
{
  imports = [ ./wayland.nix ];

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
}
