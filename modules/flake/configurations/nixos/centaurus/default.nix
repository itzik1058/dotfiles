{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    audio
    desktop
    dev
    gaming
    gnome
    home-manager
    niri
    sops
    ssh
    wireguard
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    audio
    desktop
    dev
    gaming
    ghostty
    gnome
    home-manager
    niri
    noctalia
    shell
    sops
    starship
    theme
    tmux
    zsh
  ];
in
{
  flake.modules.nixos."hosts/centaurus" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = nixosModules ++ [ ./_hardware.nix ];

      system.stateVersion = "25.05";

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        binfmt.emulatedSystems = [ "aarch64-linux" ];
        zswap.enable = true;
      };

      sops = {
        defaultSopsFile = ../../../../../secrets/centaurus.yaml;
        secrets = {
          "koi-password" = {
            neededForUsers = true;
          };
        };
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
        hashedPasswordFile = config.sops.secrets."koi-password".path;
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

          home.stateVersion = "26.05";
          home.packages = with pkgs; [ prismlauncher ];

          services.ollama = {
            enable = true;
            environmentVariables = {
              OLLAMA_CONTEXT_LENGTH = "16384";
            };
          };

          programs.niri.settings = {
            input.mouse = {
              accel-speed = 0.5;
            };
            outputs = {
              "DP-1" = {
                mode = {
                  width = 3440;
                  height = 1440;
                  refresh = 164.900;
                };
                variable-refresh-rate = "on-demand";
              };
            };
          };

          dconf.settings."org/gnome/shell".enabled-extensions = [ "hass-gshell@geoph9-on-github" ];
        };

      services = {
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

      programs.solaar = {
        enable = true;
        userService.enable = true;
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
