local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git/", "tags", "node_modules/", "__pycache__/", "*.lock" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
      flex = {
        flip_columns = 120,
      },
    },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["k"] = actions.move_selection_previous,
        ["j"] = actions.move_selection_next,
      },
    },
  },
  extensions = {
    aerial = {
      col1_width = 4,
      col2_width = 30,
      format_symbol = function(symbol_path, filetype)
        if filetype == "json" or filetype == "yaml" then
          return table.concat(symbol_path, ".")
        else
          return symbol_path[#symbol_path]
        end
      end,
      show_columns = "both",
    },
  },
}



local map = vim.keymap.set
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })

-- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
-- map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
-- map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
-- map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
-- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
-- map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
-- map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })

map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
local telescope_builtin = require('telescope.builtin')
map('n', '<leader>fc', '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Search for: "), search_dirs = { vim.fn.expand("%") } })<CR>')