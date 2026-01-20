{
  inputs,
  lib,
  ...
}:
{
  flake =
    let
      nixConfig = registry: {
        registry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
        nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") registry;
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
          persistent = true;
        };
        settings = {
          flake-registry = "";
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };
    in
    {
      modules.nixos.nix =
        { config, ... }:
        {
          nix = nixConfig config.nix.registry // {
            channel.enable = false;
          };
        };

      modules.homeManager.nix =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          nix = nixConfig config.nix.registry // {
            package = lib.mkDefault pkgs.nix;
          };
        };

      modules.darwin.nix = {
        nix = {
          enable = false;
          channel.enable = false;
        };
      };
    };
}
