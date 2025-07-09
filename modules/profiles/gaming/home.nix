{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.gaming;
in
{
  options.profiles.gaming = {
    enable = lib.mkEnableOption "gaming profile";
  };

  config = lib.mkIf cfg.enable {
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
