-- init.lua

-- Function to detect the operating system and set paths
local function get_coc_extension_path(extension)
  local is_windows = vim.loop.os_uname().version:match("Windows")
  local path
  if is_windows then
    path = vim.fn.expand("$LOCALAPPDATA") .. '\\coc\\extensions\\node_modules\\' .. extension
  else
    path = vim.fn.expand("~/.config/coc/extensions/node_modules/") .. extension
  end
  return path
end

-- Function to check and install Coc extensions
local function install_coc_extensions()
  local extensions = { "coc-pairs", "coc-clangd", "coc-pyright"}

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
