{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.gaming;
in
{
  options.profiles.gaming = {
    enable = lib.mkEnableOption "gaming profile";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };

      gamemode.enable = true;
    };

    # services.miniupnpd.enable = true; # Potential security risk
  };
}
