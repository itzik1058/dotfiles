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
            ];
          };
        };
        catppuccin.ghostty.enable = true;
      };
    };
  };
}
