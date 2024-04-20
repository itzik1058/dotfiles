{ lib, config, ... }:
with lib;
let
  cfg = config.profiles.home-manager;
in
{
  options.profiles.home-manager = {
    enable = mkEnableOption "home-manager profile";
  };

  config = mkIf cfg.enable {
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
  };
}
