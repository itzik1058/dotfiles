{ pkgs, ... }:
{
  imports = [ ./direnv ];

  home.packages = with pkgs; [
    gh
    nixfmt-rfc-style
    vscode
    python3Full
  ];
}
