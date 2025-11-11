{ pkgs, lib, ... }:
{
  imports = [ ./hardware.nix ];

  system.stateVersion = "25.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  nixpkgs.config.rocmSupport = true;

  networking = {
    hostName = "centaurus";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Jerusalem";

  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    extraLocales = [
      "en_US.UTF-8/UTF-8"
      "he_IL.UTF-8/UTF-8"
    ];
  };

  users.users.koi = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "dialout"
      "gamemode"
      "openrazer"
    ];
    shell = pkgs.zsh;
  };
  home-manager.users.koi = import ./users/koi.nix;


  services = {
    displayManager.autoLogin.user = "koi";
    printing.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    smartd.enable = true;
    hardware.openrgb.enable = true;
    tailscale.enable = true;
    sunshine = {
      enable = lib.mkDefault true;
      openFirewall = true;
      capSysAdmin = true;
    };
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      openrazer-daemon
      polychromatic
    ];
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
