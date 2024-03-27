{
  imports = [ ../../profiles/system/home-manager ];
  home-manager.users.nixos = { config, pkgs, ... }: {
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;

    home.username = "nixos";
    home.homeDirectory = "/home/nixos";

    home.packages = with pkgs; [ gh nixfmt ];

    home.sessionVariables = { EDITOR = "vim"; };

    home.file."${config.home.homeDirectory}/.vscode-server/server-env-setup".text =
      "PATH=$PATH:/run/current-system/sw/bin/";

    imports = [ ../../profiles/home/shell ../../profiles/home/direnv ];
  };
}
