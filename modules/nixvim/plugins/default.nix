{
  imports = [
    ./cmp.nix
    ./gitsigns.nix
    ./lsp
    ./neotree.nix
    ./oil.nix
    ./telescope.nix
    ./toggleterm.nix
    ./undotree.nix
  ];

  plugins = {
    fugitive.enable = true;
    git-conflict.enable = true;
    lsp-format.enable = true;
    lualine.enable = true;
    nvim-autopairs.enable = true;
    nvim-colorizer.enable = true;
    nvim-surround.enable = true;
    project-nvim.enable = true;
    sleuth.enable = true;
    treesitter.enable = true;
    trouble.enable = true;
    ts-context-commentstring.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
  };
}
