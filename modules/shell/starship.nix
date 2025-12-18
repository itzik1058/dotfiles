{
  flake = {
    modules.homeManager.starship = {
      config = {
        programs.starship = {
          enable = true;
          settings = {
            add_newline = false;
            format = "$directory$git_branch$fill$all$time$line_break$character";
            fill.symbol = " ";
            status.disabled = false;
            time = {
              disabled = false;
              use_12hr = true;
            };
          };
        };
        catppuccin.starship.enable = true;
      };
    };
  };
}
