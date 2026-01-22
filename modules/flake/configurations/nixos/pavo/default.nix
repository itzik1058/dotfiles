{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    audio
    desktop
    dev
    gaming
    gnome
    home-manager
    hyprland
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
    hyprland
    shell
    starship
    theme
    tmux
    zsh
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
