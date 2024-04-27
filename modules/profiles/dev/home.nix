{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.dev;
in
{
  imports = [ ./python.nix ];

  options.profiles.dev = {
    enable = mkEnableOption "dev profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gh
      nixfmt-rfc-style
      docker-compose
    ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      neovim.enable = true;
      vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [ ];
      };
    };

    profiles.dev.python.enable = true;
  };
}
