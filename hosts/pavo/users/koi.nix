{ pkgs, ... }:
{
  home.packages = with pkgs; [ aws-vpn-client ];

  profiles = {
    audio.enable = true;
    desktop.enable = true;
    dev.enable = true;
    home-manager.enable = true;
    shell = {
      enable = true;
      prompt = "powerlevel10k";
    };
    theme.enable = true;
  };
}
