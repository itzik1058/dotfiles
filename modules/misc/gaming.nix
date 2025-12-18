{
  flake = {
    modules.nixos.gaming =
      { pkgs, ... }:
      {
        config = {
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
      };
    modules.homeManager.gaming = {
      config = {
        programs.mangohud = {
          enable = true;
          enableSessionWide = true;
          settings = {
            toggle_hud = "Shift_L+F11";
            no_display = true;
            full = true;
          };
        };
      };
    };
  };
}
