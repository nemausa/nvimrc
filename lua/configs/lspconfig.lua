local util    = require("lspconfig.util")
local nvlsp   = require("nvchad.configs.lspconfig")
nvlsp.defaults()

local lspconfig = require("lspconfig")
local servers   = { "html", "cssls", "pyright", "dartls" }

local custom_on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.definition,  opts)
end

for _, name in ipairs(servers) do
  local opts = {
    on_init     = nvlsp.on_init,
    on_attach   = custom_on_attach,
    capabilities= nvlsp.capabilities,
  }

  lspconfig[name].setup(opts)
end
