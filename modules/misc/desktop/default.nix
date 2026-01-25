{
  flake = {
    modules.nixos.desktop = {
      config = {
        environment.sessionVariables.NIXOS_OZONE_WL = "1";

        services.earlyoom.enable = true;

        programs = {
          localsend = {
            enable = true;
            openFirewall = true;
          };
        };
      };
    };
    modules.homeManager.desktop =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        config = {
          home.packages = with pkgs; [
            android-tools
            bitwarden-desktop
            (discord.override { withVencord = true; })
            libreoffice
            notes
            btop
            nvtopPackages.full
            thunderbird
            obsidian
            onlyoffice-desktopeditors
            qbittorrent
            scrcpy
            telegram-desktop
            wl-clipboard
            pinta
          ];

          programs = {
            firefox = {
              enable = true;
              profiles = {
                default = {
                  settings = {
                    "browser.urlbar.showSearchSuggestionsFirst" = false;

                    # https://bugzilla.mozilla.org/show_bug.cgi?id=1732114
                    "privacy.resistFingerprinting" = false;
                    "privacy.fingerprintingProtection" = true;
                    "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";

                    "sidebar.revamp" = true;
                    "sidebar.revamp.round-content-area" = true;
                    "sidebar.verticalTabs" = true;
                    "sidebar.visibility" = "expand-on-hover";
                    "signon.rememberSignons" = false;
                    "ui.key.menuAccessKeyFocuses" = false;
                  };
                };
              };
            };
            java.enable = true;
            mpv = {
              enable = true;
              scriptOpts = {
                ytdl_hook = {
                  ytdl_path = "${lib.getExe config.programs.yt-dlp.package}";
                };
              };
            };
            yazi.enable = true;
            yt-dlp.enable = true;
          };
          catppuccin.yazi.enable = true;
        };
      };
    modules.darwin.desktop = {
      config = {
        homebrew.casks = [
          "anki"
          "bitwarden"
          "claude"
          "discord"
          "karabiner-elements"
          "ollama-app"
          "telegram"
          "vladdoster/formulae/vimari"
          "whatsapp"
        ];

        system = {
          defaults = {
            controlcenter = {
              BatteryShowPercentage = true;
            };
            NSGlobalDomain = {
              NSWindowShouldDragOnGesture = true;
            };
          };
        };
      };
    };
  };
}
