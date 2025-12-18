{ config, ... }:
let
  homeManagerModules = [
    config.flake.modules.homeManager.home-manager
  ];
in
{
  flake.modules.homeManager."hosts/atlas" = {
    imports = homeManagerModules;

    home.username = builtins.getEnv "USER";
    home.homeDirectory = builtins.getEnv "HOME";
  };
}
