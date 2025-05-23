# https://github.com/catppuccin/hyprlock
{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.desktop.hyprlock;
in
{
  options.profiles.desktop.hyprlock = {
    enable = lib.mkEnableOption "hyprlock desktop profile";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        "$accent" = "$mauve";
        "$accentAlpha" = "$mauveAlpha";
        "$font" = "JetBrainsMono Nerd Font";
        general = {
          ignore_empty_input = true;
          disable_loading_bar = true;
          hide_cursor = true;
        };

        background = {
          # monitor =
          # path = $HOME/.config/background
          blur_passes = 0;
          color = "$base";
        };

        label = [
          {
            # monitor =
            text = "Layout: $LAYOUT";
            color = "$text";
            font_size = 25;
            font_family = "$font";
            position = "30, -30";
            halign = "left";
            valign = "top";
          }
          {
            # monitor =
            text = "$TIME";
            color = "$text";
            font_size = 90;
            font_family = "$font";
            position = "-30, 0";
            halign = "right";
            valign = "top";
          }

          {
            # monitor =
            text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
            color = "$text";
            font_size = 25;
            font_family = "$font";
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
        ];

        image = {
          # monitor =
          # path = $HOME/.face
          size = 100;
          border_color = "$accent";
          position = "0, 75";
          halign = "center";
          valign = "center";
        };

        input-field = {
          # monitor =
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$surface0";
          font_color = "$text";
          fade_on_empty = false;
          placeholder_text = ''<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>'';
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, -47";
          halign = "center";
          valign = "center";
        };
      };
    };
    catppuccin.hyprlock.enable = true;
  };
}
