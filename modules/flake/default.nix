{ config, inputs, ... }:
{
  debug = true;

  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
    inputs.nix-topology.flakeModule
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  flake = {
    nixosModules = config.flake.modules.nixos;
    homeModules = config.flake.modules.homeManager;
    darwinModules = config.flake.modules.darwin;
  };
}
