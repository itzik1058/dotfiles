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
      "anki"
      "bitwarden"
      "claude"
      "discord"
      "karabiner-elements"
      "ollama-app"
      "telegram"
      "vladdoster/formulae/vimari"
      "whatsapp"
    ];

    system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  };
}
