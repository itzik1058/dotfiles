{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    tree
    gnome.gnome-software
  ];

  profiles = {
    audio.enable = true;
    desktop.enable = true;
    dev.enable = true;
    home-manager.enable = true;
    shell.enable = true;
    theme.enable = true;
  };
}
