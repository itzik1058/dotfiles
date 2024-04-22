{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.profiles.theme;
in
{
  options.profiles.theme = {
    enable = mkEnableOption "theme profile";
  };

  config = mkIf cfg.enable {
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
}
