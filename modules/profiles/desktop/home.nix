{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.desktop;
in
{
  options.profiles.desktop = {
    enable = mkEnableOption "desktop profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell
    ];

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
              "vesktop.desktop"
              "steam.desktop"
            ];

            enabled-extensions = [
              "appindicatorsupport@rgcjonas.gmail.com"
              "dash-to-dock@micxgx.gmail.com"
              "blur-my-shell@aunetx"
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
