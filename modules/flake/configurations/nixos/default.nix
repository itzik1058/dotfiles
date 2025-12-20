{ config, inputs, ... }:
{
  flake =
    let
      mkSystem =
        system: entrypoint:
        inputs.nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            config.flake.modules.nixos.imports
            entrypoint
          ];
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
