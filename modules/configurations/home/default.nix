{ config, inputs, ... }:
{
  flake =
    let
      mkHome =
        system: entrypoint:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs { system = system; };
          modules = [ entrypoint ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
    in
    {
      homeConfigurations = {
        atlas-x86_64-linux = mkHome "x86_64-linux" config.flake.modules.homeManager."hosts/atlas";
        atlas-aarch64-linux = mkHome "aarch64-linux" config.flake.modules.homeManager."hosts/atlas";
      };
    };
}
