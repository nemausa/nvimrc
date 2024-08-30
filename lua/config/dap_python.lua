local dap = require('dap')
local dapui = require('dapui')

-- Configure nvim-dap-ui
dapui.setup()

-- Set up Python adapter
dap.adapters.python = {
  type = 'executable',
  command = '/usr/bin/python3.8',
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
      return '/usr/bin/python3.8'
    end,
  },
}