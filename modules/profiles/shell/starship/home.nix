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
      };
    };
    catppuccin.starship.enable = true;
  };
}
