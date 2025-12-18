{
  inputs,
  lib,
  ...
}:
{
  flake =
    let
      nixRegistry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
      nixPath = registry: lib.mapAttrsToList (key: value: "${key}=${value.to.path}") registry;
    in
    {
      modules.nixos.nix =
        { config, ... }:
        {
          nix = {
            registry = nixRegistry;
            nixPath = nixPath config.nix.registry;
            gc = {
              automatic = true;
              dates = "weekly";
              options = "--delete-older-than 30d";
              persistent = true;
            };
            optimise.automatic = true;
            settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          };
        };

      modules.homeManager.nix =
        { config, ... }:
        {
          nix = {
            registry = nixRegistry;
            nixPath = nixPath config.nix.registry;
          };
        };

      modules.darwin.nix =
        { config, ... }:
        {
          nix = {
            enable = false;
            registry = nixRegistry;
            nixPath = nixPath config.nix.registry;
            settings.experimental-features = "nix-command flakes";
          };
        };
    };
}
