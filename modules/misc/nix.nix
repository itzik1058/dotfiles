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
      nixGarbageCollector = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
        persistent = true;
      };
    in
    {
      modules.nixos.nix =
        { config, ... }:
        {
          nix = {
            registry = nixRegistry;
            nixPath = nixPath config.nix.registry;
            gc = nixGarbageCollector;
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
            gc = nixGarbageCollector;
          };
        };

      modules.darwin.nix =
        { config, ... }:
        {
          nix = {
            enable = false;
            registry = nixRegistry;
            nixPath = nixPath config.nix.registry;
            gc = nixGarbageCollector;
            optimise.automatic = true;
            settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          };
        };
    };
}
