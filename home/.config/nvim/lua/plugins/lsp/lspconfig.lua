return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")

    local on_attach = function(_, buffer)
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = buffer, desc = '[F]ormat buffer' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = buffer, desc = '[R]e[n]ame' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = buffer, desc = '[C]ode [A]ction' })

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buffer, desc = '[G]oto [D]efinition' })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
        { buffer = buffer, desc = '[G]oto [R]eferences' })
      vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
        { buffer = buffer, desc = '[G]oto [I]mplementation' })
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = buffer, desc = 'Type [D]efinition' })
      vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
        { buffer = buffer, desc = '[D]ocument [S]ymbols' })
      vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
        { buffer = buffer, desc = '[W]orkspace [S]ymbols' })

      -- See `:help K` for why this keymap
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = buffer, desc = 'Hover Documentation' })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = buffer, desc = 'Signature Documentation' })

      -- Lesser used LSP functionality
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = buffer, desc = '[G]oto [D]eclaration' })
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
        { buffer = buffer, desc = '[W]orkspace [A]dd Folder' })
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
        { buffer = buffer, desc = '[W]orkspace [R]emove Folder' })
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, { buffer = buffer, desc = '[W]orkspace [L]ist Folders' })

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(buffer, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      }
    })
  end
}
