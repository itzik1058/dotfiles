{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.audio;
in
{
  options.profiles.audio = {
    enable = lib.mkEnableOption "audio profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      helvum
      qpwgraph
    ];

    services.easyeffects.enable = true;

    dconf = {
      enable = true;
      settings = {
        "com/github/wwmm/easyeffects/streaminputs".plugins = [ "rnnoise#0" ];

        "com/github/wwmm/easyeffects/streaminputs/rnnoise/0" = {
          bypass = false;
          enable-vad = true;
          output-gain = 0.0;
          release = 200.0;
          vad-thres = 75.0;
          wet = 0.0;
        };
      };
    };
  };
}
