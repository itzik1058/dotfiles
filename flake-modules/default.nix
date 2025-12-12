{
  inputs,
  ...
}:
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
  debug = true;
  flake =
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      eachSystem = inputs.nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = eachSystem (system: import inputs.nixpkgs { inherit system; });

      nixRegistry = {
        nix.registry = builtins.mapAttrs (_: input: { flake = input; }) inputs;
      };
      nixosModules = [
        nixRegistry
        ../modules
        inputs.home-manager.nixosModules.home-manager
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
        inputs.nixos-wsl.nixosModules.wsl
        inputs.nix-index-database.nixosModules.nix-index
        inputs.nixvim.nixosModules.nixvim
        inputs.sops-nix.nixosModules.sops
        inputs.catppuccin.nixosModules.catppuccin
      ];
      homeModules = [
        nixRegistry
        ../modules/home.nix
        inputs.nix-index-database.homeModules.nix-index
        inputs.nixvim.homeModules.nixvim
        inputs.sops-nix.homeManagerModules.sops
        inputs.catppuccin.homeModules.catppuccin
      ];
      darwinModules = [
        nixRegistry
        ../modules/darwin.nix
        inputs.home-manager.darwinModules.home-manager
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

      formatter = eachSystem (system: with pkgsFor.${system}; pkgs.nixfmt-rfc-style);

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
  perSystem =
    {
      lib,
      pkgs,
      self',
      system,
      ...
    }:
    let
      nixvimModule = {
        module = import ../modules/nixvim;
        extraSpecialArgs = { };
      };
    in
    {
      checks = {
        nvim = inputs.nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule {
          inherit system;
          inherit (nixvimModule) module extraSpecialArgs;
        };
      };

      devShells = {
        default = pkgs.mkShell {
          inherit (self'.checks.pre-commit-check) shellHook;
          buildInputs = self'.checks.pre-commit-check.enabledPackages;

          packages = [
            (pkgs.writeShellScriptBin "rebuild" (
              if pkgs.stdenv.isDarwin then
                ''
                  darwin-rebuild --flake . "$@"
                ''
              else
                ''
                  nixos-rebuild --flake . --log-format internal-json -v "$@" \
                  |& ${lib.getExe pkgs.nix-output-monitor} --json \
                  && nix store diff-closures /run/*-system
                ''
            ))
          ];
        };
      };

      packages.nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit system;
        inherit (nixvimModule) module extraSpecialArgs;
      };
    };
}
