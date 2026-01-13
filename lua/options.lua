require "nvchad.options"

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.colorcolumn = "80"

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Diagnostics
vim.diagnostic.enable(false)

-- Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true