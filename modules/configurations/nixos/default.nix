{ config, inputs, ... }:
{
  flake =
    let
      nixosModules = [
        config.flake.modules.nixos.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.nixos-wsl.nixosModules.wsl
        inputs.nix-index-database.nixosModules.nix-index
        inputs.sops-nix.nixosModules.sops
        inputs.catppuccin.nixosModules.catppuccin
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
    in
    {
      nixosConfigurations = {
        wsl = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/wsl";
        centaurus = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/centaurus";
        cygnus = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/cygnus";
        pavo = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/pavo";
      };
    };
}
