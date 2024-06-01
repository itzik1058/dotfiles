{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.desktop.gnome;
in
{
  options.profiles.desktop.gnome = {
    enable = lib.mkEnableOption "gnome desktop profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = (
      (with pkgs; [
        p7zip
        unrar
        newsflash
      ])
      ++ (with pkgs.gnome; [
        gnome-tweaks
        gnome-software
      ])
      ++ (with pkgs.gnomeExtensions; [
        appindicator
        dash-to-dock
        blur-my-shell
        ddterm
      ])
    );

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
              "caps:escape"
              "grp:alt_shift_toggle"
            ];
          };
          "org/gnome/desktop/wm/keybindings" = {
            switch-applications = [ ];
            switch-applications-backward = [ ];
            switch-input-source = [ "<Shift>Alt_L" ];
            switch-input-source-backward = [ "<Alt>Shift_L" ];
            switch-windows = [ "<Alt>Tab" ];
            switch-windows-backward = [ "<Shift><Alt>Tab" ];
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

          "org/gnome/mutter" = {
            dynamic-workspaces = true;
          };

          "org/gnome/shell" = {
            favorite-apps = [
              "org.gnome.Nautilus.desktop"
              "firefox.desktop"
              "org.gnome.Console.desktop"
              "Alacritty.desktop"
              "vesktop.desktop"
              "steam.desktop"
            ];

            enabled-extensions = [
              "appindicatorsupport@rgcjonas.gmail.com"
              "dash-to-dock@micxgx.gmail.com"
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

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "org.gnome.TextEditor.desktop" ];
      };
    };
  };
}
