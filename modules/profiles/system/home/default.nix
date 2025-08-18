{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.system;
in
{
  options.profiles.system = {
    enable = lib.mkEnableOption "system profile";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
      "karabiner/karabiner.json".source = ./karabiner.json;
    };
  };
}
