{
  imports = [ ../../profiles/system/home-manager ];
  home-manager.users.nixos =
    { config, pkgs, ... }:
    {
      imports = [
        ../../profiles/home
        ../../profiles/home/shell
        ../../profiles/home/direnv
      ];

      home.username = "nixos";
      home.homeDirectory = "/home/nixos";

      # home.sessionVariables = { };

      home.packages = with pkgs; [
        gh
        nixfmt-rfc-style
        python3Full
      ];

      home.file."${config.home.homeDirectory}/.vscode-server/server-env-setup".text = "PATH=$PATH:/run/current-system/sw/bin/";
    };
}
