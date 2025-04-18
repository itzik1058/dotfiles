{
  imports = [
    ./bufferline.nix
    ./codecompanion.nix
    ./cmp.nix
    ./gitsigns.nix
    ./lsp
    ./mini.nix
    ./neotree.nix
    ./snacks
    ./telescope.nix
  ];

  plugins = {
    colorizer.enable = true;
    copilot-vim.enable = true;
    fugitive.enable = true;
    git-conflict.enable = true;
    lualine.enable = true;
    rainbow-delimiters.enable = true;
    render-markdown = {
      enable = true;
      settings.file_types = [
        "markdown"
        "codecompanion"
      ];
    };
    sleuth.enable = true;
    tmux-navigator.enable = true;
    treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };
    ts-context-commentstring.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
  };
}
