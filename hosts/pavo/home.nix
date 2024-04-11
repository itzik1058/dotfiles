{
  imports = [ ../../profiles/system/home-manager ];
  home-manager.users.koi =
    { config, pkgs, ... }:
    {
      imports = [
        ../../profiles/home
        ../../profiles/home/gnome
        ../../profiles/home/shell
        ../../profiles/home/audio
        ../../profiles/home/theme
        ../../profiles/home/dev
      ];

      home.username = "koi";
      home.homeDirectory = "/home/koi";

      home.packages = with pkgs; [
        firefox
        tree
        gnome.gnome-software
      ];

      home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
      };

      # home.sessionVariables = { };
    };
}
