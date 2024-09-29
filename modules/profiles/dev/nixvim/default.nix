{
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
  };
  colorschemes.catppuccin = {
    enable = true;
    settings.flavour = "mocha";
  };
  keymaps = import ./keymaps.nix;
  plugins = import ./plugins;
}
