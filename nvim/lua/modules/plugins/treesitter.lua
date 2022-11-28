--- https://github.com/nvim-treesitter/nvim-treesitter
local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

treesitter_config.setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		--additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			typescript = { __default = "// %s", __multiline = "/* %s */" },
		},
	},
	autotag = {
		enable = true,
		disable = { "xml" },
	},
	textobjects = {
		lookahead = true,
		lsp_interop = {
			enable = true,
			border = "rounded",
			["<leader>df"] = "@function.outer",
			["<leader>dF"] = "@class.outer",
		},
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	tree_docs = {
		enable = true,
		spec_config = {
			jsdoc = {
				slots = {
					class = { author = true },
				},
				processors = {
					author = function()
						return " * @author James Amo"
					end,
				},
			},
		},
	},
})

require("ts_context_commentstring.internal").update_commentstring({
	key = "__multiline",
})

require("ts_context_commentstring.internal").calculate_commentstring({
	location = require("ts_context_commentstring.utils").get_cursor_location(),
})
