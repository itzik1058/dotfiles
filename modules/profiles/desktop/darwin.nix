{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.desktop;
in
{
  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";
  };

  config = lib.mkIf cfg.enable {
    homebrew.casks = [
      "bitwarden"
      "claude"
      "discord"
      "telegram"
      "whatsapp"
    ];
  };
}
