{ lib, config, ... }:
with lib;
let
  cfg = config.profiles.gaming;
in
{
  options.profiles.gaming = {
    enable = mkEnableOption "gaming profile";
  };

  config = mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        toggle_hud = "Shift_L+F11";
        no_display = true;
        full = true;
      };
    };
  };
}
