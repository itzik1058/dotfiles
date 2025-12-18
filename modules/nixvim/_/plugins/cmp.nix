{ lib, ... }:
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
            option.get_bufnrs = lib.nixvim.mkRaw "vim.api.nvim_list_bufs";
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
          "<CR>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if cmp.visible() then
                if luasnip.expandable() then
                  luasnip.expand()
                else
                  cmp.confirm({
                      select = true,
                  })
                end
              else
                fallback()
              end
            end)
          '';
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "j" = "cmp.mapping.scroll_docs(1)";
          "k" = "cmp.mapping.scroll_docs(-1)";
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
