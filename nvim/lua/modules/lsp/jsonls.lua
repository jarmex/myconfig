local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach, capabilities)
  lspconfig.jsonls.setup({
    cmd = {"vscode-json-language-server", "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"json", "jsonc"},
    settings = {
      json = {
        -- https://github.com/b0o/SchemaStore.nvim
        schemas = require('schemastore').json.schemas(),
      }
    }
  })
end

return M
