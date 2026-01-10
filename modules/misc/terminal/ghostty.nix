{
  flake = {
    modules.homeManager.ghostty = {
      config = {
        programs.ghostty = {
          enable = true;
          settings = {
            font-size = 11;
            keybind = [
              "ctrl+comma=unbind"
              "ctrl+shift+comma=unbind"

              "alt+h=goto_split:left"
              "alt+j=goto_split:down"
              "alt+k=goto_split:up"
              "alt+l=goto_split:right"

              "ctrl+a>alt+h=resize_split:left,200"
              "ctrl+a>alt+j=resize_split:down,200"
              "ctrl+a>alt+k=resize_split:up,200"
              "ctrl+a>alt+l=resize_split:right,200"
              "ctrl+a>alt+equal=equalize_splits"

              "ctrl+a>shift+quote=new_split:down"
              "ctrl+a>shift+5=new_split:right"
            ];
          };
        };
        catppuccin.ghostty.enable = true;
      };
    };
  };
}
