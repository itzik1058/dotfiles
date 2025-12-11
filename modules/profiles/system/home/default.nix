{
  lib,
  pkgs,
  config,
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
    sops = {
      defaultSopsFile = ../../../secrets/default.yaml;
      age = {
        sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        generateKey = true;
      };
    };

    xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
      "karabiner/karabiner.json".source = ./karabiner.json;
    };
  };
}
