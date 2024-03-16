{ lib, ... }: {
  dconf = {
    enable = true;
    settings = let inherit (lib.hm.gvariant) mkTuple;
    in {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "il" ]) ];
        xkb-options = [ "caps:escape" "grp:alt_shift_toggle" ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [ "<Shift>Alt_L" ];
        switch-input-source-backward = [ "<Alt>Shift_L" ];
      };
    };
  };
}
