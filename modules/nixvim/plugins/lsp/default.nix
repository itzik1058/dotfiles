{
  plugins = {
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
        formatters_by_ft =
          let
            prettier = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              timeout_ms = 2000;
              stop_after_first = true;
            };
          in
          {
            css = prettier;
            html = prettier;
            javascript = prettier;
            javascriptreact = prettier;
            typescript = prettier;
            typescriptreact = prettier;
          };
      };
    };
    fidget = {
      enable = true;
      settings.notification.window.winblend = 0;
    };
    lsp-format.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cf" = {
            action = "format";
            desc = "Format";
          };
          "<leader>ca" = {
            action = "code_action";
            desc = "Code Action";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
      postConfig = builtins.readFile ./postConfig.lua;
      servers = {
        clangd.enable = true;
        eslint.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        nixd = {
          enable = true;
          extraOptions = {
            offset_encoding = "utf-8";
          };
        };
        pyright.enable = true;
        ruff.enable = true;
        ts_ls.enable = true;
        yamlls.enable = true;
      };
    };
    schemastore = {
      enable = true;
      yaml.enable = true;
      json.enable = true;
    };
  };
}
