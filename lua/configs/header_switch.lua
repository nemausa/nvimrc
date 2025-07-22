local M = {}

-- 搜索 project 根目录 (优先 git)
local function get_root()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_root and git_root ~= '' then
    return git_root
  end
  return vim.fn.getcwd()
end

-- 获取完整basename（多后缀处理，比如 foo.bar.cpp）
local function get_basename(path)
  local fname = vim.fn.fnamemodify(path, ":t")
  return fname:gsub('%.[^%.]+$', '')
end

function M.switch()
  local current_path = vim.api.nvim_buf_get_name(0)
  if current_path == "" then
    return
  end

  local ext  = vim.fn.fnamemodify(current_path, ":e")
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

  -- 当前目录优先
  local curdir = vim.fn.fnamemodify(current_path, ":h")
  for _, e in ipairs(targets) do
    local local_path = string.format("%s/%s.%s", curdir, name, e)
    if vim.fn.filereadable(local_path) == 1 then
      vim.cmd('edit ' .. vim.fn.fnameescape(local_path))
      return
    end
  end

  -- 全项目搜索
  -- 启用递归 globstar
  vim.o.globstar = true
  for _, e in ipairs(targets) do
    local pattern = string.format("%s/**/%s.%s", root, name, e)
    local matches = vim.fn.glob(pattern, true, true)
    if matches and #matches > 0 then
      -- 多个匹配时排除当前文件
      for _, f in ipairs(matches) do
        if vim.fn.fnamemodify(f, ":p") ~= vim.fn.fnamemodify(current_path, ":p") then
          vim.cmd('edit ' .. vim.fn.fnameescape(f))
          return
        end
      end
    end
  end

  vim.notify("No matching header/source file found", vim.log.levels.WARN)
end

return M
