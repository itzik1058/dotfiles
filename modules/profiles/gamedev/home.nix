{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.gamedev;
in
{
  options.profiles.gamedev = {
    enable = lib.mkEnableOption "gamedev profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      aseprite
      godot_4
    ];
  };
}
