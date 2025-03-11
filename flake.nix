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
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
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
        system: entrypoint:
        nixpkgs.lib.nixosSystem {
          system = system;
          modules = nixosModules ++ [ entrypoint ];
          specialArgs = { inherit inputs; };
        };
      mkHome =
        system: entrypoint:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = homeManagerModules ++ [ entrypoint ];
          extraSpecialArgs = { inherit inputs; };
        };
    in
    rec {
      checks = eachSystem (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix.enable = true;
          };
        };
      });

      devShells = eachSystem (
        system: with pkgsFor.${system}; {
          default = mkShell {
            inherit (checks.${system}.pre-commit-check) shellHook;
            buildInputs = checks.${system}.pre-commit-check.enabledPackages;

            packages = [
              (writeShellScriptBin "rebuild" ''
                nixos-rebuild --flake . --log-format internal-json -v "$@" \
                |& ${lib.getExe nix-output-monitor} --json \
                && nix store diff-closures /run/*-system
              '')
            ];
          };
        }
      );
      formatter = eachSystem (system: with pkgsFor.${system}; pkgs.nixfmt-rfc-style);

      homeConfigurations = {
        atlas-x86_64-linux = mkHome "x86_64-linux" ./hosts/default/users/atlas.nix;
        atlas-aarch64-linux = mkHome "aarch64-linux" ./hosts/default/users/atlas.nix;
      };

      nixosConfigurations = {
        wsl = mkSystem "x86_64-linux" ./hosts/wsl;
        cygnus = mkSystem "x86_64-linux" ./hosts/cygnus;
        pavo = mkSystem "x86_64-linux" ./hosts/pavo;
      };

      templates = import ./templates;
    };
}
