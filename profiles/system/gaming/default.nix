{ pkgs, ... }:
{
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
}
