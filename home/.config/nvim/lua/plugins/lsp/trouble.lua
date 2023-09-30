return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup()
    vim.keymap.set("n", "<leader>dt", function() require("trouble").open() end)
    vim.keymap.set("n", "<leader>dw", function() require("trouble").open("workspace_diagnostics") end)
    vim.keymap.set("n", "<leader>dd", function() require("trouble").open("document_diagnostics") end)
    vim.keymap.set("n", "<leader>dq", function() require("trouble").open("quickfix") end)
    vim.keymap.set("n", "<leader>dl", function() require("trouble").open("loclist") end)
    vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)
  end
}
