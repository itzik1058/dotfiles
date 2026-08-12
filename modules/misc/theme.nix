{
  flake = {
    modules.homeManager.theme =
      { pkgs, ... }:
      {
        config = {
          catppuccin = {
            enable = true;
            autoEnable = false;
            flavor = "mocha";
          };

          home.pointerCursor = {
            enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 24;
            gtk.enable = true;
          };

          # GTK2/3
          gtk = rec {
            enable = true;
            theme = {
              package = pkgs.gnome-themes-extra;
              name = "Adwaita-dark";
            };
            iconTheme = {
              package = pkgs.papirus-icon-theme;
              name = "Papirus";
            };
            gtk4.theme = theme;
          };

          # GTK4
          dconf = {
            enable = true;
            settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
          };

          qt = {
            enable = true;
            platformTheme.name = "gtk3";
            style = {
              package = pkgs.adwaita-qt;
              name = "adwaita-dark";
            };
          };
        };
      };
  };
}
