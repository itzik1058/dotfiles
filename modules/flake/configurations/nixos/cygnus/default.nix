{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    audio
    desktop
    dev
    gaming
    gnome
    home-manager
    ssh
    wireguard
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    audio
    autostart
    desktop
    dev
    gaming
    ghostty
    gnome
    home-manager
    shell
    starship
    theme
    tmux
    zsh
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
