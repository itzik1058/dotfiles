{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";

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
  home-manager.users.nixos = import ./users/nixos.nix;

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [ wget ];
  };

  profiles = {
    dev.enable = true;
    system.enable = true;
  };
}
