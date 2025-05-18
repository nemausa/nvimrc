-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "pyright", "dartls"}
local nvlsp = require "nvchad.configs.lspconfig"

local custom_on_attach = function(client, bufnr)
  -- 保留 NVChad 默认的 on_attach 功能（比如自动高亮、格式化等）
  nvlsp.on_attach(client, bufnr)

  local opts = { noremap = true, silent = true, buffer = bufnr }
  -- 用 gd 跳到声明
  vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
  -- 用 gD 跳到定义
  vim.keymap.set("n", "gD", vim.lsp.buf.definition,  opts)
  -- 其他你想保留或新增的映射也写在这里
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach =custom_on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end