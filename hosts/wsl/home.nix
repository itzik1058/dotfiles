{
  imports = [ ../../profiles/system/home-manager ];
  home-manager.users.nixos =
    { config, pkgs, ... }:
    {
      imports = [
        ../../profiles/home
        ../../profiles/home/shell
        ../../profiles/home/dev
      ];

      home.username = "nixos";
      home.homeDirectory = "/home/nixos";

      # home.sessionVariables = { };

      home.file."${config.home.homeDirectory}/.vscode-server/server-env-setup".text = "PATH=$PATH:/run/current-system/sw/bin/";
    };
}
