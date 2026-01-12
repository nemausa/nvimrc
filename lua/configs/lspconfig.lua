local lspconfig = vim.lsp.config
local cmp = require("cmp")
local nvlsp = require("nvchad.configs.lspconfig")

-- 启用调试日志
vim.lsp.log.set_level("debug")

-- 默认 LSP 配置
nvlsp.defaults()

-- 自定义 on_attach
local custom_on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- LSP 服务器列表
local servers = { "html", "cssls", "pyright", "dartls", "ts_ls", "clangd" }

for _, name in ipairs(servers) do
  local opts = {
    on_init = nvlsp.on_init,
    on_attach = custom_on_attach,
    capabilities = nvlsp.capabilities,
  }

  if name == "clangd" then
    opts.capabilities.offsetEncoding = { "utf-16" }
    opts.cmd = {
      "clangd",
      "--background-index",
      "--completion-style=detailed",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--suggest-missing-includes",
      "--limit-results=50",
    }
  end

  lspconfig(name, opts)
end

vim.lsp.enable(servers)

-- CMP 补全配置
cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 250 },
  }),
  mapping = cmp.mapping.preset.insert(),
})

cmp.setup.filetype({ "c", "cpp", "h", "hpp", "cc", "cxx" }, {
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 250 },
  }),
})
