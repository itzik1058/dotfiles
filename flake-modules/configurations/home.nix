{
  inputs,
  ...
}:
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
        atlas-x86_64-linux = mkHome "x86_64-linux" ../hosts/default/users/atlas.nix;
        atlas-aarch64-linux = mkHome "aarch64-linux" ../hosts/default/users/atlas.nix;
      };
    };
}
