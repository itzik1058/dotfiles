{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.dev;
in
{
  options.profiles.dev = {
    enable = lib.mkEnableOption "dev profile";
  };

  config = lib.mkIf cfg.enable {
    homebrew.casks = [
      "iterm2"
      "docker-desktop"
    ];
  };
}
