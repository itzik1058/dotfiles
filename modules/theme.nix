{
  flake = {
    modules.homeManager.theme =
      { pkgs, ... }:
      {
        config = {
          catppuccin.flavor = "mocha";

          home.pointerCursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 24;
            gtk.enable = true;
          };

          # GTK2/3
          gtk = {
            enable = true;
            theme = {
              package = pkgs.gnome-themes-extra;
              name = "Adwaita-dark";
            };
            iconTheme = {
              package = pkgs.papirus-icon-theme;
              name = "Papirus";
            };
          };

          # GTK4
          dconf = {
            enable = true;
            settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
          };

          qt = {
            enable = true;
            platformTheme.name = "gtk";
            style = {
              package = pkgs.adwaita-qt;
              name = "adwaita-dark";
            };
          };
        };
      };
  };
}
