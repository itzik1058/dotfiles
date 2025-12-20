{ config, inputs, ... }:
{
  flake = {
    modules.nixos.imports = {
      imports = [
        config.flake.modules.nixos.nix
        inputs.catppuccin.nixosModules.catppuccin
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.nix-index
        inputs.nixos-wsl.nixosModules.wsl
        inputs.nixvim.nixosModules.nixvim
        inputs.sops-nix.nixosModules.sops
      ];
    };
    modules.homeManager.imports = {
      imports = [
        config.flake.modules.homeManager.nix
        inputs.catppuccin.homeModules.catppuccin
        inputs.nix-index-database.homeModules.nix-index
        inputs.nixvim.homeModules.nixvim
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
    modules.darwin.imports = {
      imports = [
        config.flake.modules.darwin.nix
        inputs.home-manager.darwinModules.home-manager
        inputs.sops-nix.darwinModules.sops
      ];
    };
  };
}
