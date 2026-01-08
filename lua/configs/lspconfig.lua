-- подхватываем nvchad-овские дефолты (on_attach, capabilities и т.п.)

local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults()

local mason_omnisharp = vim.fn.stdpath("data") .. "/mason/bin/omnisharp"

local function omnisharp_cmd()
  local pid = tostring(vim.fn.getpid())
  local args = {
    "-z",
    "--languageserver",
    "--hostPID", pid,
    "--encoding", "utf-8",
    "DotNet:enablePackageRestore=false",
  }

  if vim.fn.filereadable(mason_omnisharp) == 1 then
    return vim.list_extend({ mason_omnisharp }, args)
  end

  if vim.fn.executable("OmniSharp") == 1 then
    return vim.list_extend({ "OmniSharp" }, args)
  end

  return vim.list_extend({ "omnisharp" }, args)
end

local servers = {
  html = {},
  cssls = {},
  omnisharp = {
    cmd = omnisharp_cmd(),
  },
}

for server, opts in pairs(servers) do
  vim.lsp.config(server, vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, opts))

  vim.lsp.enable(server)
end

