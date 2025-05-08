-- File: ~/.config/nvim/lua/configs/header_switch.lua

local M = {}

-- Check if a file is readable
local function exists(path)
  return vim.fn.filereadable(path) == 1
end

-- Determine the project root: prefer Git root, otherwise use current working directory
local function get_root()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_root and git_root ~= '' then
    return git_root
  end
  return vim.fn.getcwd()
end

-- Main switch function: recursively glob through the project
function M.switch()
  local current_path = vim.api.nvim_buf_get_name(0)
  if current_path == "" then
    return
  end

  -- Extract file extension and base name
  local ext  = vim.fn.fnamemodify(current_path, ":e")
  local name = vim.fn.fnamemodify(current_path, ":t:r")
  local root = get_root()

  -- Determine target extensions based on current file type
  local targets
  if ext:match('^c$') or ext:match('^cpp$') or ext:match('^cc$') or ext:match('^cxx$') then
    -- Source file -> Header file
    targets = { '.h', '.hpp', '.hh' }
  elseif ext:match('^h$') or ext:match('^hpp$') or ext:match('^hh$') then
    -- Header file -> Source file
    targets = { '.c', '.cpp', '.cc', '.cxx' }
  else
    vim.notify("Unsupported file type: " .. ext, vim.log.levels.WARN)
    return
  end

  -- Search for matching files under the project root
  for _, e in ipairs(targets) do
    local pattern = '**/' .. name .. e
    local matches = vim.fn.globpath(root, pattern, false, true)
    -- If globpath returns a single string, convert to list
    if type(matches) == 'string' then
      matches = { matches }
    end
    if matches and #matches > 0 then
      -- Open the first matching file
      vim.cmd('edit ' .. vim.fn.fnameescape(matches[1]))
      return
    end
  end

  vim.notify("No matching header/source file found", vim.log.levels.WARN)
end

return M