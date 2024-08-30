if vim.fn.has('nvim-0.8') == 1 then
  vim.g.do_filetype_lua=1
  vim.g.did_load_filetypes=0
end

--vim.opt.fileencoding = 'utf-8'
vim.g.mapleader = ','
vim.opt.expandtab=true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.guifont = 'Consolas:h14'
vim.opt.colorcolumn = '80'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.ale_enabled = 0

vim.cmd [[
  let g:gutentags_ctags_exclude = ['.git', 'node_modules', 'build']
]]