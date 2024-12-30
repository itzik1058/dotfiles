{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.terminal.ghostty;
in
{
  options.profiles.terminal.ghostty = {
    enable = lib.mkEnableOption "ghostty profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ghostty ];
    xdg.configFile."ghostty/config".source = ./config;
  };
}
