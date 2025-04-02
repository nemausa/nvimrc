require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<F1>", ":NvCheatsheet<CR>", { noremap = true, silent = true , desc = "show sheet"})
map("i", "<F1>", "<nop>", { noremap = true, silent = true })
map("v", "<F1>", "<nop>", { noremap = true, silent = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<Esc>")
map("i", "kk", "<Esc>")

map("n", "<leader>mp", ":MarkdownPreview<CR>", {})

map("n", "<leader>ca", 'gg"+yG')
map("x", "<A-Up>", ":move '<-2<CR>gv=gv")
map("n", "<A-Up>", ":move .-2<CR>==")
map("x", "<A-Down>", ":move '>+1<CR>gv=gv")
map("n", "<A-Down>", ":move .+1<CR>==")

map("n", "<F8>", ":TagbarToggle<CR>", { noremap = true, silent = true })
map("n", "<leader>tt", ":TagbarToggle<CR>", { noremap = true, silent = true })
-- map("n", "<leader>gg", "<cmd>w<CR>:!g++ -g % -o %:r && ./%:r<CR>", { noremap = true, silent = true, desc = "compile cpp and run" })
map("n", "<leader>gg",
    "<cmd>w<CR>:!mkdir -p %:p:h/bin && g++ -g % -o %:p:h/bin/%:t:r && %:p:h/bin/%:t:r<CR>",
    { noremap = true, silent = true, desc = "compile cpp and run" })

map("n", "<leader>h", "0")
map("n", "<leader>l", "$")

map("n", "<C-a>", "0", { noremap = true, silent = true, desc = "Move to beginning of line" })
map("n", "<C-e>", "$", { noremap = true, silent = true, desc = "Move to end of line" })
map("v", "<C-a>", "0", { noremap = true, silent = true, desc = "Move to beginning of line in visual mode" })
map("v", "<C-e>", "$", { noremap = true, silent = true, desc = "Move to end of line in visual mode" })