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

              "alt+p=previous_tab"
              "alt+n=next_tab"

              "alt+[=goto_split:previous"
              "alt+]=goto_split:next"
              "alt+h=goto_split:left"
              "alt+j=goto_split:down"
              "alt+k=goto_split:up"
              "alt+l=goto_split:right"

              "alt+shift+h=resize_split:left,200"
              "alt+shift+j=resize_split:down,200"
              "alt+shift+k=resize_split:up,200"
              "alt+shift+l=resize_split:right,200"
              "alt+equal=equalize_splits"

              "alt+;=new_split:down"
              "alt+'=new_split:right"
            ];
          };
        };
        catppuccin.ghostty.enable = true;
      };
    };
  };
}
