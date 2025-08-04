local M = require("nvim-tree")

M.setup({
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = false,
  sync_root_with_cwd = true,
  -- update_focused_file = {
  --   enable = true,
  --   update_root = false,
  -- },
  git = {
    enable = false,
  },
  view = {
    -- width = 30,
    adaptive_size = true,
    preserve_window_proportions = true,
  },
  renderer = {
    -- root_folder_label = false,
    root_folder_label = ":t",
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
})

vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>', { silent = true })