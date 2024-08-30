-- lua/config/treesitter.lua
local ts = require('nvim-treesitter.configs')

ts.setup({
  ensure_installed = { "c", "cpp", "python" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
