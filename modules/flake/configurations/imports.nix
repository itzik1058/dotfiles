{ config, inputs, ... }:
{
  flake = {
    modules.nixos.imports = {
      imports = [
        config.flake.modules.nixos.base
        inputs.catppuccin.nixosModules.catppuccin
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.nix-index
        inputs.nix-topology.nixosModules.default
        inputs.nixos-wsl.nixosModules.wsl
        inputs.sops-nix.nixosModules.sops
      ];
    };
    modules.homeManager.imports = {
      imports = [
        config.flake.modules.homeManager.base
        inputs.catppuccin.homeModules.catppuccin
        inputs.nix-index-database.homeModules.nix-index
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
    modules.darwin.imports = {
      imports = [
        config.flake.modules.darwin.base
        inputs.home-manager.darwinModules.home-manager
        inputs.sops-nix.darwinModules.sops
      ];
    };
  };
}
