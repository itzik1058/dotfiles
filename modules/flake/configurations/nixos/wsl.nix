{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    dev
    home-manager
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    dev
    home-manager
    shell
    starship
    tmux
    zsh
  ];
in
{
  flake.modules.nixos."hosts/wsl" =
    { pkgs, ... }:
    {
      imports = nixosModules;

      wsl = {
        enable = true;
        defaultUser = "nixos";
      };

      networking = {
        hostName = "wsl";
      };

      users.users.nixos = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "docker"
        ];
        shell = pkgs.zsh;
      };
      home-manager.users.nixos =
        { config, ... }:
        {
          imports = homeManagerModules;
          home.file."${config.home.homeDirectory}/.vscode-server/server-env-setup".text =
            "PATH=$PATH:/run/current-system/sw/bin/";
        };

      environment = {
        shells = with pkgs; [ zsh ];
        pathsToLink = [ "/share/zsh" ];
      };
    };
}
