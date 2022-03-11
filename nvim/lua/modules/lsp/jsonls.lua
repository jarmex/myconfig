-- from: https://github.com/mhartington/dotfiles/blob/main/config/nvim/lua/mh/lsp/init.lua
-- TODO:
local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach)
  lspconfig.jsonls.setup({
    cmd = {"vscode-json-language-server", "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"json", "jsonc"},
    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = {
          {
            fileMatch = {"package.json"},
            url = "https://json.schemastore.org/package.json"
          },
          {
            fileMatch = {"tsconfig*.json"},
            url = "https://json.schemastore.org/tsconfig.json"
          },
          {
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json"
            },
            url = "https://json.schemastore.org/prettierrc.json"
          },
          {
            fileMatch = {".eslintrc", ".eslintrc.json"},
            url = "https://json.schemastore.org/eslintrc.json"
          },
          {
            fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
            url = "https://json.schemastore.org/babelrc.json"
          },
          {
            fileMatch = {"lerna.json"},
            url = "https://json.schemastore.org/lerna.json"
          },
          {
            fileMatch = {"now.json", "vercel.json"},
            url = "https://json.schemastore.org/now.json"
          },
          {
            fileMatch = {
              ".stylelintrc",
              ".stylelintrc.json",
              "stylelint.config.json"
            },
            url = "http://json.schemastore.org/stylelintrc.json"
          }
        }
      }
    }
  })
end

return M
