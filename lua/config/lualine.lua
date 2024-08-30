local lualine = require('lualine')
lualine.setup({
  options = {
    theme = 'onedark',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { {'filename', path = 1}},
    lualine_x = {
      'encoding',
      {
        'fileformat',
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        }
      },
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

vim.api.nvim_set_var('lualine_mode', { 
  width = 10  -- Adjust the width value as needed
})
