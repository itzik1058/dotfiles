{
  imports = [
    ./plugins
    ./keymaps.nix
  ];

  enable = true;
  defaultEditor = true;
  vimdiffAlias = true;
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
    settings.flavour = "mocha";
  };
}
