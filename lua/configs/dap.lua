local dap = require "dap"
local dapui = require "dapui"

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


dap.adapters.coreclr = {
  type = 'executable',
  command = "/opt/netcoredbg/netcoredbg",
  args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch",
    request = "launch",
    program = function ()
      return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net10.0/', 'file')
    end,
  },
}

