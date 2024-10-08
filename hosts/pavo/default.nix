{ pkgs, ... }:
{
  imports = [ ./hardware.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "pavo";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Jerusalem";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.koi = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };
  home-manager.users.koi = import ./users/koi.nix;

  services = {
    printing.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    smartd.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      wget
      vesktop
    ];
  };

  security.rtkit.enable = true;

  profiles = {
    audio.enable = true;
    desktop.enable = true;
    dev.enable = true;
    gaming.enable = true;
    system.enable = true;
  };
}
