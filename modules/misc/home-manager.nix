{ config, inputs, ... }:
{
  flake = {
    modules.nixos.home-manager = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
    modules.homeManager.home-manager = {
      imports = [
        config.flake.modules.homeManager.nix
        inputs.nix-index-database.homeModules.nix-index
        inputs.sops-nix.homeManagerModules.sops
        inputs.catppuccin.homeModules.catppuccin
        config.flake.modules.homeManager.nixvim
      ];
      config = {
        home.stateVersion = "23.11";
        programs.home-manager.enable = true;
      };
    };
    modules.darwin.home-manager = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
