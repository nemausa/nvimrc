require "nvchad.autocmds"

local augroup = vim.api.nvim_create_augroup("UserAutoCmds", { clear = true })

local function autosave_all()
  pcall(vim.cmd, "silent! wa")
end

local function autosave_current()
  pcall(vim.cmd, "silent! update")
end

local function lsp_format()
  pcall(vim.lsp.buf.format)
end

-- Auto-save
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = augroup,
  pattern = "*",
  callback = autosave_all,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  pattern = "*",
  callback = autosave_current,
})

-- Filetype tweaks
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.commentstring = "// %s"
  end,
})

-- Format lua on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*.lua",
  callback = lsp_format,
})