local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- NvChad's default on_init callback disables semantic tokens. One Dark Pro
-- uses them to distinguish functions, methods, types, parameters, and fields.
local function allow_semantic_tokens() end

vim.lsp.config("lua_ls", {
  on_init = allow_semantic_tokens,
})

vim.lsp.config("pyright", {
  capabilities = nvlsp.capabilities,
  on_init = allow_semantic_tokens,
})
vim.lsp.enable "pyright"

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
  },
  capabilities = nvlsp.capabilities,
  on_init = allow_semantic_tokens,
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
})
vim.lsp.enable "clangd"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("cpp_lsp_keymaps", { clear = true }),
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP hover" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP references" }))
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP code action" }))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  end,
})
