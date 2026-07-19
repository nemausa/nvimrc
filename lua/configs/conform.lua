local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
}

return options
