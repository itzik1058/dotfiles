{ pkgs, ... }: {
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

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
