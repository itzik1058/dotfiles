{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware
    ./home.nix
    ../../profiles/system
    ../../profiles/system/gnome
    ../../profiles/system/gaming
  ];

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
  programs.nix-ld.enable = true;

  services = {
    printing.enable = true;
    flatpak.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [ wget vesktop ];
  };

  security.rtkit.enable = true;
}

