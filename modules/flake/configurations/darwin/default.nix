{ config, inputs, ... }:
{
  flake =
    let
      mkDarwin =
        system: entrypoint:
        inputs.nix-darwin.lib.darwinSystem {
          system = system;
          modules = [
            config.flake.modules.darwin.imports
            entrypoint
          ];
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
