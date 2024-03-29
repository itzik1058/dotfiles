{ pkgs, ... }: {
  home.packages = with pkgs; [ helvum qpwgraph ];

  services.easyeffects.enable = true;

  dconf = {
    enable = true;
    settings = {
      "com/github/wwmm/easyeffects/streaminputs".plugins =
        [ "rnnoise#0" "deepfilternet#0" ];

      "com/github/wwmm/easyeffects/streaminputs/deepfilternet/0" = {
        bypass = false;
      };

      "com/github/wwmm/easyeffects/streaminputs/rnnoise/0" = {
        bypass = false;
        enable-vad = false;
      };
    };
  };
}
