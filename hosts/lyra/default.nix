{ pkgs, ... }:
{
  system.stateVersion = 6;

  system.primaryUser = "koi";

  networking.hostName = "lyra";

  users.users.koi.home = "/Users/koi";
  home-manager.users.koi = import ./users/koi.nix;

  services = {
    karabiner-elements = {
      enable = true;
      package = pkgs.karabiner-elements.overrideAttrs (old: {
        version = "14.13.0";

        src = pkgs.fetchurl {
          inherit (old.src) url;
          hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
        };

        dontFixup = true;
      });
    };
  };

  profiles = {
    desktop.enable = true;
    dev.enable = true;
    system.enable = true;
  };
}
