local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

local u = require("modules.utils.utils")

local ts_util_config = {
	debug = false,
	disable_commands = false,
	enable_import_on_completion = true,

	-- import all
	import_all_timeout = 5000, -- ms
	-- lower numbers = higher priority
	import_all_priorities = {
		same_file = 1, -- add to existing import statement
		local_files = 2, -- git files or files with relative path markers
		buffer_content = 3, -- loaded buffer content
		buffers = 4, -- loaded buffer names
	},
	import_all_scan_buffers = 100,
	import_all_select_source = false,
	-- if false will avoid organizing imports
	always_organize_imports = true,

	-- filter diagnostics
	filter_out_diagnostics_by_severity = {},
	filter_out_diagnostics_by_code = {},

	-- inlay hints
	auto_inlay_hints = false,
	inlay_hints_highlight = "Comment",
	inlay_hints_priority = 200, -- priority of the hint extmarks
	inlay_hints_throttle = 150, -- throttle the inlay hint request
	inlay_hints_format = { -- format options for individual hint kind
		Type = {},
		Parameter = {},
		Enum = {},
	},

	-- update imports on file move
	update_imports_on_move = false,
	require_confirmation_on_move = false,
	watch_dir = nil,
}

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
require("typescript").setup({
	-- disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		on_attach = require("modules.lsp.handlers").on_attach,
		capabilities = require("modules.lsp.handlers").common_capabilities(),
	},
})
