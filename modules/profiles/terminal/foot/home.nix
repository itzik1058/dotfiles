{ lib, config, ... }:
with lib;
let
  cfg = config.profiles.desktop.terminal.foot;
in
{
  options.profiles.desktop.terminal.foot = {
    enable = mkEnableOption "foot profile";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;

      settings = {
        main = {
          font = "JetBrainsMono NF:size=11:line-height=16px";
        };
        colors = {
          foreground = "cdd6f4";
          background = "1e1e2e";
          regular0 = "bac2de";
          regular1 = "f38ba8";
          regular2 = "a6e3a1";
          regular3 = "f9e2af";
          regular4 = "89b4fa";
          regular5 = "f5c2e7";
          regular6 = "94e2d5";
          regular7 = "585b70";
          bright0 = "a6adc8";
          bright1 = "f38ba8";
          bright2 = "a6e3a1";
          bright3 = "f9e2af";
          bright4 = "89b4fa";
          bright5 = "f5c2e7";
          bright6 = "94e2d5";
          bright7 = "45475a";
        };
        csd = {
          border-width = 2;
          border-color = "ff404040";
        };
      };
    };
  };
}