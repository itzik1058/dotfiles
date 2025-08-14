{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.profiles.system;
in
{
  options.profiles.system = {
    enable = lib.mkEnableOption "system profile";
  };
  config = lib.mkIf cfg.enable {
    nix = {
      enable = false;
      settings.experimental-features = "nix-command flakes";
    };

    nixpkgs.config.allowUnfree = true;

    system = {
      configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
      keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape = true;
      };
    };

    security.pam.services.sudo_local.touchIdAuth = true;

    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
        upgrade = true;
      };
    };

    environment.systemPackages = with pkgs; [
      git
      vim
    ];

    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  };
}
