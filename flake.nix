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
        nix.registry = builtins.mapAttrs (_: input: { flake = input; }) inputs;
      };
      nixosModules = [
        nixRegistry
        ./modules
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            sharedModules = homeManagerModules;
          };
        }
        nixos-wsl.nixosModules.wsl
      ];
      homeManagerModules = [
        nixRegistry
        ./modules/home.nix
      ];
      mkSystem = entrypoint: nixosSystem { modules = nixosModules ++ [ entrypoint ]; };
      mkHome =
        entrypoint: system:
        homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = homeManagerModules ++ [ entrypoint ];
        };
    in
    {
      devShells = import ./shells { inherit nixpkgs; };
      templates = import ./templates;

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
