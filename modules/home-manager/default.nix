{ lib, config, ... }:
with lib;
let
  cfg = config.profiles.home-manager;
in
{
  options.profiles.home-manager = {
    enable = mkEnableOption "home-manager module";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
