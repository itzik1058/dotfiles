{ pkgs, ... }:
{
  system.stateVersion = 6;

  system.primaryUser = "koi";

  networking.hostName = "lyra";

  users.users.koi = {
    home = "/Users/koi";
    shell = pkgs.zsh;
  };
  home-manager.users.koi = import ./users/koi.nix;

  profiles = {
    desktop.enable = true;
    dev.enable = true;
    system.enable = true;
  };
}
