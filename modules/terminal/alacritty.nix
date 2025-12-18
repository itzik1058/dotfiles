{
  flake = {
    modules.homeManager.alacritty = {
      config = {
        programs = {
          alacritty = {
            enable = true;
            settings = {
              keyboard.bindings = [
                {
                  key = "H";
                  mods = "Shift";
                  mode = "Vi";
                  action = "FirstOccupied";
                }
                {
                  key = "L";
                  mods = "Shift";
                  mode = "Vi";
                  action = "Last";
                }
              ];
              # env.TERM = "xterm-256color";
              font = {
                normal = {
                  family = "JetBrains Mono NF";
                };
              };
            };
          };
          tmux.extraConfig = ''
            set -as terminal-overrides ",alacritty*:RGB"
          '';
        };
        catppuccin.alacritty.enable = true;
      };
    };
  };
}
