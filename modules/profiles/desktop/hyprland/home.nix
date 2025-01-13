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

    services.hypridle = {
      enable = true;
      settings = import ./hypridle.nix;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
      };

      plugins = with pkgs.hyprlandPlugins; [ hyprexpo ];
      settings = {
        input = {
          kb_layout = "us,il";
          kb_options = [ "grp:alt_shift_toggle" ];
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };
        };
        "$mod" = "SUPER";
        exec-once = [
          "${lib.getExe config.services.swaync.package}"
        ];
        bind = [
          "$mod, grave, hyprexpo:expo, toggle"
          "$mod, Q, killactive,"
          "$mod, M, togglefloating"
          "$mod, Z, fullscreen"
          "$mod, F12, exec, ${lib.getExe config.programs.alacritty.package}"
          "$mod, Return, exec, ${lib.getExe' config.programs.tofi.package "tofi-drun"} | xargs hyprctl dispatch exec --"

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

          ", PRINT, exec, ${lib.getExe pkgs.hyprshot} -m region"
          "SHIFT, PRINT, exec, ${lib.getExe pkgs.hyprshot} -m output"
          "$mod, PRINT, exec, ${lib.getExe pkgs.hyprshot} -m window"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];
        bindl = [
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
        ];
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ];
        windowrulev2 = [
          "noborder, class:^(tofi)$"
          "center, class:^(tofi)$"
          "float, class:nm-connection-editor|blueman-manager"
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
