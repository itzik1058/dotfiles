{
  description = "";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      ...
    }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      nixRegistry = {
        nix.registry = builtins.mapAttrs (name: input: { flake = input; }) (
          nixpkgs.lib.filterAttrs (name: value: value ? outputs) inputs
        );
      };
      mkSystem =
        entrypoint:
        nixosSystem {
          modules = [
            nixRegistry
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                sharedModules = [
                  nixRegistry
                  ./modules/home.nix
                ];
              };
            }
            nixos-wsl.nixosModules.wsl
            ./modules
            entrypoint
          ];
        };
      mkHome =
        entrypoint: system:
        homeManagerConfiguration {
          pkgs = import nixpkgs { system = system; };
          modules = [
            ./modules/home.nix
            entrypoint
          ];
        };
    in
    {
      nixosConfigurations = {
        wsl = mkSystem ./hosts/wsl;
        cygnus = mkSystem ./hosts/cygnus;
        pavo = mkSystem ./hosts/pavo;
      };

      homeConfigurations = {
        atlas = mkHome ./hosts/default/users/atlas "x86_64-linux";
      };

      devShells = import ./shells { inherit nixpkgs; };
      templates = import ./templates;
    };
}
