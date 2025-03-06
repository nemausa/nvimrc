require "nvchad.options"

-- add yours here!
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
vim.diagnostic.disable()
vim.opt.whichwrap = "b,s,<,>,[,]"
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local bg = vim.api.nvim_get_hl_by_name("Normal", true).background
      local fg = vim.api.nvim_get_hl_by_name("Normal", true).foreground
      if bg and fg then
        vim.cmd(string.format("highlight Pmenu guibg=#%06x guifg=#%06x", bg, fg))
      end
    end,
  })
  