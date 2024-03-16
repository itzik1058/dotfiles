{ pkgs, ... }: {
  # GTK2/3
  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # GTK4
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
