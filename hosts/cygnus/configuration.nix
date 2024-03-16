{ config, lib, pkgs, ... }:

{
  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "cygnus";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Jerusalem";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.koi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  services = {
    printing.enable = true;
    flatpak.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [ vim wget git ];
  };

  imports = [
    ./hardware-configuration.nix
    ../../modules/wayland.nix
    ../../modules/gnome.nix
    ../../modules/steam.nix
  ];
}

