-- подхватываем nvchad-овские дефолты (on_attach, capabilities и т.п.)

local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults()

local servers = {
  html = {},
  cssls = {},
  omnisharp = {},
}

for server, opts in pairs(servers) do
  vim.lsp.config(server, vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, opts))

  vim.lsp.enable(server)
end

