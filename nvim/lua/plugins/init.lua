return {
	-- Libs lua
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",
	--- Lsp
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"ray-x/lsp_signature.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("modules.lsp")
		end,
	},

	"b0o/SchemaStore.nvim",

	{
		"SmiteshP/nvim-gps",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("modules.plugins.nvimgps")
		end,
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("modules.plugins.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind-nvim",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-calc",
			{
				"tzachar/cmp-tabnine",
				build = "./install.sh",
				dependencies = "hrsh7th/nvim-cmp",
				config = function()
					require("modules.plugins.tabnine")
				end,
			},
		},
	},
	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	{ "saadparwaiz1/cmp_luasnip" },

	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- auto pairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("modules.plugins.autopairs")
		end,
	},

	-- Close Buffer
	{
		"kazhala/close-buffers.nvim",
		cmd = "BDelete",
		config = function()
			require("modules.plugins.closebuffer")
		end,
	},

	--- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("modules.plugins.treesitter")
		end,
		dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
	},

	"nvim-treesitter/nvim-tree-docs",
	-- { "p00f/nvim-ts-rainbow" })
	"windwp/nvim-ts-autotag",
	"romgrk/nvim-treesitter-context",

	-- Dev div tools
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("modules.plugins.trouble")
		end,
	},

	-- Git
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("modules.plugins.gitsigns")
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		config = function()
			require("modules.plugins.lazygit")
		end,
	},

	-- Colors and nice stuff
	-- Theme: icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("modules.plugins.webdevicons")
		end,
	},

	-- use 'navarasu/onedark.nvim'
	-- use 'folke/tokyonight.nvim'
	{
		"catppuccin/nvim",
		config = function()
			require("modules.plugins.theme")
		end,
	},

	-- {
	-- 	"rafamadriz/neon",
	-- 	dependencies = {
	-- 		"ryanoasis/vim-devicons",
	-- 	},
	-- 	config = function()
	-- 		-- require("modules.plugins.neontheme")
	-- 	end,
	-- })

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("modules.plugins.colorizer")
		end,
	},
	-- Tabs
	{
		"akinsho/nvim-bufferline.lua",
		--event = "BufReadPre",
		config = function()
			require("modules.plugins.bufferline")
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("modules.plugins.lualine")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("modules.plugins.blankline")
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		-- event = "BufReadPost",
		config = function()
			require("modules.plugins.todo")
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("modules.plugins.symbol-outline")
		end,
	},

	-- Start Screen
	-- { "mhinz/vim-startify" })

	--[[ "tpope/vim-dadbod")
  "kristijanhusak/vim-dadbod-completion")
  "kristijanhusak/vim-dadbod-ui") ]]
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("modules.plugins.dap")
		end,
	},
	"theHamsta/nvim-dap-virtual-text",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	"Pocco81/DAPInstall.nvim",
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},

	"jose-elias-alvarez/typescript.nvim",

	"olexsmir/gopher.nvim",
	"mxsdev/nvim-dap-vscode-js",

	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},

	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	-- figet
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	-- refactoring
	-- {
	-- 	"ThePrimeagen/refactoring.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-treesitter/nvim-treesitter" },
	-- 	},
	-- 	config = function()
	-- 		require("modules.plugins.refactoring")
	-- 	end,
	-- })

	-- adding JAVA plugins
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- })

	{
		"nacro90/numb.nvim",
		config = function()
			require("modules.plugins.numb")
		end,
	},

	{
		"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			require("modules.plugins.notify")
		end,
	},

	--[[ {
		"RRethy/vim-illuminate",
		config = function()
			vim.g.Illuminate_highlightUnderCursor = 0
		end,
	},
]]
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("modules.plugins.terminal")
		end,
	},

	{
		"filipdutescu/renamer.nvim",
		config = function()
			require("modules.plugins.renamer")
		end,
	},

	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("modules.plugins.hop")
		end,
	},

	-- not using now
	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	dependencies = "nvim-lua/plenary.nvim",
	-- })
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("modules.plugins.inlay-hints")
		end,
	},

	-- Set root directory properly
	--[[ {
		"ahmedkhalf/project.nvim",
		config = function()
			require("modules.plugins.projectnvim")
		end,
	}, ]]

	--run any kind of tests from Vim (RSpec, Cucumber, Minitest)
	-- {
	-- 	-- "vim-test/vim-test",
	-- 	"klen/nvim-test",
	-- 	config = function()
	-- 		require("modules.plugins.nvimtest")
	-- 	end,
	-- })
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
			"rouge8/neotest-rust",
		},
		config = function()
			require("modules.plugins.neotest")
		end,
	},
	-- for lua stuff
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({})
		end,
	},
	-- fold area
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("modules.plugins.folds")
		end,
	},
}
