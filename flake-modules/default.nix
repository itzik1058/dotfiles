{
  config,
  inputs,
  ...
}:
{
  flake =
    let
      nixosModules = [
        config.flake.modules.nixos.nix
        ../modules
        inputs.home-manager.nixosModules.home-manager
        config.flake.modules.nixos.home-manager
        {
          home-manager.sharedModules = homeModules;
        }
        inputs.nixos-wsl.nixosModules.wsl
        inputs.nix-index-database.nixosModules.nix-index
        inputs.sops-nix.nixosModules.sops
        inputs.catppuccin.nixosModules.catppuccin
      ];
      homeModules = [
        config.flake.modules.homeManager.nix
        ../modules/home.nix
        inputs.nix-index-database.homeModules.nix-index
        inputs.sops-nix.homeManagerModules.sops
        inputs.catppuccin.homeModules.catppuccin
        config.flake.modules.homeManager.nixvim
      ];
      darwinModules = [
        config.flake.modules.darwin.nix
        ../modules/darwin.nix
        inputs.home-manager.darwinModules.home-manager
        config.flake.modules.darwin.home-manager
        {
          home-manager.sharedModules = homeModules;
        }
        inputs.sops-nix.darwinModules.sops
      ];
      mkSystem =
        system: entrypoint:
        inputs.nixpkgs.lib.nixosSystem {
          system = system;
          modules = nixosModules ++ [ entrypoint ];
          specialArgs = {
            inherit inputs;
          };
        };
      mkHome =
        system: entrypoint:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs { system = system; };
          modules = homeModules ++ [ entrypoint ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      mkDarwin =
        system: entrypoint:
        inputs.nix-darwin.lib.darwinSystem {
          system = system;
          modules = darwinModules ++ [ entrypoint ];
          specialArgs = {
            inherit inputs;
          };
        };
    in
    {
      darwinConfigurations = {
        lyra = mkDarwin "aarch64-darwin" ../hosts/lyra;
      };

      homeConfigurations = {
        atlas-x86_64-linux = mkHome "x86_64-linux" ../hosts/default/users/atlas.nix;
        atlas-aarch64-linux = mkHome "aarch64-linux" ../hosts/default/users/atlas.nix;
      };

      nixosConfigurations = {
        wsl = mkSystem "x86_64-linux" ../hosts/wsl;
        centaurus = mkSystem "x86_64-linux" ../hosts/centaurus;
        cygnus = mkSystem "x86_64-linux" ../hosts/cygnus;
        pavo = mkSystem "x86_64-linux" ../hosts/pavo;
      };

      templates = import ../templates;
    };
}
