local map = vim.keymap.set
map('i', 'jj', '<Esc>')
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Move
map('x', '<A-Up>', ":move '<-2<CR>gv=gv")
map('n', '<A-Up>', ":move .-2<CR>==")
map('x', '<A-Down>', ":move '>+1<CR>gv=gv")
map('n', '<A-Down>', ":move .+1<CR>==")

-- Debug
map('n', '<F2>', '<cmd>lua require("dapui").toggle()<CR>')
map('n', '<F5>', '<cmd>lua require("dap").continue()<CR>')
map('n', '<F10>', '<cmd>lua require("dap").step_over()<CR>')
map('n', '<F11>', '<cmd>lua require("dap").step_into()<CR>')
map('n', '<F12>', '<cmd>lua require("dap").step_out()<CR>')
map('n', '<F9>', '<cmd>lua require("dap").toggle_breakpoint()<CR>')
map('n', '<leader>B', '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map('n', '<leader>dr', '<cmd>lua require("dap").repl.open()<CR>')
map('n', '<leader>dl', '<cmd>lua require("dap").run_last()<CR>')

-- Lsp
map('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true, noremap = true, silent = true })
map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, noremap = true, silent = true })
map('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "<CR>"', { expr = true, noremap = true, silent = true })
map('i', '<Tab>', 'coc#pum#visible() ? coc#pum#next(1) : "<Tab>"', { expr = true, noremap = true, silent = true })
map('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', { expr = true, noremap = true, silent = true })
map('n', '<leader>ts', ':tselect<CR>t')
map('n', 'gt', ':CocAction<CR>', { noremap = true, silent = true })
map('n', 'gd', '<C-]>', {noremap = true, silent = true })
function TryTagOrCocJump()
  local tag_jump_success = pcall(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-]>', true, false, true), 'n', true)
  end)

  if not tag_jump_success or vim.fn.getcmdtype() ~= '' then
    local coc_jump_result = vim.fn['CocAction']('jumpDefinition')
    if coc_jump_result == '' then
      print('No definition found with Coc')
    end
  end
end

vim.api.nvim_create_user_command('Ctags', function()
  local cwd = vim.fn.getcwd()
  local result = vim.fn.system('ctags -R ' .. cwd)
  print(result)
end, {})
map('n', '<leader>ct', ':Ctags<CR>')

--Telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
local telescope_builtin = require('telescope.builtin')
map('n', '<leader>fc', '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Search for: "), search_dirs = { vim.fn.expand("%") } })<CR>')

-- new terminal
map("n", "<leader>v", ':vsplit | term<CR>', { desc = "terminal new horizontal term" })
map("n", "<leader>h", ':split | term<CR>', { desc = "terminal new horizontal term" })
map('t', '<leader>tq', [[<C-\><C-n>:q<CR>]])

-- switch header or source file
map('x', '<A-o>', ":A<CR>")
map('n', '<A-o>', ":A<CR>")
map('n', '<leader>z', ':A<CR>')

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- switch tab
map('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = "buffer goto next",  noremap = true, silent = true })
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "buffer goto prev",  noremap = true, silent = true })
map('n', '<leader>bn', ':bnext | bd#<CR>', { desc = "close current tab and buffer goto next",  noremap = true, silent = true })
map('n', '<leader>ba', ':bufdo bd <CR>', { desc = "close all buffers",  noremap = true, silent = true })
local opts = { noremap = true, silent = true }
for i = 1, 9 do
  map('n', '<A-' .. i .. '>', ':tabn ' .. i .. '<CR>', opts)
end

-- Diffview
vim.api.nvim_create_user_command('CustomDiffviewOpen', function()
  local nvim_tree_view = require'nvim-tree.view'
  if nvim_tree_view.is_visible() then
      vim.cmd('NvimTreeClose')
  end

  vim.cmd('DiffviewOpen')
end, {})

map('n', '<leader>do', ':CustomDiffviewOpen<CR>')
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>')
