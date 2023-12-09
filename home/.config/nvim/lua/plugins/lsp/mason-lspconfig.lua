return {
  "williamboman/mason-lspconfig",
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    ensure_installed = {
      "lua_ls",
      "tsserver",
      "pyright"
    },
  }
}
