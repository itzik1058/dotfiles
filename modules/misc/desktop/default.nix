{
  flake = {
    modules.nixos.desktop =
      { pkgs, ... }:
      {
        config = {
          environment.sessionVariables.NIXOS_OZONE_WL = "1";

          fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

          services = {
            earlyoom.enable = true;
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
          home = {
            preferXdgDirectories = true;
            sessionVariables = {
              "_JAVA_AWT_WM_NONREPARENTING" = "1";
            };

            packages =
              with pkgs;
              [
                android-tools
                bitwarden-desktop
                btop
                notes
                qbittorrent
                scrcpy
                telegram-desktop
                thunderbird
              ]
              ++ lib.optionals pkgs.stdenv.isLinux [
                libreoffice
                onlyoffice-desktopeditors
                pinta
                wl-clipboard
              ]
              ++ lib.optionals pkgs.stdenv.isDarwin [
                whatsapp-for-mac
              ];
          };

          xdg = {
            autostart = {
              enable = true;
              readOnly = true;
              entries = [
                "${config.programs.discord.package}/share/applications/discord.desktop"
                "${config.programs.firefox.package}/share/applications/firefox.desktop"
              ];
            };
            mimeApps = lib.mkIf pkgs.stdenv.isLinux {
              enable = true;
              defaultApplicationPackages = with pkgs; [
                firefox
                thunderbird
              ];
            };
          };

          programs = {
            discord = {
              enable = true;
              package = (pkgs.discord.override { withVencord = true; });
              settings.DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
            };
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
            obsidian.enable = true;
            java.enable = true;
            mpv = {
              enable = true;
              scriptOpts = {
                ytdl_hook = {
                  ytdl_path = "${lib.getExe config.programs.yt-dlp.package}";
                };
              };
            };
            yazi = {
              enable = true;
              shellWrapperName = "y";
            };
            yt-dlp.enable = true;
          };
          catppuccin.yazi.enable = true;
        };
      };
    modules.darwin.desktop = {
      config = {
        system = {
          defaults = {
            controlcenter = {
              BatteryShowPercentage = true;
            };
            dock = {
              mru-spaces = false;
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
