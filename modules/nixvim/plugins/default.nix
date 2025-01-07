{
  imports = [
    ./bufferline.nix
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
    colorizer.enable = true;
    fugitive.enable = true;
    git-conflict.enable = true;
    lsp-format.enable = true;
    lualine.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    project-nvim.enable = true;
    rainbow-delimiters.enable = true;
    sleuth.enable = true;
    tmux-navigator.enable = true;
    treesitter.enable = true;
    treesitter-context = {
      enable = true;
      settings.max_lines = 3;
    };
    trouble.enable = true;
    ts-context-commentstring.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
  };
}
