{
  lib,
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
          height = 20;
          modules-left = [ "hyprland/window" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "pulseaudio"
            "network"
            "temperature"
            "battery"
            "clock"
          ];
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
          clock = {
            tooltip-format = "{:%B %d}";
            format-alt = "{:%c}";
          };
          cpu = {
            format = "  {usage}%";
            tooltip = false;
          };
          memory = {
            format = "{}%  ";
          };
          temperature = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
            ];
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-full = "{icon} {capacity}%";
            format-charging = "  {capacity}%";
            format-plugged = " {capacity}%";
            format-alt = "{time} {icon}";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
          };
          network = {
            format-wifi = "  {signalStrength}%";
            format-ethernet = "  {ifname}";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "  {ifname} (No IP)";
            format-disconnected = "⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = "";
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
            on-click = "pavucontrol";
          };
        }
      ];
    };
    catppuccin.waybar.enable = true;
  };
}
