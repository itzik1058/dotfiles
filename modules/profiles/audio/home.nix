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

    services.easyeffects = {
      enable = true;
      extraPresets = {
        "Noise Reduction" = {
          input = {
            blocklist = [ ];
            plugins_order = [ "rnnoise#0" ];
            "rnnoise#0" = {
              bypass = false;
              enable-vad = true;
              input-gain = 0;
              model-name = "\"\"";
              output-gain = 0;
              release = 20;
              use-standard-model = true;
              vad-thres = 50;
              wet = 0;
            };
          };
        };
      };
    };
  };
}
