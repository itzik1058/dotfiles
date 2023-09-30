return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "NvimTree",
          text = "NvimTree",
          text_align = "left",
          separator = true
        }
      },
    }
  },
  config = function(_, opts)
    require('bufferline').setup(opts)

    vim.keymap.set('n', '<tab>', '<cmd> BufferLineCycleNext <CR>', { desc = 'Next buffer' })
    vim.keymap.set('n', '<S-tab>', '<cmd> BufferLineCyclePrev <CR>', { desc = 'Previous buffer' })
    vim.keymap.set('n', '<leader>x', function()
      vim.cmd("write")
      require('bufferline').unpin_and_close()
      vim.cmd("BufferLineCycleNext")
    end, { desc = 'Close buffer' })
  end
}
