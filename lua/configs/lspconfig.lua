local nvlsp = require("nvchad.configs.lspconfig")

-- Use NvChad LSP defaults, then enable desired servers.
nvlsp.defaults()

local servers = { "clangd", "pyright" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers