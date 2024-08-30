vim.api.nvim_set_keymap('n', '<leader>t2', ':lua SetTab2()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t4', ':lua SetTab4()<CR>', { noremap = true, silent = true })

function SetTab2()
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.expandtab = true
end

function SetTab4()
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4
  vim.opt.expandtab = true
end

vim.cmd([[
  autocmd BufLeave,FocusLost * silent! wa!
  autocmd InsertLeave * silent! write
]])

vim.cmd('autocmd FileType c,cpp setlocal commentstring=//\\ %s')
vim.api.nvim_create_augroup("SetTabOptionsGroup", { clear = true })
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile", "BufReadPre"}, {
  group = "SetTabOptionsGroup",
  pattern = {"*.c", "*.cpp", "*.h"},
  callback = function()
      SetTab2()
  end,
})

vim.g.tagbar_type_c = {
    kinds = {
        'f:functions',
        'e:enums',
        's:structs'
    },
    sro = '::',
    kind2scope = {
        e = 'enum',
        s = 'struct'
    },
    scope2kind = {
        enum = 'e',
        struct = 's'
    }
}


