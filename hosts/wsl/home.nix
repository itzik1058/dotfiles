{
  imports = [ ../../profiles/system/home-manager ];
  home-manager.users.nixos = { pkgs, ... }: {
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;

    home.username = "nixos";
    home.homeDirectory = "/home/nixos";

    home.packages = with pkgs; [ gh nixfmt ];

    home.sessionVariables = { EDITOR = "vim"; };

    imports = [ ../../profiles/home/shell ../../profiles/home/direnv ];
  };
}
