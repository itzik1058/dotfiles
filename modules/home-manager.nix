{ config, inputs, ... }:
{
  flake =
    let
      homeModules = [
        config.flake.modules.homeManager.nix
        inputs.nix-index-database.homeModules.nix-index
        inputs.sops-nix.homeManagerModules.sops
        inputs.catppuccin.homeModules.catppuccin
        config.flake.modules.homeManager.nixvim
      ];
    in
    {
      modules.nixos.home-manager = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          sharedModules = homeModules;
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
      modules.homeManager.home-manager = {
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
          sharedModules = homeModules;
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
