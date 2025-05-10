local lspconfig = require("lspconfig")
lspconfig.ruby_lsp.setup({
  init_options = {
    formatter = "standard",
    linters = { "standard" },
  },
})
