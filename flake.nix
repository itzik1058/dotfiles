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
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      nix-index-database,
      nixvim,
      catppuccin,
      ...
    }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      nixRegistry = {
        nix.registry = builtins.mapAttrs (_: input: { flake = input; }) inputs;
      };
      overlays = {
        nixpkgs.overlays = (import ./overlays inputs);
      };
      nixosModules = [
        nixRegistry
        overlays
        ./modules
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            sharedModules = homeManagerModules;
            extraSpecialArgs = { inherit inputs; };
          };
        }
        nixos-wsl.nixosModules.wsl
        nix-index-database.nixosModules.nix-index
        nixvim.nixosModules.nixvim
        catppuccin.nixosModules.catppuccin
      ];
      homeManagerModules = [
        nixRegistry
        overlays
        ./modules/home.nix
        nix-index-database.hmModules.nix-index
        nixvim.homeManagerModules.nixvim
        catppuccin.homeManagerModules.catppuccin
      ];
      mkSystem =
        entrypoint:
        nixosSystem {
          modules = nixosModules ++ [ entrypoint ];
          specialArgs = { inherit inputs; };
        };
      mkHome =
        entrypoint: system:
        homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = homeManagerModules ++ [ entrypoint ];
          extraSpecialArgs = { inherit inputs; };
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
