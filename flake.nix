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
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      eachSystem = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = eachSystem (system: import nixpkgs { inherit system; });

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
        ./modules/home.nix
        nix-index-database.hmModules.nix-index
        nixvim.homeManagerModules.nixvim
        catppuccin.homeManagerModules.catppuccin
      ];
      mkSystem =
        entrypoint:
        nixpkgs.lib.nixosSystem {
          modules = nixosModules ++ [ entrypoint ];
          specialArgs = { inherit inputs; };
        };
      mkHome =
        entrypoint: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = homeManagerModules ++ [ entrypoint ];
          extraSpecialArgs = { inherit inputs; };
        };
    in
    {
      devShells = eachSystem (
        system: with pkgsFor.${system}; {
          default = mkShell {
            packages = [
              pre-commit
              deadnix
              (writeShellScriptBin "rebuild" ''nixos-rebuild --flake . "$@" && nix store diff-closures /run/*-system'')
            ];
          };
        }
      );
      formatter = eachSystem (system: with pkgsFor.${system}; pkgs.nixfmt-rfc-style);

      homeConfigurations = {
        atlas = mkHome ./hosts/default/users/atlas "x86_64-linux";
      };

      nixosConfigurations = {
        wsl = mkSystem ./hosts/wsl;
        cygnus = mkSystem ./hosts/cygnus;
        pavo = mkSystem ./hosts/pavo;
      };

      templates = import ./templates;
    };
}
