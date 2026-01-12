require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<F1>", "<cmd>NvCheatsheet<cr>", { silent = true, desc = "Show cheat sheet" })
map("i", "<F1>", "<nop>", { silent = true })
map("v", "<F1>", "<nop>", { silent = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })
map("i", "kk", "<Esc>", { desc = "Exit insert mode" })

map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Preview markdown" })

map("n", "<leader>yA", '<cmd>%y+<cr>', { desc = "Copy buffer to clipboard" })
map("x", "<A-Up>", ":move '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
map("n", "<A-Up>", ":move .-2<CR>==", { silent = true, desc = "Move line up" })
map("x", "<A-Down>", ":move '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("n", "<A-Down>", ":move .+1<CR>==", { silent = true, desc = "Move line down" })

map("n", "<F8>", "<cmd>TagbarToggle<cr>", { silent = true, desc = "Toggle tagbar" })
map("n", "<leader>tt", "<cmd>TagbarToggle<cr>", { silent = true, desc = "Toggle tagbar" })
-- map("n", "<leader>gg", "<cmd>w<CR>:!g++ -g % -o %:r && ./%:r<CR>", { noremap = true, silent = true, desc = "compile cpp and run" })
map("n", "<leader>gg",
  "<cmd>w<cr>:!mkdir -p %:p:h/bin && g++ -g % -o %:p:h/bin/%:t:r && %:p:h/bin/%:t:r<cr>",
  { silent = true, desc = "Compile cpp and run" }
)

map("n", "<leader>h", "0", { desc = "Line start" })
map("n", "<leader>l", "$", { desc = "Line end" })

map("n", "<A-h>", "0", { silent = true, desc = "Line start" })
map("v", "<A-h>", "0", { silent = true, desc = "Line start" })
map("i", "<A-h>", "<C-o>0", { silent = true, desc = "Line start" })
map("n", "<A-l>", "$", { silent = true, desc = "Line end" })
map("v", "<A-l>", "$", { silent = true, desc = "Line end" })
map("i", "<A-l>", "<Esc>A", { silent = true, desc = "Line end" })

map("n", "<C-o>", "<C-o>zz", { silent = true, desc = "Jump back and center" })
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })
map(
  "n",
  "<leader>cf",
  "<cmd>!clang-format -i %<cr><cr>",
  { silent = true, desc = "Format file (clang-format)" }
)
map("n", "<leader>ts", "<cmd>tselect<cr>", { desc = "Tag select" })
map("n", "<leader>tn", "<cmd>AerialNavToggle<cr>", { silent = true, desc = "Toggle aerial nav" })
map("n", "<leader>to", "<cmd>AerialOpenAll<cr>", { silent = true, desc = "Open aerial in all windows" })
map("n", "<leader>tc", "<cmd>AerialCloseAll<cr>", { silent = true, desc = "Close all aerial windows" })
map("n", "gd", "<C-]>", { noremap = true, silent = true,  desc = "Tag jump (ctags)"})
vim.api.nvim_create_user_command("Ctags", function()
  local cwd = vim.fn.getcwd()
  local result = vim.fn.system(
    "ctags -R --exclude=.git  --exclude={.git,third_party,build,out} "
      .. cwd
  )
end, {})

map("n", "<leader>ct", "<cmd>Ctags<cr>", { desc = "Generate ctags" })

local header_switch = require "configs.header_switch"
map("n", "<leader>z", header_switch.switch, { silent = true, desc = "Switch header/source file" })
map("n", "<M-o>", header_switch.switch, { silent = true, desc = "Switch header/source file" })
