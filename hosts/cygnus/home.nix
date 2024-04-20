{
  home-manager.users.koi =
    { pkgs, ... }:
    {
      imports = [ ../../modules/home.nix ];

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

      profiles = {
        audio.enable = true;
        autostart.enable = true;
        dev.enable = true;
        gaming.enable = true;
        gnome.enable = true;
        home-manager.enable = true;
        shell.enable = true;
        theme.enable = true;
      };
    };
}
