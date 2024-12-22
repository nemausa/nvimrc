require("spectre").setup({
  mapping = {
    ["toggle_line"] = {
      map = "dd",
      cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
      desc = "Toggle selection on line",
    },
  },
  find_engine = {
    ["rg"] = {
      cmd = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
    },
  },
  replace_engine = {
    ["sed"] = {
      cmd = "sed",
      args = nil,
    },
  },
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>S",
  '<cmd>lua require("spectre").open()<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sw",
  '<cmd>lua require("spectre").open_file_search()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>R", function()
  require("spectre").open()
end, { desc = "Open Spectre" })

vim.keymap.set("n", "<leader>r", function()
  require("spectre.actions").run_replace()
end, { desc = "Run Replace" })
