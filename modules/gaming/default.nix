{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.gaming;
in
{
  options.profiles.gaming = {
    enable = mkEnableOption "gaming module";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      heroic
      protonup-qt
    ];

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };

      gamemode.enable = true;
    };

    networking.firewall = {
      allowedUDPPorts = [
        27016 # Grim Dawn
      ];
    };

    # services.miniupnpd.enable = true; # Potential security risk
  };
}