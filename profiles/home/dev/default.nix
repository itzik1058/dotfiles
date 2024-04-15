{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gh
    nixfmt-rfc-style
    vscode
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
  };
}
