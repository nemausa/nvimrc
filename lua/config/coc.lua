-- init.lua

-- Function to detect the operating system and set paths
local function get_coc_extension_path(extension)
  local is_windows = vim.loop.os_uname().version:match("Windows")
  local path
  if is_windows then
    path = vim.fn.expand("$LOCALAPPDATA")
      .. "\\coc\\extensions\\node_modules\\"
      .. extension
  else
    path = vim.fn.expand("~/.config/coc/extensions/node_modules/") .. extension
  end
  return path
end

-- Function to check and install Coc extensions
local function install_coc_extensions()
  local extensions = {
    "coc-pairs",
    -- "coc-clangd",
    -- "coc-pyright",
    -- "coc-tag",
    -- "coc-snippets",
    -- "coc-qml",
  }

  for _, extension in ipairs(extensions) do
    if vim.fn.empty(vim.fn.glob(get_coc_extension_path(extension))) > 0 then
      vim.cmd("CocInstall " .. extension)
    end
  end
end

-- Automatically install extensions on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = install_coc_extensions,
})

function TryTagOrCocJump()
  local tag_jump_success = pcall(function()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-]>", true, false, true),
      "n",
      true
    )
  end)

  if not tag_jump_success or vim.fn.getcmdtype() ~= "" then
    local coc_jump_result = vim.fn["CocAction"]("jumpDefinition")
    if coc_jump_result == "" then
      print("No definition found with Coc")
    end
  end
end

vim.cmd([[
  let g:gutentags_ctags_exclude = ['.git', 'node_modules', 'build']
]])
vim.api.nvim_create_user_command("Ctags", function()
  local cwd = vim.fn.getcwd()
  local result = vim.fn.system(
    "ctags -R --exclude=output  --exclude=linux-5.10 --languages=C,C++ --fields=+l+K --extra=+q --c-kinds=+p+f+g+u+s+e+m+t+v  "
      .. cwd
  )
end, {})

local map = vim.keymap.set
map("n", "<leader>ct", ":Ctags<CR>")
map(
  "i",
  "<Tab>",
  'pumvisible() ? "<C-n>" : "<Tab>"',
  { expr = true, noremap = true, silent = true }
)
map(
  "i",
  "<S-Tab>",
  'pumvisible() ? "<C-p>" : "<S-Tab>"',
  { expr = true, noremap = true, silent = true }
)
map(
  "i",
  "<CR>",
  'pumvisible() ? coc#_select_confirm() : "<CR>"',
  { expr = true, noremap = true, silent = true }
)
map(
  "i",
  "<Tab>",
  'coc#pum#visible() ? coc#pum#next(1) : "<Tab>"',
  { expr = true, noremap = true, silent = true }
)
map(
  "i",
  "<CR>",
  'coc#pum#visible() ? coc#pum#confirm() : "<CR>"',
  { expr = true, noremap = true, silent = true }
)
map("n", "<leader>ts", ":tselect<CR>t")
map("n", "gt", ":CocAction<CR>", { noremap = true, silent = true })
map("n", "gd", "<C-]>zz", { noremap = true, silent = true })
map("n", "<leader>z", ":A<CR>")
map("n", "<M-o>", ":A<CR>")
map("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })
map(
  "n",
  "<leader>cf",
  ":!clang-format -i %<CR><CR>",
  { noremap = true, silent = true }
)
