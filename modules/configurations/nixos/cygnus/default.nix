{ config, ... }:
let
  nixosModules = [
    config.flake.modules.nixos.audio
    config.flake.modules.nixos.desktop
    config.flake.modules.nixos.dev
    config.flake.modules.nixos.gaming
    config.flake.modules.nixos.gnome
    config.flake.modules.nixos.ssh
    config.flake.modules.nixos.system
  ];
  homeManagerModules = [
    config.flake.modules.homeManager.audio
    config.flake.modules.homeManager.autostart
    config.flake.modules.homeManager.desktop
    config.flake.modules.homeManager.dev
    config.flake.modules.homeManager.gaming
    config.flake.modules.homeManager.ghostty
    config.flake.modules.homeManager.gnome
    config.flake.modules.homeManager.home-manager
    config.flake.modules.homeManager.shell
    config.flake.modules.homeManager.starship
    config.flake.modules.homeManager.system
    config.flake.modules.homeManager.theme
    config.flake.modules.homeManager.tmux
    config.flake.modules.homeManager.zsh
  ];
in
{
  flake.modules.nixos."hosts/cygnus" =
    { lib, pkgs, ... }:
    {
      imports = nixosModules ++ [ ./_hardware ];

      system.stateVersion = "23.11";

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        binfmt.emulatedSystems = [ "aarch64-linux" ];
      };

      nixpkgs.config.cudaSupport = true;

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
          "dialout"
          "gamemode"
        ];
        shell = pkgs.zsh;
      };
      home-manager.users.koi = {
        imports = homeManagerModules;
      };

      # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
      systemd.services."getty@tty1".enable = false;
      systemd.services."autovt@tty1".enable = false;

      services = {
        displayManager.autoLogin.user = "koi";
        printing.enable = true;
        flatpak.enable = true;
        fwupd.enable = true;
        smartd.enable = true;
        tailscale.enable = true;
        sunshine = {
          enable = lib.mkDefault true;
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
    };
}
