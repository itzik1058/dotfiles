{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.desktop.waybar;
in
{
  options.profiles.desktop.waybar = {
    enable = lib.mkEnableOption "waybar desktop profile";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = builtins.readFile ./style.css;
      settings = [
        {
          margin-top = 5;
          margin-left = 5;
          margin-right = 5;
          modules-left = [ "hyprland/window" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "tray"
            "pulseaudio"
            "battery"
            "hyprland/language"
            "clock"
          ];
          "hyprland/language" = {
            format = "{shortDescription}";
          };
          "hyprland/window" = {
            format = "{}";
            max-len = 30;
            separate-outputs = true;
          };
          "hyprland/workspaces" = {
            on-click = "activate";
            # format = "icon";
            format-icons = {
              active = " ";
            };
            sort-by = "number";
          };
          tray = {
            spacing = 8;
          };
          clock = {
            tooltip-format = "{:%B %d}";
            format-alt = "{:%c}";
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-full = "{icon}";
            format-charging = " ";
            format-plugged = "";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
            tooltip-format = "{capacity}% ({time})";
          };
          pulseaudio = {
            format = "{icon}";
            format-muted = "";
            format-bluetooth = "{icon}";
            format-bluetooth-muted = " ";
            format-icons = {
              headphone = "";
              hands-free = "󰋎";
              headset = "󰋎";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            tooltip-format = "{volume}% ({format_source})";
            on-click = "${lib.getExe pkgs.pavucontrol}";
          };
        }
      ];
    };
    catppuccin.waybar.enable = true;
  };
}
