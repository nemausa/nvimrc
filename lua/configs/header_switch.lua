local M = {}

-- Find the project root (prefer git).
local function get_root()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" then
    return git_root
  end
  return vim.fn.getcwd()
end

-- Get the full basename (handles multi-suffix files like foo.bar.cpp).
local function get_basename(path)
  local fname = vim.fn.fnamemodify(path, ":t")
  return fname:gsub("%.[^%.]+$", "")
end

function M.switch()
  local current_path = vim.api.nvim_buf_get_name(0)
  if current_path == "" then
    return
  end

  local ext = vim.fn.fnamemodify(current_path, ":e")
  local name = get_basename(current_path)
  local root = get_root()

  local targets
  if vim.tbl_contains({ "c", "cpp", "cc", "cxx" }, ext) then
    targets = { "h", "hpp", "hh" }
  elseif vim.tbl_contains({ "h", "hpp", "hh" }, ext) then
    targets = { "c", "cpp", "cc", "cxx" }
  else
    vim.notify("Unsupported file type: " .. ext, vim.log.levels.WARN)
    return
  end

  -- Prefer current directory.
  local curdir = vim.fn.fnamemodify(current_path, ":h")
  for _, e in ipairs(targets) do
    local local_path = string.format("%s/%s.%s", curdir, name, e)
    if vim.fn.filereadable(local_path) == 1 then
      vim.cmd("edit " .. vim.fn.fnameescape(local_path))
      return
    end
  end

  -- Project-wide search.
  -- Enable recursive globstar.
  vim.o.globstar = true
  for _, e in ipairs(targets) do
    local pattern = string.format("%s/**/%s.%s", root, name, e)
    local matches = vim.fn.glob(pattern, true, true)
    if matches and #matches > 0 then
      -- Exclude the current file when multiple matches exist.
      for _, f in ipairs(matches) do
        if vim.fn.fnamemodify(f, ":p") ~= vim.fn.fnamemodify(current_path, ":p") then
          vim.cmd("edit " .. vim.fn.fnameescape(f))
          return
        end
      end
    end
  end

  vim.notify("No matching header/source file found", vim.log.levels.WARN)
end

return M