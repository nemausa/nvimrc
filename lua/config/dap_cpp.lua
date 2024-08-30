local dap = require('dap')
local dapui = require('dapui')
local os_name = vim.loop.os_uname().sysname

dapui.setup()

local os_config = {
    Linux = {
        home_var = "HOME",
        extension_subdirs = {".vscode-server/extensions/", ".vscode/extensions/"},
        binary_name = "OpenDebugAD7",
        MIMode = "gdb",
    },
    Windows_NT = {
        home_var = "USERPROFILE",
        extension_subdir = ".vscode/extensions/",
        binary_name = "OpenDebugAD7.exe",
        MIMode = "gdb",
    },
    Darwin = {
        home_var = "HOME",
        extension_subdirs = {".vscode-server/extensions/", ".vscode/extensions/"},
        binary_name = "OpenDebugAD7",
        MIMode = "lldb",
    }
}

local function find_open_debug_ad7(os_name)
    local config = os_config[os_name]
    if not config then
        return ''
    end

    local home_dir = os.getenv(config.home_var)
    local binary_name = config.binary_name

    local extension_subdirs = config.extension_subdirs or {config.extension_subdir}

    for _, subdir in ipairs(extension_subdirs) do
        local vscode_extensions_path = home_dir .. '/' .. subdir
        for _, ext in ipairs(vim.fn.glob(vscode_extensions_path .. 'ms-vscode.cpptools-*', true, true)) do
            local potential_path = ext .. '/debugAdapters/bin/' .. binary_name
            if vim.fn.filereadable(potential_path) == 1 then
                return potential_path
            end
        end
    end
    return ''
end


local function GetMIMode(os_name)
  local config = os_config[os_name]
  if not config then
      return ''
  end
  return config.MIMode
end

local function setup_dap_adapter(os_name)
  dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = find_open_debug_ad7(os_name),
      options = { detached = false },
  }
end

setup_dap_adapter(os_name)

dap.adapters.gdb = {
    type = 'executable',
    command = '/usr/local/bin/gdb',
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

if os_name == 'Linux' then
  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/lib/llvm-10/bin/lldb-vscode', 
    name = 'lldb'
  }
elseif os_name == 'Windows_NT' then
  dap.adapters.lldb = {
      type = 'executable',
      command = 'C:\\Program Files\\LLVM\\bin\\lldb-vscode.exe',
      name = 'lldb'
  }
elseif os_name == "Darwin" then
  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb',
    name = 'lldb'
  }
end

dap.configurations.c = {
  {
    name = "Launch cppdbg",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    MIMode = GetMIMode(os_name),
    runInTerminal = false,
    externalConsole = false,
    setupCommands = {
        {
            text = "-enable-pretty-printing",
            description = "Enable pretty printing",
            ignoreFailures = false
        }
    },
  },
  {
    name = "Launch gdb",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = true,
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

    runInTerminal = false,
    externalConsole = true,
    setupCommands = {
      text = "-enable-pretty-printing",
      description = "Enable pretty printing",
      ignoreFailures = false
    },
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
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
