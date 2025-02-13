function SetTab2()
  vim.o.shiftwidth   = 2
  vim.o.tabstop      = 2
  vim.o.softtabstop  = 2
  vim.o.expandtab    = true
  print("Tab size set to 2")
end

function SetTab4()
  vim.o.shiftwidth   = 4
  vim.o.tabstop      = 4
  vim.o.softtabstop  = 4
  vim.o.expandtab    = true
  print("Tab size set to 4")
end

-- 定义切换 Tab 宽度的函数
function ToggleTabSize()
  if vim.bo.tabstop == 4 then
    SetTab2()
  else
    SetTab4()
  end
end

-- 映射 leader+st 键来切换 tab 宽度（使用 vim.keymap.set 更加简洁）
vim.keymap.set("n", "<leader>st", ToggleTabSize, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t2", SetTab2, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t4", SetTab4, { noremap = true, silent = true })

vim.cmd([[
  autocmd BufLeave,FocusLost * silent! wa!
  autocmd InsertLeave * silent! write
]])

vim.cmd("autocmd FileType c,cpp setlocal commentstring=//\\ %s")

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
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
})
