{ config, ... }:
let
  nixosModules = [
    config.flake.modules.nixos.audio
    config.flake.modules.nixos.desktop
    config.flake.modules.nixos.dev
    config.flake.modules.nixos.gaming
    config.flake.modules.nixos.gnome
    config.flake.modules.nixos.hyprland
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
    config.flake.modules.homeManager.hyprland
    config.flake.modules.homeManager.shell
    config.flake.modules.homeManager.starship
    config.flake.modules.homeManager.system
    config.flake.modules.homeManager.theme
    config.flake.modules.homeManager.tmux
    config.flake.modules.homeManager.zsh
  ];
in
{
  flake.modules.nixos."hosts/pavo" =
    { pkgs, ... }:
    {
      imports = nixosModules ++ [ ./_hardware.nix ];

      system.stateVersion = "23.11";

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
      home-manager.users.koi =
        { pkgs, ... }:
        {
          imports = homeManagerModules;
          home.packages = with pkgs; [ brasero ];
        };

      services = {
        printing.enable = true;
        flatpak.enable = true;
        fwupd.enable = true;
        smartd.enable = true;
      };

      environment = {
        shells = with pkgs; [ zsh ];
        pathsToLink = [ "/share/zsh" ];
      };

      security.rtkit.enable = true;

      # dhcp & dns for wifi hotspot
      networking.firewall.interfaces.wlo1 = {
        allowedTCPPorts = [ 53 ];
        allowedUDPPorts = [
          53
          67
        ];
      };

      # https://github.com/NixOS/nixpkgs/issues/270809
      systemd.services.ModemManager.wantedBy = [
        "multi-user.target"
        "network.target"
      ];
    };
}
