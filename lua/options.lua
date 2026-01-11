require "nvchad.options"

-- add yours here!
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.ale_enabled = 0
vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.o.fixendofline = false
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.g.tagbar_autoscan = 0
vim.diagnostic.disable()
vim.opt.whichwrap = "b,s,<,>,[,]"
vim.o.completeopt = "menu,menuone,noselect"
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local bg = vim.api.nvim_get_hl_by_name("Normal", true).background
      local fg = vim.api.nvim_get_hl_by_name("Normal", true).foreground
      if bg and fg then
        vim.cmd(string.format("highlight Pmenu guibg=#%06x guifg=#%06x", bg, fg))
      end
    end,
  })

if os.getenv "SSH_TTY" then
  vim.g.clipboard = {
    name = "OSC 52",
    -- Try to use OSC 52 escape sequences to copy to system clipboard
    -- It should not break anything if it’s not supported
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    -- Disable paste since it does not work in some terminals,
    -- i.e., xterm.js (many app based on Web tech use this)
    paste = {
      ["+"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
      ["*"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
    },
  }
end

require("configs.header_switch")
vim.keymap.set("n", "<leader>z", require("configs.header_switch").switch, { silent = true, desc = "Switching header/source files" })
vim.keymap.set("n", "<M-o>", require("configs.header_switch").switch, { silent = true, desc = "Switching header/source files" })
-- 设置支持的文件扩展名（.cpp, .c, .h, .hpp）
vim.opt.suffixesadd = { ".c", ".cpp", ".cc", ".h", ".hpp", ".hh" }

-- 设置路径搜索：全局路径（包括当前目录、所有子目录、src、include）
vim.opt.path:append { ".", "src", "include", "**", "../**" }
vim.opt.path:append { "tags", "**" }


-- 一键切换头/源文件
vim.keymap.set("n", "<leader>z", function()
  local current_file = vim.fn.expand("%:t")    -- 获取当前文件名
  local ext = vim.fn.expand("%:e")              -- 获取当前文件扩展名
  local new_file

  -- 如果是 .cpp 文件，寻找对应的 .h 文件
  if ext == "cpp" or ext == "c" then
    new_file = current_file:gsub("%.cpp$", ".h"):gsub("%.c$", ".h")
  -- 如果是 .h 文件，寻找对应的 .cpp 文件
  elseif ext == "h" or ext == "hpp" then
    new_file = current_file:gsub("%.h$", ".cpp"):gsub("%.hpp$", ".cpp")
  else
    vim.notify("当前文件不是 C/C++ 文件", vim.log.levels.WARN)
    return
  end

  -- 获取 path 配置并将其转化为字符串
  local path_str = table.concat(vim.opt.path:get(), ",")

  -- 查找目标文件（支持全局路径搜索）
  local result = vim.fn.findfile(new_file, path_str)
  if result ~= "" then
    vim.cmd("edit " .. result)
  else
    vim.notify("未找到匹配文件: " .. new_file, vim.log.levels.INFO)
  end
end, { desc = "切换源文件和头文件" })