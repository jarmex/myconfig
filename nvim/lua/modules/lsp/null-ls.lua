local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local b = null_ls.builtins
local utils = require("null-ls.utils").make_conditional_utils()

local function preferedEslint()
	return utils.root_has_file({ ".eslintrc", ".eslintrc.js", "eslintrc.json" })
end

local sources = {
	function()
		return preferedEslint() and b.formatting.prettierd or b.formatting.eslint_d
	end,
	function()
		return preferedEslint() and b.diagnostics.eslint or b.diagnostics.eslint_d
	end,
	b.code_actions.eslint_d,
	-- b.diagnostics.eslint,
	b.formatting.stylua,
	b.formatting.rustfmt,
	b.formatting.google_java_format,
	b.formatting.black.with({ extra_args = { "--fast" } }),
	b.diagnostics.yamllint,
	b.diagnostics.hadolint, -- dockerfile
}

null_ls.setup({
	debug = false,
	-- on_attach = on_attach,
	sources = sources,
	on_attach = require("modules.lsp.handlers").on_attach,
})
