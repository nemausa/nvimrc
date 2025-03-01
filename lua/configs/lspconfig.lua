-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "clangd"}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.clangd.setup{
  cmd = { "clangd", "--function-arg-placeholders" },
  -- 其他配置项…
}

lspconfig.qmlls.setup = {
    cmd = { "/opt/Qt/Tools/QtDesignStudio/qt6_design_studio_reduced_version/plugins/qmlls" }, 
    filetypes = { "qml" },
    root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- 禁用 nvim-cmp 自动补全
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  -- 其他配置…
})



-- -- 禁用 LSP 功能
-- local lspconfig = require('lspconfig')
-- lspconfig.util.default_config = nil