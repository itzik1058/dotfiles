{ pkgs, ... }:
{
  home.packages = with pkgs; [ brasero ];

  profiles = {
    audio.enable = true;
    desktop = {
      enable = true;
      gnome.enable = true;
      hyprland.enable = true;
    };
    dev.enable = true;
    gamedev.enable = true;
    gaming.enable = true;
    home-manager.enable = true;
    shell = {
      enable = true;
      starship.enable = true;
    };
    theme.enable = true;
  };
}
