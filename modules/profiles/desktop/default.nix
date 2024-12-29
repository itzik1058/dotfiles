{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.desktop;
in
{
  imports = [ ./gnome ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    services.earlyoom.enable = true;

    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
      adb.enable = true;
    };

    profiles.desktop.gnome.enable = true;
  };
}
