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
  options.profiles.dev = {
    enable = mkEnableOption "dev profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gh
      nixfmt-rfc-style
      docker-compose
      (buildFHSUserEnv {
        name = "python-fhs";
        targetPkgs = pkgs: (with pkgs; [ python3 ]);
        profile = ''
          export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
        '';
        runScript = "$SHELL";
      })
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
  };
}
