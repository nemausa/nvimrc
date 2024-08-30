local dap = require('dap')
local os_name = vim.loop.os_uname().sysname

-- Helper function to find Python executable
local function find_python()
  local python_paths = {
    "python3",         -- Default for Unix-like systems
    "/usr/bin/python3",
    "/usr/local/bin/python3",
    "C:\\Python312\\python.exe", -- Default for Windows
    "python",          -- Fallback for Unix-like systems
  }

  -- Try to find a valid Python executable
  for _, python_path in ipairs(python_paths) do
    if vim.fn.executable(python_path) == 1 then
      return python_path
    end
  end

  -- Fallback if no Python executable was found
  return "python"
end

local python_path = find_python()

-- Set up Python adapter based on OS
dap.adapters.python = {
  type = 'executable',
  command = python_path,
  args = { '-m', 'debugpy.adapter' },
}

-- Set up Python configuration
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',  -- Adjust this to the file you want to debug
    pythonPath = function()
      return python_path
    end,
    console = 'integratedTerminal',
  },
}
