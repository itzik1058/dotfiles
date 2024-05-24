{ lib, config, ... }:
let
  cfg = config.profiles.home-manager;
in
{
  options.profiles.home-manager = {
    enable = lib.mkEnableOption "home-manager profile";
  };

  config = lib.mkIf cfg.enable {
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
  };
}
