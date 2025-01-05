{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.shell.starship;
in
{
  options.profiles.shell.starship = {
    enable = lib.mkEnableOption "starship profile";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = "$directory$git_branch$fill$all$time$line_break$character";
        fill.symbol = " ";
        status.disabled = false;
        time = {
          disabled = false;
          use_12hr = true;
        };
        palette = "catppuccin_mocha";
        palettes.catppuccin_mocha = {
          # https://github.com/catppuccin/starship
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };
  };
}
