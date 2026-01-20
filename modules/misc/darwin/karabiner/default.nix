{
  flake = {
    modules.homeManager.karabiner =
      { lib, pkgs, ... }:
      {
        config = {
          xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
            "karabiner/karabiner.json".source = ./karabiner.json;
          };
        };
      };
  };
}
