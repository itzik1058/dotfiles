{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.desktop.swaync;
in
{
  options.profiles.desktop.swaync = {
    enable = lib.mkEnableOption "swaync desktop profile";
  };

  config = lib.mkIf cfg.enable {
    services.swaync = {
      enable = true;
      style = builtins.readFile ./style.css;
    };
  };
}
