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

if os.getenv "SSH_TTY" then
  vim.g.clipboard = {
    name = "OSC 52",
    -- Try to use OSC 52 escape sequences to copy to system clipboard
    -- It should not break anything if it’s not supported
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    -- Disable paste since it does not work in some terminals,
    -- i.e., xterm.js (many app based on Web tech use this)
    paste = {
      ["+"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
      ["*"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
    },
  }
end

require("configs.header_switch")
-- vim.keymap.set("n", "<leader>z", require("configs.header_switch").switch, { silent = true, desc = "Switching header/source files" })
vim.keymap.set("n", "<leader>z",
  '<cmd>lua require("configs.header_switch").switch()<CR><cmd>normal! zz<CR>',
  { silent = true, desc = "Switch header/source files and center view" }
)
vim.keymap.set("n", "<M-o>", require("configs.header_switch").switch, { silent = true, desc = "Switching header/source files" })