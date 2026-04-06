local dap = require('dap')

dap.adapters.codelldb = {
  type = 'executable',
  command = 'codelldb', -- or if not in $PATH: '/absolute/path/to/codelldb'

  -- On windows you may have to uncomment this:
  -- detached = false,
}

dap.configurations.cpp = {
    {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
            local exec = require('dap-util').path_to_executable()
            return exec == nil and dap.ABORT or exec
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
