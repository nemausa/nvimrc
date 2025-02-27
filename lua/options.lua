require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.ale_enabled = 0
vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.o.fixendofline = false
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
-- vim.g.python3_host_prog = find_python
-- vim.g.tagbar_width = 30
-- vim.g.tagbar_position = "left"
-- vim.g.tagbar_autofocus = 1
vim.opt.makeprg = "cmake --build build"
vim.opt.clipboard = "unnamedplus"