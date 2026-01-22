{ config, ... }:
let
  darwinModules = with config.flake.modules.darwin; [
    desktop
    dev
    home-manager
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    dev
    home-manager
    karabiner
    shell
    starship
    tmux
    zsh
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
