{ lib, config, ... }:
let
  cfg = config.profiles.audio;
in
{
  options.profiles.audio = {
    enable = lib.mkEnableOption "audio profile";
  };

  config = lib.mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      pulseaudio.enable = false;
    };
  };
}
