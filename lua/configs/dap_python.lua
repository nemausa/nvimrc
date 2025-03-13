-- Require the nvim-dap-python plugin (if installed)
require('dap-python').setup('python')  -- Adjust 'python' to your virtualenv or python path if needed

-- Alternatively, you can configure nvim-dap manually:
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = 'python3';  -- Use the path to your Python interpreter if necessary
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";  -- This configuration will launch the current file
    pythonPath = function()
      -- Use a custom pythonPath if needed, otherwise fallback to 'python'
      return '/usr/bin/python3'
    end;
  },
}