{
  flake = {
    modules.homeManager.foot = {
      config = {
        programs.foot = {
          enable = true;
          settings = {
            main = {
              font = "JetBrainsMono NF:size=11:line-height=16px";
            };
            csd = {
              border-width = 2;
              border-color = "ff404040";
            };
          };
        };
        catppuccin.foot.enable = true;
      };
    };
  };
}
