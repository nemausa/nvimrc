-- load defaults i.e lua_lsp
-- require("nvchad.configs.lspconfig").defaults()

-- local lspconfig = require "lspconfig"

-- EXAMPLE
-- local servers = { "html", "cssls", "clangd", "qml" }
-- local nvlsp = require "nvchad.configs.lspconfig"

-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = nvlsp.on_attach,
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--   }
-- end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- 禁用 nvim-cmp 自动补全
local cmp = require('cmp')
cmp.setup({
  enabled = false  -- 禁用自动补全功能
})

-- 禁用 LSP 功能
local lspconfig = require('lspconfig')
lspconfig.util.default_config = nil