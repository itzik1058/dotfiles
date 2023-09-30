return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)

    -- use native fzf
    pcall(require('telescope').load_extension, 'fzf')

    vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>tb', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
    vim.keymap.set('n', '<leader>th', require('telescope.builtin').help_tags, { desc = 'Search help tags' })
    vim.keymap.set('n', '<leader>td', require('telescope.builtin').diagnostics, { desc = 'Search diagnostics' })
  end
}
