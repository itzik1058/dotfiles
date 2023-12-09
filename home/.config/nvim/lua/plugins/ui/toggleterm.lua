return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {},
  config = function(_, opts)
    local toggleterm = require("toggleterm")
    toggleterm.setup(opts)

    vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    vim.keymap.set("t", "<Esc>", "<cmd>ToggleTerm<CR>")
  end
}
