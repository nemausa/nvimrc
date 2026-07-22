local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    path_display = function(opts, path)
      local filename = vim.fn.fnamemodify(path, ":t")
      local dir = vim.fn.fnamemodify(path, ":h")
      return filename .. " (" .. dir .. ")"
    end,
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      "^%.git/",
      "/%.git/",
      "^tags$",
      "/tags$",
      "^node_modules/",
      "/node_modules/",
      "^__pycache__/",
      "/__pycache__/",
      "%.lock$",
      "^%.next/",
      "/%.next/",
      "package%-lock%.json$",
      "%.[pP][nN][gG]$",
      "%.[jJ][pP][eE]?[gG]$",
      "^res/",
      "/res/",
    },
    mappings = {
      i = {
        ["<Esc>"] = {
          actions.close,
          type = "action",
          opts = { nowait = true, silent = true },
        },
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
      n = {
        ["<Esc>"] = {
          actions.close,
          type = "action",
          opts = { nowait = true, silent = true },
        },
        ["<C-c>"] = actions.close,
        ["k"] = actions.move_selection_previous,
        ["j"] = actions.move_selection_next,
      },
    },
  },
})
