{
  inputs,
  ...
}:
{
  flake =
    let
      nixRegistry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
    in
    {
      modules.nixos.nix = {
        nix.registry = nixRegistry;
      };
      modules.homeManager.nix = {
        nix.registry = nixRegistry;
      };
      modules.darwin.nix = {
        nix.registry = nixRegistry;
      };
    };
}
