{ lib, config, ... }:
let
  cfg = config.profiles.audio;
in
{
  options.profiles.audio = {
    enable = lib.mkEnableOption "audio profile";
  };

  config = lib.mkIf cfg.enable {
    hardware.pulseaudio.enable = false;

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
  };
}
