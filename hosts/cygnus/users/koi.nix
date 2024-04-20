{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    tree
    gnome.gnome-software
  ];

  profiles = {
    audio.enable = true;
    autostart.enable = true;
    dev.enable = true;
    gaming.enable = true;
    gnome.enable = true;
    home-manager.enable = true;
    shell.enable = true;
    theme.enable = true;
  };
}
