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
        "com/github/wwmm/easyeffects/streaminputs".plugins = [
          "rnnoise#0"
          "deepfilternet#0"
        ];

        "com/github/wwmm/easyeffects/streaminputs/deepfilternet/0" = {
          bypass = false;
        };

        "com/github/wwmm/easyeffects/streaminputs/rnnoise/0" = {
          bypass = false;
          enable-vad = false;
        };
      };
    };
  };
}
