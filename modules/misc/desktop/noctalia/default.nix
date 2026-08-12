{
  flake = {
    modules.homeManager.noctalia =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        config = {
          home.packages = with pkgs; [
            mpvpaper
            qt6.qtwebsockets
          ];

          programs.noctalia = {
            enable = true;

            settings = {
              config_version = 12;
              bar = {
                default = {
                  capsule = true;
                  center = [ "workspaces" ];
                  concave_edge_corners = false;
                  end = [
                    "tray"
                    "status"
                    "notifications"
                    "battery"
                    "volume"
                    "brightness"
                    "control-center"
                  ];
                  margin_ends = 0;
                  padding = 6;
                  radius = 0;
                  start = [
                    "launcher"
                    "clock"
                    "sysmon"
                    "privacy"
                    "active_window"
                    "media"
                  ];
                };
              };
              dock = {
                auto_hide = true;
                enabled = true;
                layer = "overlay";
                reserve_space = false;
                show_dots = true;
              };
              lockscreen = {
                blur_intensity = 0.0;
                tint_intensity = 0.0;
              };
              lockscreen_widgets = {
                enabled = false;
                schema_version = 2;
                grid = {
                  cell_size = 16;
                  major_interval = 4;
                  visible = true;
                };
              };
              plugin_settings = {
                "pozzoo/hassio" = {
                  entity_manager_open_near_click = true;
                  entity_manager_placement = "attached";
                };
              };
              plugins = {
                enabled = [
                  "noctalia/mpvpaper"
                  "pozzoo/hassio"
                ];
              };
              shell = {
                niri_overview_type_to_launch_enabled = true;
                telemetry_enabled = true;
                panel = {
                  control_center_placement = "floating";
                  control_center_position = "top_right";
                };
              };
              theme = {
                builtin = "Catppuccin";
                community_palette = "Oxocarbon";
                mode = "dark";
                source = "builtin";
                wallpaper_scheme = "m3-content";
              };
              widget = {
                media = {
                  hide_when_no_media = true;
                };
                privacy = {
                  hide_inactive = true;
                };
                status = {
                  type = "pozzoo/hassio:status";
                };
              };
            };
          };

          programs.niri.settings = {
            spawn-at-startup = [
              { command = [ "noctalia" ]; }
            ];
            binds =
              let
                noctalia = lib.getExe config.programs.noctalia.package;
                ipc = cmd: {
                  action.spawn = [
                    noctalia
                    "msg"
                  ]
                  ++ lib.splitString " " cmd;
                  hotkey-overlay.hidden = true;
                };
              in
              {
                "Mod+Space" = ipc "panel-toggle launcher";
                "Mod+S" = ipc "panel-toggle control-center";
                "Mod+Comma" = ipc "settings-toggle";

                "Super+Alt+L" = ipc "session lock";

                "XF86AudioRaiseVolume" = ipc "volume-up";
                "XF86AudioLowerVolume" = ipc "volume-down";
                "XF86AudioMute" = ipc "volume-mute";
                "XF86AudioMicMute" = ipc "mic-mute";

                "XF86AudioPlay" = ipc "media toggle";
                "XF86AudioStop" = ipc "media pause";
                "XF86AudioPrev" = ipc "media previous";
                "XF86AudioNext" = ipc "media next";

                "XF86MonBrightnessUp" = ipc "brightness-up";
                "XF86MonBrightnessDown" = ipc "brightness-down";
              };
          };
        };
      };
  };
}
