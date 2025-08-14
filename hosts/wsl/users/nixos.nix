{ config, ... }:
{
  home.file."${config.home.homeDirectory}/.vscode-server/server-env-setup".text =
    "PATH=$PATH:/run/current-system/sw/bin/";

  profiles = {
    dev.enable = true;
    home-manager.enable = true;
    shell = {
      enable = true;
      powerlevel10k.enable = true;
    };
  };
}
