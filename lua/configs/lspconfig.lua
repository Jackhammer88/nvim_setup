-- подхватываем nvchad-овские дефолты (on_attach, capabilities и т.п.)
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- какие сервера хотим
local servers = {
  "html",
  "cssls",
  "omnisharp",
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })

  -- собственно включаем сервер
  vim.lsp.enable(server)
end

