{ pkgs, lib, ... }:
{
  imports = [ ./hardware ];

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
    tailscale.enable = true;
    sunshine = {
      enable = lib.mkDefault true;
      package = pkgs.sunshine.override { cudaSupport = true; };
      openFirewall = true;
      capSysAdmin = true;
    };
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   denyInterfaces = [ "docker0" ];
    #   publish = {
    #     enable = true;
    #     userServices = true;
    #     addresses = true;
    #     hinfo = true;
    #     workstation = true;
    #     domain = true;
    #   };
    # };
    # xrdp = {
    #   enable = true;
    #   defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
    #   openFirewall = true;
    # };
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  security.rtkit.enable = true;

  profiles = {
    audio.enable = true;
    desktop = {
      enable = true;
      gnome.enable = true;
    };
    dev.enable = true;
    gaming.enable = true;
    ssh.enable = true;
    system.enable = true;
  };
}
