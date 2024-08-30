require('bufferline').setup {
  options = {
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