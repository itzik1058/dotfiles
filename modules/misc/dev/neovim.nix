{
  flake = {
    modules.homeManager.neovim =
      { lib, pkgs, ... }:
      {
        config = {
          programs.neovim = {
            enable = true;
            extraPackages = with pkgs; [
              lua-language-server
              ripgrep
              stylua
              tree-sitter
            ];
            plugins = with pkgs.vimPlugins; [ lazy-nvim ];
            extraLuaConfig = lib.mkMerge [
              (lib.mkBefore ''
                telescopeNativeFzf = true
                disableMason = true
                clearTreesitterDependencies = false
              '')
              (builtins.readFile ../../../nvim/init.lua)
            ];
          };

          xdg.configFile."nvim/lua".source = ../../../nvim/lua;
        };
      };
  };
}
