{ lib, config, ... }:
let
  cfg = config.profiles.terminal.foot;
in
{
  options.profiles.terminal.foot = {
    enable = lib.mkEnableOption "foot profile";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono NF:size=11:line-height=16px";
        };
        csd = {
          border-width = 2;
          border-color = "ff404040";
        };
      };
    };
    catppuccin.foot.enable = true;
  };
}
