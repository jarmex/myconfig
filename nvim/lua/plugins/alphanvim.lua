return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local startify = require("alpha.themes.startify")
		-- ignore filetypes in MRU
		---@diagnostic disable-next-line: unused-local
		startify.mru_opts.ignore = function(path, ext)
			return (string.find(path, "COMMIT_EDITMSG"))
		end
		-- disable MRU cwd
		-- startify.section.mru_cwd.val = { { type = "padding", val = 0 } }

		startify.section.top_buttons.val = {
			startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		}
		alpha.setup(startify.config)
	end,
}
