-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set({ 'n', 'x' }, 'j', "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true, desc = 'Move down' })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true, desc = 'Move up' })
vim.keymap.set({ 'n', 'v' }, '<Up>', "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true, desc = 'Move up' })
vim.keymap.set({ 'n', 'v' }, '<Down>', "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true, desc = 'Move down' })

-- go to beginning and end of line
vim.keymap.set('i', '<C-b>', '<ESC>^i', { desc = 'Beginning of line' })
vim.keymap.set('i', '<C-e>', '<End>', { desc = 'End of line' })

-- navigate in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move up' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh <CR>', { desc = 'Clear highlights' })

-- window navigation
vim.keymap.set('n', 'C-h', '<C-w>h', { desc = 'Window left' })
vim.keymap.set('n', 'C-j', '<C-w>j', { desc = 'Window down' })
vim.keymap.set('n', 'C-k', '<C-w>k', { desc = 'Window up' })
vim.keymap.set('n', 'C-l', '<C-w>l', { desc = 'Window right' })

-- file
vim.keymap.set('n', '<leader>w', '<cmd> w <CR>', { desc = 'Write buffer' })
-- vim.keymap.set('n', '<leader>x', '<cmd> x <CR>', { desc = 'Write buffer and close' })

-- indent
vim.keymap.set('v', '<', '<gv', { desc = 'Outdent line' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent line' })

-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
