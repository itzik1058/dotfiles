{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.desktop.hyprland;
in
{
  options.profiles.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland desktop profile";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      ghostty.settings.window-decoration = false;
      tofi = {
        enable = true;
        settings = {
          matching-algorithm = "fuzzy";
          font = "JetBrainsMono Nerd Font";
          font-size = 16;
          width = "50%";
          height = "50%";
          outline-width = 0;
          border-width = 0;
          corner-radius = 12;
          prompt-text = ">>";
          num-results = 0;
          result-spacing = 0;
        };
      };
    };

    catppuccin.tofi.enable = true;

    services = {
      blueman-applet.enable = true;
      cliphist.enable = true;
      hypridle = {
        enable = true;
        settings = import ./hypridle.nix;
      };
      hyprpaper = {
        enable = true;
        settings = {
          preload = [ "${./wallpaper.png}" ];
          wallpaper = [ ",${./wallpaper.png}" ];
        };
      };
      network-manager-applet.enable = true;
      swayosd.enable = true;
      udiskie.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
      };

      plugins = with pkgs.hyprlandPlugins; [ hyprexpo ];
      settings =
        let
          cliphist = lib.getExe config.services.cliphist.package;
          hyprshot = lib.getExe pkgs.hyprshot;
          playerctl = lib.getExe pkgs.playerctl;
          swayosd-client = lib.getExe' config.services.swayosd.package "swayosd-client";
          swaync-client = lib.getExe' pkgs.swaynotificationcenter "swaync-client";
          terminal = lib.getExe config.profiles.terminal.package;
          tofi-drun = lib.getExe' config.programs.tofi.package "tofi-drun";
          wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
        in
        {
          general = {
            gaps_out = 10;
          };
          input = {
            kb_layout = "us,il";
            kb_options = [ "grp:alt_shift_toggle" ];
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
            };
          };
          exec-once = [
            "${terminal}"
          ];

          "$mod" = "SUPER";
          bind = [
            "$mod, grave, hyprexpo:expo, toggle"
            "$mod, Q, killactive,"
            "$mod, M, togglefloating"
            "$mod, Z, fullscreen"
            "$mod, V, exec, ${cliphist} list | tofi | ${cliphist} decode | ${wl-copy}"
            "$mod, N, exec, ${swaync-client} -t"
            "$mod, F12, exec, ${terminal}"
            "$mod, Return, exec, ${tofi-drun} | xargs hyprctl dispatch exec --"
            "$mod ALT, L, exec, loginctl lock-session"

            "$mod, h, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            "$mod SHIFT, h, movewindow, l"
            "$mod SHIFT, l, movewindow, r"
            "$mod SHIFT, k, movewindow, u"
            "$mod SHIFT, j, movewindow, d"
            "$mod SHIFT, left, movewindow, l"
            "$mod SHIFT, right, movewindow, r"
            "$mod SHIFT, up, movewindow, u"
            "$mod SHIFT, down, movewindow, d"

            "ALT, Tab, cyclenext"
            "ALT, Tab, bringactivetotop"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 0"
            "$mod SHIFT, 1, movetoworkspace, 1"
            "$mod SHIFT, 2, movetoworkspace, 2"
            "$mod SHIFT, 3, movetoworkspace, 3"
            "$mod SHIFT, 4, movetoworkspace, 4"
            "$mod SHIFT, 5, movetoworkspace, 5"
            "$mod SHIFT, 6, movetoworkspace, 6"
            "$mod SHIFT, 7, movetoworkspace, 7"
            "$mod SHIFT, 8, movetoworkspace, 8"
            "$mod SHIFT, 9, movetoworkspace, 9"
            "$mod SHIFT, 0, movetoworkspace, 0"
            "$mod, Tab, workspace, e+1"
            "$mod SHIFT, Tab, workspace, e-1"

            ", PRINT, exec, ${hyprshot} -m region"
            "SHIFT, PRINT, exec, ${hyprshot} -m output"
            "$mod, PRINT, exec, ${hyprshot} -m window"
          ];
          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
          ];
          bindr = [
            "SUPER, SUPER_L, hyprexpo:expo, toggle"
            "CAPS, Caps_Lock, exec, ${swayosd-client} --caps-lock"
          ];
          bindl = [
            ",XF86AudioPlay, exec, ${playerctl} play-pause"
            ",XF86AudioPause, exec, ${playerctl} play-pause"
            ",XF86AudioNext, exec, ${playerctl} next"
            ",XF86AudioPrev, exec, ${playerctl} previous"
          ];
          bindel = [
            ",XF86AudioLowerVolume, exec, ${swayosd-client} --output-volume lower --max-volume 100"
            ",XF86AudioRaiseVolume, exec, ${swayosd-client} --output-volume raise --max-volume 100"
            ",XF86AudioMute, exec, ${swayosd-client} --output-volume mute-toggle"
            ",XF86AudioMicMute, exec, ${swayosd-client} --input-volume mute-toggle"
            ",XF86MonBrightnessDown, exec, ${swayosd-client} --brightness lower"
            ",XF86MonBrightnessUp, exec, ${swayosd-client} --brightness raise"
          ];

          windowrulev2 = [
            "float, class:nm-connection-editor"
            "float, class:\\.blueman.*"
            "float, class:org.pulseaudio.pavucontrol"

            "noblur, class:com.mitchellh.ghostty"
          ];
        };
    };

    profiles.desktop = {
      hyprlock.enable = true;
      swaync.enable = true;
      waybar.enable = true;
    };
  };
}
