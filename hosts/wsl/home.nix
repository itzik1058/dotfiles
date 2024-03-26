{ pkgs, ... }: {
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [ gh nixfmt ];

  home.sessionVariables = { EDITOR = "vim"; };

  imports = [ ../../modules/home/shell.nix ../../modules/home/direnv.nix ];
}
