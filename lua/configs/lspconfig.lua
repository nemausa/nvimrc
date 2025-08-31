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

-- local cmp = require("cmp")
-- cmp.setup({
--   -- 默认配置：非 c/cpp 文件用 LSP 补全
--   sources = cmp.config.sources({
--     { name = "nvim_lsp" },
--     { name = "buffer" },
--     { name = "path" },
--   }),
--   -- ...
-- })

-- -- 对 c/cpp 文件，禁用 LSP 补全源，只用 coc（或者只留 buffer/path/自定义源）
-- cmp.setup.filetype({ "c", "cpp", "h", "hpp", "cc", "cxx" }, {
--   sources = cmp.config.sources({
--     { name = "buffer" },   -- 只用 buffer
--     { name = "path" },
--     -- 不要加 nvim_lsp，不然会重复！
--   }),
-- })
