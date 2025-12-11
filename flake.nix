{
  description = "";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
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
      nix-darwin,
      pre-commit-hooks,
      sops-nix,
      catppuccin,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
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
            sharedModules = homeModules;
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        }
        nixos-wsl.nixosModules.wsl
        nix-index-database.nixosModules.nix-index
        nixvim.nixosModules.nixvim
        sops-nix.nixosModules.sops
        catppuccin.nixosModules.catppuccin
      ];
      homeModules = [
        nixRegistry
        ./modules/home.nix
        nix-index-database.homeModules.nix-index
        nixvim.homeModules.nixvim
        sops-nix.homeManagerModules.sops
        catppuccin.homeModules.catppuccin
      ];
      darwinModules = [
        nixRegistry
        ./modules/darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            sharedModules = homeModules;
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        }
        sops-nix.darwinModules.sops
      ];
      nixvimModule = {
        module = import ./modules/nixvim;
        extraSpecialArgs = { };
      };
      mkSystem =
        system: entrypoint:
        nixpkgs.lib.nixosSystem {
          system = system;
          modules = nixosModules ++ [ entrypoint ];
          specialArgs = {
            inherit inputs;
          };
        };
      mkHome =
        system: entrypoint:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = system; };
          modules = homeModules ++ [ entrypoint ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      mkDarwin =
        system: entrypoint:
        nix-darwin.lib.darwinSystem {
          system = system;
          modules = darwinModules ++ [ entrypoint ];
          specialArgs = {
            inherit inputs;
          };
        };
    in
    rec {
      checks = eachSystem (system: {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix.enable = true;
            nixfmt-rfc-style.enable = true;
          };
        };
        nvim = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule {
          inherit system;
          inherit (nixvimModule) module extraSpecialArgs;
        };
      });

      darwinConfigurations = {
        lyra = mkDarwin "aarch64-darwin" ./hosts/lyra;
      };

      devShells = eachSystem (
        system: with pkgsFor.${system}; {
          default = mkShell {
            inherit (checks.${system}.pre-commit-check) shellHook;
            buildInputs = checks.${system}.pre-commit-check.enabledPackages;

            packages = [
              (writeShellScriptBin "rebuild" (
                if stdenv.isDarwin then
                  ''
                    darwin-rebuild --flake . "$@"
                  ''
                else
                  ''
                    nixos-rebuild --flake . --log-format internal-json -v "$@" \
                    |& ${lib.getExe nix-output-monitor} --json \
                    && nix store diff-closures /run/*-system
                  ''
              ))
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
        centaurus = mkSystem "x86_64-linux" ./hosts/centaurus;
        cygnus = mkSystem "x86_64-linux" ./hosts/cygnus;
        pavo = mkSystem "x86_64-linux" ./hosts/pavo;
      };

      packages = eachSystem (system: {
        nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
          inherit system;
          inherit (nixvimModule) module extraSpecialArgs;
        };
      });

      templates = import ./templates;
    };
}
