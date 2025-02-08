{
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
    programs.ghostty = {
      enable = true;
      settings = {
        font-size = 11;
        keybind = [
          "ctrl+comma=unbind"
          "ctrl+shift+comma=unbind"
        ];
      };
    };
    catppuccin.ghostty.enable = true;
  };
}
