require "nvchad.mappings"

local map = vim.keymap.set
local header_switch = require "configs.header_switch"

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<F1>", "<cmd>NvCheatsheet<cr>", { silent = true, desc = "Show cheat sheet" })
map("i", "<F1>", "<nop>", { silent = true })
map("v", "<F1>", "<nop>", { silent = true })

-- Insert mode
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })
map("i", "kk", "<Esc>", { desc = "Exit insert mode" })

-- Navigation
map("n", "<leader>h", "0", { desc = "Line start" })
map("n", "<leader>l", "$", { desc = "Line end" })
map("n", "<A-h>", "0", { silent = true, desc = "Line start" })
map("v", "<A-h>", "0", { silent = true, desc = "Line start" })
map("n", "<A-l>", "$", { silent = true, desc = "Line end" })
map("v", "<A-l>", "$", { silent = true, desc = "Line end" })
map("i", "<C-a>", "<C-o>0", { silent = true, desc = "Line start" })
map("i", "<C-e>", "<C-o>$", { silent = true, desc = "Line end" })
map("n", "<C-o>", "<C-o>zz", { silent = true, desc = "Jump back and center" })

-- Editing helpers
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })
map("x", "<A-Up>", ":move '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
map("n", "<A-Up>", ":move .-2<CR>==", { silent = true, desc = "Move line up" })
map("x", "<A-Down>", ":move '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("n", "<A-Down>", ":move .+1<CR>==", { silent = true, desc = "Move line down" })
map("n", "<leader>yA", "<cmd>%y+<cr>", { desc = "Copy buffer to clipboard" })

-- File/format
map("n", "<leader>cf", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format file (conform)" })
map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Preview markdown" })

-- Tags / symbols
map("n", "<F8>", "<cmd>TagbarToggle<cr>", { silent = true, desc = "Toggle tagbar" })
map("n", "<leader>tt", "<cmd>TagbarToggle<cr>", { silent = true, desc = "Toggle tagbar" })
map("n", "<leader>ts", "<cmd>tselect<cr>", { desc = "Tag select" })
local function jump_tag_or_lsp()
  local word = vim.fn.expand "<cword>"
  local ok = pcall(vim.cmd, "tjump " .. word)
  if ok then
    return
  end
  if vim.fn.exists("*CocAction") == 1 then
    vim.fn.CocAction("jumpDefinition")
    return
  end
  vim.lsp.buf.definition()
end

map("n", "gd", jump_tag_or_lsp, { silent = true, desc = "Jump to definition (tag/LSP)" })


vim.api.nvim_create_user_command("Ctags", function()
  local cwd = vim.fn.getcwd()
  vim.fn.system("ctags -R --exclude=.git --exclude={.git,third_party,build,out} " .. cwd)
end, {})
map("n", "<leader>ct", "<cmd>Ctags<cr>", { desc = "Generate ctags" })

-- C/C++ helpers
map("n", "<leader>gg", function()
  if not vim.tbl_contains({ "c", "cpp", "cc", "cxx" }, vim.bo.filetype) then
    vim.notify("Not a C/C++ file", vim.log.levels.WARN)
    return
  end
  vim.cmd "write"
  vim.cmd "!mkdir -p %:p:h/bin && g++ -g % -o %:p:h/bin/%:t:r && %:p:h/bin/%:t:r"
end, { silent = true, desc = "Compile cpp and run" })
map("n", "<leader>z", header_switch.switch, { silent = true, desc = "Switch header/source file" })
map("n", "<M-o>", header_switch.switch, { silent = true, desc = "Switch header/source file" })

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

map("n", "<leader>st", toggle_tabsize, { silent = true, desc = "Toggle tab size 2/4" })
map("n", "<leader>t2", function() set_tabsize(2) end, { silent = true, desc = "Tab size 2" })
map("n", "<leader>t4", function() set_tabsize(4) end, { silent = true, desc = "Tab size 4" })