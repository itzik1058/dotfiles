{ inputs, ... }:
{
  flake = {
    modules.nixos.system =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        config = {
          nix = {
            nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
            gc = {
              automatic = true;
              dates = "weekly";
              options = "--delete-older-than 30d";
              persistent = true;
            };
            optimise.automatic = true;
            settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          };

          nixpkgs.config.allowUnfree = true;

          boot.kernel.sysctl."kernel.sysrq" = 438; # debian default
          boot.loader.systemd-boot.memtest86.enable = true;
          boot.loader.grub.memtest86.enable = true;

          zramSwap.enable = true;

          security.sudo.package = pkgs.sudo.override { withInsults = true; };

          services = {
            fstrim.enable = true;
            keyd = {
              enable = true;
              keyboards = {
                default = {
                  ids = [ "*" ];
                  settings = {
                    main = {
                      capslock = "overload(control, esc)";
                    };
                  };
                };
              };
            };
          };

          environment.systemPackages = with pkgs; [
            wget
          ];

          programs = {
            zsh.enable = true;
            git = {
              enable = true;
              lfs.enable = true;
            };
            vim.enable = true;
          };

          fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
        };
      };
    modules.homeManager.system =
      { lib, pkgs, ... }:
      {
        config = {
          xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
            "karabiner/karabiner.json".source = ./karabiner.json;
          };
        };
      };
    modules.darwin.system =
      { pkgs, ... }:
      {
        config = {
          nix = {
            enable = false;
            settings.experimental-features = "nix-command flakes";
          };

          nixpkgs.config.allowUnfree = true;

          system = {
            configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToEscape = true;
            };
          };

          security.pam.services.sudo_local.touchIdAuth = true;

          homebrew = {
            enable = true;
            onActivation = {
              autoUpdate = true;
              cleanup = "uninstall";
              upgrade = true;
            };
          };

          environment.systemPackages = with pkgs; [
            git
            vim
          ];

          fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
        };
      };
  };
}
