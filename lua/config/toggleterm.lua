require("toggleterm").setup({
  size = 40,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = false,
  start_in_insert = true,
  shading_factor = 2,
  direction = "float",
  close_on_exit = true,
  float_opts = {
    border = "curved"
  }
})

vim.keymap.set("n", "<leader>v", ':vsplit | term <CR>i', { desc = "terminal new horizontal term" })
vim.keymap.set("n", "<leader>h", ':split | term<CR>i', { desc = "terminal new horizontal term" })
vim.keymap.set('t', '<leader>q', [[<C-\><C-n>:q<CR>]])
vim.keymap.set('n', '<leader>to', ':belowright new | resize 20 | terminal<CR>i', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', ':!cd bin && ./main <CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', ':!cd build && cmake .. && make -j<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', '<C-w><C-w>', { noremap = true, silent = true })