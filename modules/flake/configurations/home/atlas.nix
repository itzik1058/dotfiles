{ config, ... }:
{
  flake.modules.homeManager."hosts/atlas" = {
    imports = with config.flake.modules.homeManager; [
      nixvim
    ];
    home.username = builtins.getEnv "USER";
    home.homeDirectory = builtins.getEnv "HOME";
  };
}
