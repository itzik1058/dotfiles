{ pkgs, ... }:
{
  home.packages = with pkgs; [ prismlauncher ];

  services.ollama.enable = true;

  dconf.settings."org/gnome/shell".enabled-extensions = [ "hass-gshell@geoph9-on-github" ];

  profiles = {
    audio.enable = true;
    autostart.enable = true;
    desktop = {
      enable = true;
      gnome.enable = true;
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
