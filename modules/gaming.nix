{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ heroic protonup-qt ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
