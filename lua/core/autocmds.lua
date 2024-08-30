vim.api.nvim_set_keymap('n', '<leader>sc', ':lua SetTabOptions()<CR>', { noremap = true, silent = true })
function SetTabOptions()
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.expandtab = true
end

vim.cmd([[
autocmd BufLeave,FocusLost * silent! wa
autocmd InsertLeave * silent! write
]])

--vim.g.NERDCommenterCommentString = '// %s'
vim.cmd('autocmd FileType c,cpp setlocal commentstring=//\\ %s')
vim.api.nvim_create_augroup("SetTabOptionsGroup", { clear = true })
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  group = "SetTabOptionsGroup",
  pattern = {"*.c", "*.cpp", "*.h"},
  callback = function()
      SetTabOptions()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("nvim-tree.api").tree.open()
    end
  end,
})
