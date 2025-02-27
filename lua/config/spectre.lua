-- lua/spectre.lua
local spectre = require("spectre")

spectre.setup({
  -- 设置打开方式，可根据喜好调整为水平分割(vnew)、垂直分割(hnew)等
  open_cmd = "vnew",
  -- 是否实时更新预览结果
  live_update = true,
  -- 自定义按键映射
  mapping = {
    ["send_to_qf"] = {
      map = "<leader>qf",
      cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
      desc = "Send all items to quickfix list",
    },
    ["replace_cmd"] = {
      map = "<leader>r",
      cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
      desc = "Execute replace command",
    },
  },
  -- 配置搜索引擎，默认使用 ripgrep
  find_engine = {
    ["rg"] = {
      cmd = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column"
      },
      options = {
        ["ignore-case"] = {
          value = "--ignore-case",
          icon = "[IC]",
          desc = "Ignore case sensitivity"
        },
        ["hidden"] = {
          value = "--hidden",
          icon = "[H]",
          desc = "Search in hidden files"
        }
      }
    },
  },
  -- 替换引擎配置，默认使用 sed
  replace_engine = {
    ["sed"] = {
      cmd = "sed",
      args = nil,
    },
  },
  default = {
    find = {
      cmd = "rg"
    },
    replace = {
      cmd = "sed"
    }
  },
  -- UI 定制化设置，调整边框、透明度等
  ui = {
    border = "rounded",  -- 圆角边框
    win_opts = {
      winblend = 5,  -- 窗口透明度，可根据需求调整
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",  -- 继承颜色主题的高亮设置
    },
  },
})

