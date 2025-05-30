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
  imports = [ ./nixvim.nix ];

  options.profiles.dev = {
    enable = lib.mkEnableOption "dev profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sshfs
      gh
      lazygit
      nixfmt-rfc-style
      docker-compose
      lazydocker
      sops
      uv
      neovide
    ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      nixvim = {
        enable = true;
        defaultEditor = true;
        vimdiffAlias = true;
      };
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
