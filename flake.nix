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
    }:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      mkSystem =
        entrypoint:
        nixosSystem {
          modules = [
            entrypoint
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                sharedModules = [ ./modules/home.nix ];
              };
            }
            nixos-wsl.nixosModules.wsl
            ./modules
          ];
        };
      mkHome =
        entrypoint: system:
        homeManagerConfiguration {
          pkgs = import nixpkgs { system = system; };
          modules = [
            entrypoint
            ./modules/home.nix
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
    };
}
