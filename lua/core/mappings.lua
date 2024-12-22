local map = vim.keymap.set
vim.api.nvim_del_keymap("n", "<Space>ihn")
vim.api.nvim_del_keymap("n", "<Space>is")
vim.api.nvim_del_keymap("n", "<Space>ih")
vim.api.nvim_del_keymap("i", "<Space>ihn")
vim.api.nvim_del_keymap("i", "<Space>is")
vim.api.nvim_del_keymap("i", "<Space>ih")
map("n", "<F1>", "<nop>", { noremap = true, silent = true })
map("i", "<F1>", "<nop>", { noremap = true, silent = true })
map("v", "<F1>", "<nop>", { noremap = true, silent = true })

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
