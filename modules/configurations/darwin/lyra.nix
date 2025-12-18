{ config, ... }:
let
  darwinModules = [
    config.flake.modules.darwin.desktop
    config.flake.modules.darwin.dev
    config.flake.modules.darwin.system
  ];
  homeManagerModules = [
    config.flake.modules.homeManager.dev
    config.flake.modules.homeManager.home-manager
    config.flake.modules.homeManager.shell
    config.flake.modules.homeManager.starship
    config.flake.modules.homeManager.system
    config.flake.modules.homeManager.tmux
    config.flake.modules.homeManager.zsh
  ];
in
{
  flake.modules.darwin."hosts/lyra" =
    { pkgs, ... }:
    {
      imports = darwinModules;

      system.stateVersion = 6;

      system.primaryUser = "koi";

      networking.hostName = "lyra";

      users.users.koi = {
        home = "/Users/koi";
        shell = pkgs.zsh;
      };
      home-manager.users.koi = {
        imports = homeManagerModules;
        home.homeDirectory = "/Users/koi";
      };
    };
}
