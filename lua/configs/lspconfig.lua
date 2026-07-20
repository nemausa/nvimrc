local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

for _, server in ipairs { "pyright", "ts_ls" } do
  vim.lsp.config(server, {
    capabilities = nvlsp.capabilities,
    on_init = nvlsp.on_init,
  })
  vim.lsp.enable(server)
end

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
  },
  capabilities = nvlsp.capabilities,
  on_init = nvlsp.on_init,
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
