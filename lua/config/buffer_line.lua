require('bufferline').setup {
  options = {
    theme = "onedark",
    mode = "buffers",
    separator_style = "thin", -- "thin", "slant", "padded_slant"
    always_show_bufferline = true, 
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = true,
      }
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, 
  },
  highlights = {
    fill = {
      guifg = '#ff0000',
      guibg = '#00ff00',
    }
  }
}
local map = vim.keymap.set
map('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = "buffer goto next",  noremap = true, silent = true })
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "buffer goto prev",  noremap = true, silent = true })
map('n', '<leader>bn', ':bnext | bd#<CR>', { desc = "close current tab and buffer goto next",  noremap = true, silent = true })
map('n', '<leader>ba', ':bufdo bd <CR>', { desc = "close all buffers",  noremap = true, silent = true })
local opts = { noremap = true, silent = true }
for i = 1, 9 do
  map('n', '<A-' .. i .. '>', ':tabn ' .. i .. '<CR>', opts)
end