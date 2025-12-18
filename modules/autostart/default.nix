{
  flake = {
    modules.homeManager.autostart = {
      config.xdg.configFile."autostart" = {
        source = ./applications;
        recursive = true;
      };
    };
  };
}
