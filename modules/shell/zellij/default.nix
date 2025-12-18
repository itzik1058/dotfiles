{
  flake = {
    modules.homeManager.zellij =
      { config, lib }:
      {
        config = {
          home.shellAliases = {
            z = "${lib.getExe config.programs.zellij.package} attach -c main";
          };

          xdg.configFile = {
            "zellij/config.kdl".source = ./config.kdl;
            "zellij/layouts" = {
              source = ./layouts;
              recursive = true;
            };
          };

          programs.zellij.enable = true;
          catppuccin.zellij.enable = true;
        };
      };
  };
}
