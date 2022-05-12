local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.setup({
	ensure_installed = { "rust_analyzer", "sumneko_lua", "tsserver", "gopls" }, -- ensure these servers are always installed
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})
require("modules.lsp.rusttools")
require("modules.lsp.settings.jsonls")
require("modules.lsp.settings.yamlls")
require("modules.lsp.settings.tsserver")
require("modules.lsp.settings.sumneko_lua")
require("modules.lsp.settings.pyright")
require("modules.lsp.settings.emmet_ls")
require("modules.lsp.settings.gopls")
--jdt.ls is setup differently
