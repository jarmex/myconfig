local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "modules.lsp.lsp-signature"
require "modules.lsp.lsp-installer"
require("modules.lsp.handlers").setup()
require("modules.lsp.handlers").enable_format_on_save()
require "modules.lsp.null-ls"
