local spec = {}

table.insert(spec, { "LazyVim/LazyVim", import = "lazyvim.plugins" })

if _G["telescopeNativeFzf"] then
	table.insert(spec, { "nvim-telescope/telescope-fzf-native.nvim", enabled = true })
end

if _G["disableMason"] then
	table.insert(spec, { "williamboman/mason-lspconfig.nvim", enabled = false })
	table.insert(spec, { "williamboman/mason.nvim", enabled = false })
end

-- table.insert(spec, { import = "plugins" })

if _G["clearTreesitterDependencies"] then
	table.insert(spec, { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } })
end

require("lazy").setup({
	defaults = { lazy = true },
	spec = spec,
})
