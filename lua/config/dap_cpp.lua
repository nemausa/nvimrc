local dap = require('dap')
local dapui = require('dapui')
local os_name = vim.loop.os_uname().sysname

-- 配置 nvim-dap-ui
dapui.setup()

-- 配置 gdb 调试器适配器
dap.adapters.gdb = {
    type = 'executable',
    command = '/usr/local/bin/gdb', -- GDB 的命令
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

-- 配置 lldb 调试器适配器
if os_name == 'Linux' then
  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/lib/llvm-10/bin/lldb-vscode', 
    name = 'lldb'
  }
elseif os_name == 'Windows_NT' then
  dap.adapters.lldb = {
      type = 'executable',
      command = 'C:\\Program Files\\LLVM\\bin\\lldb-vscode.exe', -- GDB 的命令
      name = 'lldb'
  }
elseif os_name == "Darwin" then
  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = 'lldb'
  }
end

dap.configurations.c = {
  {
    name = "Launch gdb",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}/bin",
    stopAtBeginningOfMainSubprogram = false,
  },
 {
    name = "Launch lldb",
    type = "lldb",
    request = "launch",
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- For C++ debugging
    runInTerminal = false,
},
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
       local name = vim.fn.input('Executable name (filter): ')
       return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:1234',
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}'
  },
}

dap.configurations.cpp = dap.configurations.c
-- 启用 dap-ui 的自动打开和关闭
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end