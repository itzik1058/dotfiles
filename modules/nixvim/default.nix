{
  imports = [
    ./plugins
    ./keymaps.nix
  ];

  performance.byteCompileLua = {
    enable = true;
    nvimRuntime = true;
    plugins = true;
  };
  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };
  globals.mapleader = " ";
  opts = {
    wrap = false;
    hlsearch = false;
    number = true;
    relativenumber = true;
    tabstop = 2;
    softtabstop = 0;
    shiftwidth = 2;
    expandtab = true;
  };
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      disable_underline = true;
      flavour = "mocha";
      integrations = {
        cmp = true;
        gitsigns = true;
        mini = {
          enabled = true;
          indentscope_color = "";
        };
        notify = false;
        nvimtree = true;
        treesitter = true;
      };
      styles = {
        booleans = [
          "bold"
          "italic"
        ];
        conditionals = [
          "bold"
        ];
      };
      term_colors = true;
      transparent_background = true;
    };
  };
}
