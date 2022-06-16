-- https://github.com/hoob3rt/lualine.nvim
local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
	return
end

local gps_ok, gps = pcall(require, "nvim-gps")
if not gps_ok then
	return
end

local theme = require("lualine.themes.catppuccin")
theme.normal.c.bg = require("lualine.utils.utils").extract_highlight_colors("Normal", "bg")
-- options = {section_separators = '', component_separators = ''}

local extensions = { "quickfix", "nvim-tree" }

lualine.setup({
	options = {
		icons_enabled = true,
		theme = require("modules.utils.statusline").theme(), -- "catppuccin",
		--		section_separators = { left = "", right = "" },
		--		section_separators = { left = '', right = ''},
		section_separators = { left = "", right = "" },
		component_separators = "",
		globalstatus = true,
		always_divide_middle = true,
	},
	sections = {
		-- lualine_a = { { "mode", separator = { left = "", right = "" } } },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { gps.get_location, cond = gps.is_available } },
		-- lualine_c = { { "filename" }, { gps.get_location, cond = gps.is_available } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		-- lualine_z = { { "location", separator = { left = "", right = "" } } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = extensions,
})
