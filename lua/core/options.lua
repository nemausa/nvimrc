if vim.fn.has('nvim-0.8') == 1 then
  vim.g.do_filetype_lua=1
  vim.g.did_load_filetypes=0
end

vim.g.mapleader = ' '
vim.opt.expandtab=true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guifont = 'Consolas:h14'
vim.opt.colorcolumn = '80'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.ale_enabled = 0
vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.g.python3_host_prog = find_python
vim.o.fixendofline = false
vim.o.clipboard = 'unnamedplus'
vim.o.termguicolors = true
vim.g.tagbar_width = 30
vim.g.tagbar_position = 'left'
vim.g.tagbar_autofocus = 1