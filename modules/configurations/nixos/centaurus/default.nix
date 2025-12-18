{ config, ... }:
let
  nixosModules = [
    config.flake.modules.nixos.audio
    config.flake.modules.nixos.desktop
    config.flake.modules.nixos.dev
    config.flake.modules.nixos.gaming
    config.flake.modules.nixos.gnome
    config.flake.modules.nixos.home-manager
    config.flake.modules.nixos.sops
    config.flake.modules.nixos.ssh
    config.flake.modules.nixos.system
    config.flake.modules.nixos.wireguard
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
    config.flake.modules.homeManager.sops
    config.flake.modules.homeManager.starship
    config.flake.modules.homeManager.system
    config.flake.modules.homeManager.theme
    config.flake.modules.homeManager.tmux
    config.flake.modules.homeManager.zsh
  ];
in
{
  flake.modules.nixos."hosts/centaurus" =
    { lib, pkgs, ... }:
    {
      imports = nixosModules ++ [ ./_hardware.nix ];

      system.stateVersion = "25.05";

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        binfmt.emulatedSystems = [ "aarch64-linux" ];
      };

      # nixpkgs.config.rocmSupport = true;

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
      home-manager.users.koi =
        { pkgs, ... }:
        {
          imports = homeManagerModules;

          home.packages = with pkgs; [ prismlauncher ];

          services.ollama.enable = true;

          dconf.settings."org/gnome/shell".enabled-extensions = [ "hass-gshell@geoph9-on-github" ];
        };

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
    };
}
