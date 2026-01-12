local function set_tabsize(size)
  vim.o.shiftwidth = size
  vim.o.tabstop = size
  vim.o.softtabstop = size
  vim.o.expandtab = true
  vim.notify(string.format("Tab size set to %d", size))
end

local function toggle_tabsize()
  if vim.bo.tabstop == 4 then
    set_tabsize(2)
  else
    set_tabsize(4)
  end
end

vim.keymap.set("n", "<leader>st", toggle_tabsize, { silent = true, desc = "Toggle tab size 2/4" })
vim.keymap.set("n", "<leader>t2", function() set_tabsize(2) end, { silent = true, desc = "Tab size 2" })
vim.keymap.set("n", "<leader>t4", function() set_tabsize(4) end, { silent = true, desc = "Tab size 4" })

local augroup = vim.api.nvim_create_augroup("UserAutoCmds", { clear = true })

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = augroup,
  pattern = "*",
  command = "silent! wa!",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  pattern = "*",
  command = "silent! write",
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.commentstring = "// %s"
  end,
})

vim.g.tagbar_type_c = {
  kinds = {
    "f:functions",
    "e:enums",
    "s:structs",
  },
  sro = "::",
  kind2scope = {
    e = "enum",
    s = "struct",
  },
  scope2kind = {
    enum = "e",
    struct = "s",
  },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- vim.cmd([[
--   autocmd BufWritePre *.cpp,*.h,*.hpp,*.c,*.cc Neoformat
-- ]])

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "c", "cpp", "h", "hpp", "cc", "cxx" },
--   callback = function()
--     require("cmp").setup.buffer { enabled = false }
--   end,
-- })