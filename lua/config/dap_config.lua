local dap, dapui = require("dap"), require("dapui")
local nvim_tree = require("nvim-tree")

local original_nvim_tree_width = nil

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()

  local nvim_tree_win = vim.fn.bufwinid(vim.fn.bufnr("NvimTree"))
  if nvim_tree_win ~= -1 then
    original_nvim_tree_width = vim.api.nvim_win_get_width(nvim_tree_win)
  end
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()

  local nvim_tree_win = vim.fn.bufwinid(vim.fn.bufnr("NvimTree"))
  if nvim_tree_win ~= -1 and original_nvim_tree_width then
    vim.api.nvim_win_set_width(nvim_tree_win, original_nvim_tree_width)
  end
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()

  local nvim_tree_win = vim.fn.bufwinid(vim.fn.bufnr("NvimTree"))
  if nvim_tree_win ~= -1 and original_nvim_tree_width then
    vim.api.nvim_win_set_width(nvim_tree_win, original_nvim_tree_width)
  end
end

vim.keymap.set("n", "<F2>", '<cmd>lua require("dapui").toggle()<CR>')
vim.keymap.set("n", "<F3>", '<cmd>lua require("dap").step_into()<CR>')
vim.keymap.set("n", "<F4>", '<cmd>lua require("dap").step_out()<CR>')
vim.keymap.set("n", "<F5>", '<cmd>lua require("dap").continue()<CR>')
vim.keymap.set("n", "<F9>", '<cmd>lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set("n", "<F10>", '<cmd>lua require("dap").step_over()<CR>')
vim.keymap.set(
  "n",
  "<leader>dB",
  '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
)
vim.keymap.set("n", "<leader>dr", '<cmd>lua require("dap").repl.open()<CR>')
vim.keymap.set("n", "<leader>dl", '<cmd>lua require("dap").run_last()<CR>')
vim.keymap.set('n', '<F7>', function()
  local var = vim.fn.input("Variable to watch: ")
  require('dapui').elements.watches.add(var)
end, { desc = "Add Watch for Variable" })
vim.keymap.set('n', '<leader>wa', function()
  local var = vim.fn.input("Variable to watch: ")
  require('dapui').elements.watches.add(var)
end, { desc = "Add Watch for Variable" })

vim.keymap.set('n', '<leader>wr', function()
  local var = vim.fn.input("Variable to remove: ")
  require('dapui').elements.watches.remove(var)
end, { desc = "Remove Watch for Variable" })

vim.keymap.set('n', '<leader>we', function()
  require('dap').eval()
end, { desc = "Evaluate Variable" })

