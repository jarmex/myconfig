local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local b = null_ls.builtins
-- local utils = require("null-ls.utils").make_conditional_utils()

local function preferedEslint(utils)
	return utils.root_has_file({ ".eslintrc", ".eslintrc.yml", ".eslintrc.yaml", ".eslintrc.js", "eslintrc.json" })
end

local sources = {
	-- code action
	b.code_actions.eslint_d,
	-- diagnostics
	b.diagnostics.yamllint.with({ extra_filetypes = { "yml" } }), -- add support for yml extensions
	b.diagnostics.hadolint, -- dockerfile
	b.diagnostics.eslint.with({
		condition = function(utils)
			return preferedEslint(utils)
		end,
	}),
	b.diagnostics.eslint_d.with({
		condition = function(utils)
			return not preferedEslint(utils)
		end,
	}),
	b.diagnostics.tidy, -- xml
	--
	-- formatting
	b.formatting.tidy,
	b.formatting.prettierd.with({
		extra_filetypes = { "yml" },
	}),
	b.formatting.stylua,
	b.formatting.rustfmt,
	b.formatting.google_java_format,
	b.formatting.black.with({ extra_args = { "--fast" } }),
	--b.formatting.jq, --json
}

null_ls.setup({
	debug = false,
	-- on_attach = on_attach,
	sources = sources,
	on_attach = require("modules.lsp.handlers").on_attach,
})
