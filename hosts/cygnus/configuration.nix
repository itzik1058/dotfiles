{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../modules/gnome.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cygnus";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jerusalem";

  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;
  services.flatpak.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.koi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ vim wget git ];

  system.stateVersion = "23.11";
}

