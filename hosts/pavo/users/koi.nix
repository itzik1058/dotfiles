{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    tree
    gnome.gnome-software
  ];

  profiles = {
    audio.enable = true;
    dev.enable = true;
    gnome.enable = true;
    home-manager.enable = true;
    shell.enable = true;
    theme.enable = true;
  };
}
