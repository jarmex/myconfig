local u = require("modules.utils.utils")

-- lspconfig.tsserver.setup({
-- 	capabilities = require("modules.lsp.handlers").common_capabilities(),
-- 	init_options = require("nvim-lsp-ts-utils").init_options,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
--
-- 	on_attach = function(client, bufnr)
-- 		local ts_utils = require("nvim-lsp-ts-utils")
-- 		-- defaults
-- 		ts_utils.setup(ts_util_config)
-- 		-- required to fix code action ranges and filter diagnostics
-- 		ts_utils.setup_client(client)
--
-- 		-- no default maps, so you may want to define some here
-- 		-- local opts = { silent = true }
-- 		u.buf_map("n", "<Leader>gs", ":TSLspOrganize<CR>", nil, bufnr)
-- 		u.buf_map("n", "<Leader>gi", ":TSLspImportAll<CR>", nil, bufnr)
-- 		u.buf_map("n", "<Leader>gr", ":TSLspRenameFileCR>", nil, bufnr)
-- 		u.buf_map("n", "<Leader>ii", ":TSLspImportCurrent<CR>", nil, bufnr)
--
-- 		require("modules.lsp.handlers").on_attach(client, bufnr)
-- 	end,
-- })

local onattach = require("modules.lsp.handlers")
require("typescript").setup({
	-- disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		on_attach = function(client, bufnr)
			onattach.on_attach(client, bufnr)
			u.buf_map("n", "go", ":TypescriptAddMissingImports<CR>", nil, bufnr)
			u.buf_map("n", "gO", ":TypescriptOrganizeImports<CR>", nil, bufnr)
			u.buf_map("n", "gI", ":TypescriptRenameFile<CR>", nil, bufnr)

			-- override
			u.buf_map("n", "gd", ":TypescriptGoToSourceDefinition<CR>", nil, bufnr)
		end,
		capabilities = require("modules.lsp.handlers").common_capabilities(),
	},
})
