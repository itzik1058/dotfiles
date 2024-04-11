{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gh
    nixfmt-rfc-style
    vscode
    python3Full
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    neovim.enable = true;
  };
}
