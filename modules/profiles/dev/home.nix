{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.profiles.dev;
in
{
  options.profiles.dev = {
    enable = lib.mkEnableOption "dev profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gh
      nixfmt-rfc-style
      docker-compose
      sops
      uv
      neovide
    ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      nixvim = import ../../nixvim;
      vscode = {
        enable = true;
        mutableExtensionsDir = true;
        profiles.default = {
          enableUpdateCheck = true;
          enableExtensionUpdateCheck = true;
          extensions = with pkgs.vscode-extensions; [ mkhl.direnv ];
          keybindings = [ ];
          userSettings = { };
        };
      };
    };
  };
}
