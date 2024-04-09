{ config, ... }:
{
  home.file."${config.xdg.configHome}/autostart" = {
    source = ./applications;
    recursive = true;
  };
}
