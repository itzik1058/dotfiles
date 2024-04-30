{ lib, config, ... }:
with lib;
let
  cfg = config.profiles.desktop.terminal.alacritty;
in
{
  options.profiles.desktop.terminal.alacritty = {
    enable = mkEnableOption "alacritty profile";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        keyboard.bindings = [
          {
            key = "H";
            mods = "Shift";
            mode = "Vi";
            action = "FirstOccupied";
          }
          {
            key = "L";
            mods = "Shift";
            mode = "Vi";
            action = "Last";
          }
        ];
        colors = {
          # https://github.com/catppuccin/alacritty
          bright = {
            black = "#585b70";
            blue = "#89b4fa";
            cyan = "#94e2d5";
            green = "#a6e3a1";
            magenta = "#f5c2e7";
            red = "#f38ba8";
            white = "#a6adc8";
            yellow = "#f9e2af";
          };
          cursor = {
            cursor = "#f5e0dc";
            text = "#1e1e2e";
          };
          dim = {
            black = "#45475a";
            blue = "#89b4fa";
            cyan = "#94e2d5";
            green = "#a6e3a1";
            magenta = "#f5c2e7";
            red = "#f38ba8";
            white = "#bac2de";
            yellow = "#f9e2af";
          };
          footer_bar = {
            background = "#a6adc8";
            foreground = "#1e1e2e";
          };
          hints = {
            end = {
              background = "#a6adc8";
              foreground = "#1e1e2e";
            };
            start = {
              background = "#f9e2af";
              foreground = "#1e1e2e";
            };
          };
          indexed_colors = [
            {
              color = "#fab387";
              index = 16;
            }
            {
              color = "#f5e0dc";
              index = 17;
            }
          ];
          normal = {
            black = "#45475a";
            blue = "#89b4fa";
            cyan = "#94e2d5";
            green = "#a6e3a1";
            magenta = "#f5c2e7";
            red = "#f38ba8";
            white = "#bac2de";
            yellow = "#f9e2af";
          };
          primary = {
            background = "#1e1e2e";
            bright_foreground = "#cdd6f4";
            dim_foreground = "#7f849c";
            foreground = "#cdd6f4";
          };
          search = {
            focused_match = {
              background = "#a6e3a1";
              foreground = "#1e1e2e";
            };
            matches = {
              background = "#a6adc8";
              foreground = "#1e1e2e";
            };
          };
          selection = {
            background = "#f5e0dc";
            text = "#1e1e2e";
          };
          vi_mode_cursor = {
            cursor = "#b4befe";
            text = "#1e1e2e";
          };
        };
        font = {
          normal = {
            family = "JetBrains Mono NF";
          };
        };
      };
    };
  };
}
