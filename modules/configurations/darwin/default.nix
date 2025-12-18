{ config, inputs, ... }:
{
  flake =
    let
      darwinModules = [
        config.flake.modules.darwin.nix
        ../modules/darwin.nix
        inputs.home-manager.darwinModules.home-manager
        config.flake.modules.darwin.home-manager
        inputs.sops-nix.darwinModules.sops
      ];
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
        lyra = mkDarwin "aarch64-darwin" config.flake.modules.darwin."hosts/lyra";
      };
    };
}
