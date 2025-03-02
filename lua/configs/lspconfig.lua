-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

lspconfig.pyright.setup({})  -- 让 Python 继续用 LSP
lspconfig.tsserver.setup({}) -- 让 TypeScript 继续用 LSP
-- 但不启动 clangd，让 C/C++ 只用 coc.nvim

-- EXAMPLE
-- local servers = { "html", "cssls" }
-- local nvlsp = require "nvchad.configs.lspconfig"
--
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
-- local cmp = require("cmp")
-- cmp.setup({
--     mapping = {
--         ["<CR>"] = cmp.mapping.abort(), -- 取消 cmp 默认的 Enter 行为
--     }
-- })
--