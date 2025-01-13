{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.desktop.hyprland;
in
{
  options.profiles.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland desktop profile";
  };

  config = lib.mkIf cfg.enable {
    services = {
      blueman.enable = true;
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${lib.getExe' pkgs.greetd.tuigreet "tuigreet"} --time --remember --remember-user-session";
          };
        };
      };
      hypridle.enable = true;
    };
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
      hyprlock.enable = true;
    };
  };
}
