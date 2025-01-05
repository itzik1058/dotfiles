{ pkgs, ... }:
{
  home.packages = with pkgs; [ brasero ];

  programs.aws-vpn-client.enable = true;

  profiles = {
    audio.enable = true;
    desktop.enable = true;
    dev.enable = true;
    gaming.enable = true;
    home-manager.enable = true;
    shell = {
      enable = true;
      powerlevel10k.enable = true;
    };
    theme.enable = true;
  };
}
