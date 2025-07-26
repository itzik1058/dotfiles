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

  networking = {
    hostName = "centaurus";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Jerusalem";

  i18n.defaultLocale = "en_US.UTF-8";

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

  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

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
      package = pkgs.sunshine.override { cudaSupport = true; };
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
