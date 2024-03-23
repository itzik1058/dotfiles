{ config, ... }: {
  home.file."${config.xdg.configHome}/autostart" = {
    source = ./autostart;
    recursive = true;
  };
}
