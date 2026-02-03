{
  flake = {
    modules.nixos.gnome =
      { pkgs, ... }:
      {
        config = {
          services = {
            displayManager.gdm = {
              enable = true;
              autoSuspend = false;
              debug = true;
            };
            desktopManager.gnome.enable = true;
            gnome.gnome-keyring.enable = true;
            udev.packages = with pkgs; [ gnome-settings-daemon ];
          };

          environment.gnome.excludePackages = with pkgs; [ gnome-console ];
        };
      };
    modules.homeManager.gnome =
      { lib, pkgs, ... }:
      {
        config = {
          home.packages =
            (with pkgs; [
              gnome-firmware
              gnome-software
              gnome-tweaks
              gnome-decoder
              p7zip
              unrar
              geary
              newsflash
              polari
            ])
            ++ (with pkgs.gnomeExtensions; [
              appindicator
              dash-to-dock
              tiling-shell
              blur-my-shell
              ddterm
              home-assistant-extension
            ]);

          dconf = {
            enable = true;
            settings =
              let
                inherit (lib.hm.gvariant) mkTuple mkUint32;
              in
              {
                "org/gnome/desktop/interface".color-scheme = "prefer-dark";
                "org/gnome/desktop/input-sources" = {
                  sources = [
                    (mkTuple [
                      "xkb"
                      "us"
                    ])
                    (mkTuple [
                      "xkb"
                      "il"
                    ])
                  ];
                  xkb-options = [
                    # "caps:escape"
                    "grp:alt_shift_toggle"
                  ];
                };
                "org/gnome/desktop/wm/keybindings" = {
                  maximize = [
                    "<Super>Up"
                    "<Super>k"
                  ];
                  minimize = [ ];
                  move-to-center = [ "<Shift><Super>Space" ];
                  move-to-monitor-down = [
                    "<Control><Super>Down"
                    "<Control><Super>j"
                  ];
                  move-to-monitor-left = [
                    "<Control><Super>Left"
                    "<Control><Super>h"
                  ];
                  move-to-monitor-right = [
                    "<Control><Super>Right"
                    "<Control><Super>l"
                  ];
                  move-to-monitor-up = [
                    "<Control><Super>Up"
                    "<Control><Super>k"
                  ];
                  move-to-side-e = [
                    "<Shift><Super>Right"
                    "<Shift><Super>l"
                  ];
                  move-to-side-n = [
                    "<Shift><Super>Up"
                    "<Shift><Super>k"
                  ];
                  move-to-side-s = [
                    "<Shift><Super>Down"
                    "<Shift><Super>j"
                  ];
                  move-to-side-w = [
                    "<Shift><Super>Left"
                    "<Shift><Super>h"
                  ];
                  switch-to-workspace-left = [
                    "<Control><Alt>Left"
                    "<Control><Alt>h"
                  ];
                  switch-to-workspace-right = [
                    "<Control><Alt>Right"
                    "<Control><Alt>l"
                  ];
                  switch-applications = [ ];
                  switch-applications-backward = [ ];
                  switch-input-source = [ "<Shift>Alt_L" ];
                  switch-input-source-backward = [ "<Alt>Shift_L" ];
                  switch-windows = [ "<Alt>Tab" ];
                  switch-windows-backward = [ "<Shift><Alt>Tab" ];
                  unmaximize = [
                    "<Super>Down"
                    "<Alt>F5"
                    "<Super>j"
                  ];
                };

                "org/gnome/desktop/peripherals/touchpad" = {
                  tap-to-click = true;
                };

                "org/gnome/desktop/wm/preferences" = {
                  resize-with-right-button = true;
                  button-layout = ":minimize,maximize,close";
                };
                "org/gnome/desktop/interface" = {
                  enable-hot-corners = false;
                  show-battery-percentage = true;
                };
                "org/gnome/desktop/session" = {
                  idle-delay = mkUint32 900;
                };

                "org/gnome/settings-daemon/plugins/power" = {
                  sleep-inactive-ac-type = "nothing";
                };

                "org/gnome/settings-daemon/plugins/media-keys" = {
                  screensaver = [ "<Ctrl><Super>l" ];
                };

                "org/gnome/mutter" = {
                  dynamic-workspaces = true;
                };

                "org/gnome/desktop/break-reminders" = {
                  selected-breaks = [
                    "eyesight"
                    "movement"
                  ];
                };

                "org/gnome/desktop/break-reminders/eyesight" = {
                  play-sound = true;
                };

                "org/gnome/desktop/break-reminders/movement" = {
                  duration-seconds = mkUint32 300;
                  interval-seconds = mkUint32 7200;
                  play-sound = true;
                };

                "org/gnome/mutter/keybindings" = {
                  toggle-tiled-left = [
                    "<Super>Left"
                    "<Super>h"
                  ];
                  toggle-tiled-right = [
                    "<Super>Right"
                    "<Super>l"
                  ];
                };

                "org/gnome/shell" = {
                  favorite-apps = [
                    "org.gnome.Nautilus.desktop"
                    "firefox.desktop"
                    "org.gnome.Console.desktop"
                    "com.mitchellh.ghostty.desktop"
                    "Alacritty.desktop"
                    "discord.desktop"
                    "obsidian.desktop"
                    "steam.desktop"
                  ];

                  enabled-extensions = [
                    "appindicatorsupport@rgcjonas.gmail.com"
                    "dash-to-dock@micxgx.gmail.com"
                    "tilingshell@ferrarodomenico.com"
                    "blur-my-shell@aunetx"
                    "ddterm@amezin.github.com"
                  ];
                };

                "org/gnome/shell/app-switcher" = {
                  current-workspace-only = true;
                };

                "org/gnome/shell/extensions/dash-to-dock" = {
                  background-opacity = 0.0;
                  click-action = "minimize-or-previews";
                  custom-theme-shrink = true;
                  dash-max-icon-size = 48;
                  dock-position = "BOTTOM";
                  height-fraction = 0.9;
                  intellihide-mode = "ALL_WINDOWS";
                  multi-monitor = true;
                  show-mounts = false;
                  show-show-apps-button = false;
                  show-trash = false;
                  transparency-mode = "FIXED";
                };

                "org/gnome/Geary" = {
                  run-in-background = true;
                };

                "com/github/amezin/ddterm" = {
                  panel-icon-type = "none";
                  tab-policy = "automatic";
                  window-resizable = false;
                  window-size = 0.4;
                  use-system-font = false;
                  custom-font = "JetBrainsMono Nerd Font 11";
                  # Catppuccin theme
                  background-color = "#1e1e2e";
                  foreground-color = "#cdd6f4";
                  cursor-colors-set = true;
                  cursor-background-color = "#f5e0dc";
                  cursor-foreground-color = "#1e1e2e";
                  highlight-colors-set = true;
                  highlight-background-color = "#f5e0dc";
                  highlight-foreground-color = "#1e1e2e";
                  use-theme-colors = false;
                  palette = [
                    "#45475a" # black
                    "#f38ba8" # red
                    "#a6e3a1" # green
                    "#f9e2af" # yellow
                    "#89b4fa" # blue
                    "#f5c2e7" # magenta
                    "#94e2d5" # cyan
                    "#bac2de" # gray
                    "#585b70" # bright black
                    "#f38ba8" # bright red
                    "#a6e3a1" # bright green
                    "#f9e2af" # bright yellow
                    "#89b4fa" # bright blue
                    "#f5c2e7" # bright magenta
                    "#94e2d5" # bright cyan
                    "#a6adc8" # bright gray
                  ];
                };
              };
          };

          xdg.mimeApps.defaultApplications = {
            "text/plain" = [ "org.gnome.TextEditor.desktop" ];
          };
        };
      };
  };
}
