{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.audio;
in
{
  options.profiles.audio = {
    enable = mkEnableOption "audio profile";
  };

  config = mkIf cfg.enable {
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
