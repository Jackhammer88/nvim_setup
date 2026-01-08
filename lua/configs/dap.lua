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


local function get_netcoredbg_path()
  local path = require("mason-core.path")
  local settings = require("mason.settings")

  local mason_root = settings.current.install_root_dir
  local pkg = path.concat { mason_root, "packages", "netcoredbg" }

  local candidates = {
    path.concat { pkg, "netcoredbg" },
    path.concat { pkg, "netcoredbg.exe" }, -- на всякий
    path.concat { pkg, "extension", "adapter", "netcoredbg" }, -- если вдруг такая раскладка
  }

  for _, p in ipairs(candidates) do
    if vim.fn.filereadable(p) == 1 then
      return p
    end
  end

  vim.notify("netcoredbg not found. Run :MasonInstall netcoredbg", vim.log.levels.WARN)
  return nil
end

local netcoredbg = get_netcoredbg_path()
if not netcoredbg then
  return
end

dap.adapters.coreclr = {
  type = "executable",
  command = netcoredbg,
  args = { "--interpreter=vscode" },
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

