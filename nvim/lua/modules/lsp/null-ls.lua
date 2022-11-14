local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local b = null_ls.builtins
-- local utils = require("null-ls.utils").make_conditional_utils()

local function preferedEslint(utils)
	return utils.root_has_file({ ".eslintrc", ".eslintrc.yml", ".eslintrc.yaml", ".eslintrc.js", "eslintrc.json" })
end

local command_resolver = require("null-ls.helpers.command_resolver")

local prettier = b.formatting.prettier.with({
	dynamic_command = command_resolver.from_node_modules(),
})

local sources = {
	-- code action
	--b.code_actions.eslint_d,
	b.code_actions.eslint.with({
		prefer_local = "node_modules/.bin",
		condition = function(utils)
			return preferedEslint(utils)
		end,
	}),
	-- diagnostics
	b.diagnostics.yamllint.with({ extra_filetypes = { "yml" } }), -- add support for yml extensions
	b.diagnostics.hadolint, -- dockerfile
	b.diagnostics.eslint.with({
		prefer_local = "node_modules/.bin",
		condition = function(utils)
			return preferedEslint(utils)
		end,
	}),
	b.diagnostics.tidy, -- xml
	b.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
	-- formatting
	prettier,
	b.formatting.tidy,
	b.formatting.prettierd.with({
		extra_filetypes = { "yml", "toml", "solidity" },
		extra_args = { "--single-quote", "--jsx-single-quote", "--print-width 80", "--trailing-comma es5" },
	}),
	b.formatting.stylua,
	b.formatting.rustfmt, -- rust
	b.formatting.google_java_format, --java
	b.formatting.black.with({ extra_args = { "--fast" } }), --python
	b.formatting.sql_formatter,
	--b.formatting.jq, --json
	--django html
	b.formatting.djlint,
	require("typescript.extensions.null-ls.code-actions"),
}

null_ls.setup({
	debug = false,
	-- on_attach = on_attach,
	sources = sources,
	on_attach = require("modules.lsp.handlers").on_attach,
})
