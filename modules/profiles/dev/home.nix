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
  imports = [ ./neovim.nix ];

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
    ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      vscode = {
        enable = true;
        enableUpdateCheck = true;
        enableExtensionUpdateCheck = true;
        mutableExtensionsDir = true;
        extensions = with pkgs.vscode-extensions; [ mkhl.direnv ];
        keybindings = [ ];
        userSettings = { };
      };
    };

    profiles.dev.neovim.enable = true;
  };
}
