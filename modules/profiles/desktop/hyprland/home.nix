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
          swaync-client = lib.getExe' pkgs.swaynotificationcenter "swaync-client";
          swayosd-client = lib.getExe' config.services.swayosd.package "swayosd-client";
          terminal = lib.getExe config.profiles.terminal.package;
          tmux = lib.getExe config.programs.tmux.package;
          tofi-drun = lib.getExe' config.programs.tofi.package "tofi-drun";
          wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
        in
        {
          animations.animation = [
            "specialWorkspace, 1, 4, default, slidevert"
          ];
          bind = [
            "SUPER, grave, hyprexpo:expo, toggle"
            "SUPER, Q, killactive,"
            "SUPER, M, togglefloating"
            "SUPER, Z, fullscreen"
            "SUPER, V, exec, ${cliphist} list | tofi | ${cliphist} decode | ${wl-copy}"
            "SUPER, N, exec, ${swaync-client} -t"
            "SUPER, Return, exec, ${tofi-drun} | xargs hyprctl dispatch exec --"
            "SUPER ALT, L, exec, loginctl lock-session"

            "SUPER, h, movefocus, l"
            "SUPER, l, movefocus, r"
            "SUPER, k, movefocus, u"
            "SUPER, j, movefocus, d"
            "SUPER, left, movefocus, l"
            "SUPER, right, movefocus, r"
            "SUPER, up, movefocus, u"
            "SUPER, down, movefocus, d"

            "SUPER SHIFT, h, movewindow, l"
            "SUPER SHIFT, l, movewindow, r"
            "SUPER SHIFT, k, movewindow, u"
            "SUPER SHIFT, j, movewindow, d"
            "SUPER SHIFT, left, movewindow, l"
            "SUPER SHIFT, right, movewindow, r"
            "SUPER SHIFT, up, movewindow, u"
            "SUPER SHIFT, down, movewindow, d"

            "ALT, Tab, cyclenext"
            "ALT, Tab, bringactivetotop"

            "SUPER, 1, workspace, 1"
            "SUPER, 2, workspace, 2"
            "SUPER, 3, workspace, 3"
            "SUPER, 4, workspace, 4"
            "SUPER, 5, workspace, 5"
            "SUPER, 6, workspace, 6"
            "SUPER, 7, workspace, 7"
            "SUPER, 8, workspace, 8"
            "SUPER, 9, workspace, 9"
            "SUPER, 0, workspace, 0"
            "SUPER SHIFT, 1, movetoworkspace, 1"
            "SUPER SHIFT, 2, movetoworkspace, 2"
            "SUPER SHIFT, 3, movetoworkspace, 3"
            "SUPER SHIFT, 4, movetoworkspace, 4"
            "SUPER SHIFT, 5, movetoworkspace, 5"
            "SUPER SHIFT, 6, movetoworkspace, 6"
            "SUPER SHIFT, 7, movetoworkspace, 7"
            "SUPER SHIFT, 8, movetoworkspace, 8"
            "SUPER SHIFT, 9, movetoworkspace, 9"
            "SUPER SHIFT, 0, movetoworkspace, 0"
            "SUPER, Tab, workspace, e+1"
            "SUPER SHIFT, Tab, workspace, e-1"

            ", F12, toggleSpecialWorkspace, terminal"

            ", PRINT, exec, ${hyprshot} -m region"
            "SHIFT, PRINT, exec, ${hyprshot} -m output"
            "SUPER, PRINT, exec, ${hyprshot} -m window"
          ];
          bindel = [
            ",XF86AudioLowerVolume, exec, ${swayosd-client} --output-volume lower --max-volume 100"
            ",XF86AudioRaiseVolume, exec, ${swayosd-client} --output-volume raise --max-volume 100"
            ",XF86AudioMute, exec, ${swayosd-client} --output-volume mute-toggle"
            ",XF86AudioMicMute, exec, ${swayosd-client} --input-volume mute-toggle"
            ",XF86MonBrightnessDown, exec, ${swayosd-client} --brightness lower"
            ",XF86MonBrightnessUp, exec, ${swayosd-client} --brightness raise"
          ];
          bindl = [
            ",XF86AudioPlay, exec, ${playerctl} play-pause"
            ",XF86AudioPause, exec, ${playerctl} play-pause"
            ",XF86AudioNext, exec, ${playerctl} next"
            ",XF86AudioPrev, exec, ${playerctl} previous"
          ];
          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
            "SUPER ALT, mouse:272, resizewindow"
          ];
          bindr = [
            "SUPER, SUPER_L, hyprexpo:expo, toggle"
            "CAPS, Caps_Lock, exec, ${swayosd-client} --caps-lock"
          ];
          general.gaps_out = 10;
          input = {
            kb_layout = "us,il";
            kb_options = [ "grp:alt_shift_toggle" ];
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
            };
          };
          windowrulev2 = [
            "float, class:nm-connection-editor"
            "float, class:\\.blueman.*"
            "float, class:org.pulseaudio.pavucontrol"
            "float, class:brasero"

            "noblur, class:com.mitchellh.ghostty"
          ];
          workspace = [
            "special:terminal, on-created-empty:${terminal} -e ${tmux} new-session -As0"
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
