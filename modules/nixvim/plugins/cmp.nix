{ helpers, ... }:
{
  plugins = {
    cmp = {
      enable = true;
      settings = {
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet.expand = "luasnip";
        formatting.fields = [
          "kind"
          "abbr"
          "menu"
        ];
        sources = [
          {
            name = "buffer";
            option.get_bufnrs = helpers.mkRaw "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          { name = "emoji"; }
          { name = "git"; }
          {
            name = "luasnip";
            keywordLength = 3;
          }
          { name = "nvim_lsp"; }
          { name = "nvim-lsp-signature-help"; }
          {
            name = "path";
            keywordLength = 3;
          }
        ];
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
    cmp-buffer.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    lspkind.enable = true;
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
    };
  };
}
