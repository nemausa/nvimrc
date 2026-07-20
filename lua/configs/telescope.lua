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
      ".git/",
      "tags",
      "node_modules/",
      "__pycache__/",
      "*.lock",
      "%.png$" ,
      ".next",
      ".lock",
      "package-lock.json",
      ".jpg",
      "jpeg",
      "png",
      "PNG",
      "JPEG",
      "JPG",
      "res",
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
