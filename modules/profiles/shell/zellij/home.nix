{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.shell.zellij;
in
{
  options.profiles.shell.zellij = {
    enable = lib.mkEnableOption "zellij profile";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
