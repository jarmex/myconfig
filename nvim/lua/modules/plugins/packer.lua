-- adopted from https://github.com/n3wborn/nvim/blob/main/lua/modules/plugins/packer.lua

-- install packer if needed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
	auto_reload_compiled = true,
	display = {
		working_sym = "🛠️ ", -- The symbol for a plugin being installed/updated
		error_sym = "🧨", -- The symbol for a plugin with an error in installation/updating
		done_sym = "🎉", -- The symbol for a plugin which has completed installation/updating
		removed_sym = "🔥", -- The symbol for an unused plugin which was removed
		moved_sym = "🚀", -- The symbol for a plugin which was moved (e.g. from opt to start)
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- Plugin manager
	use("wbthomason/packer.nvim")

	-- Libs lua
	use({
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
	})

	--- impatient
	use("lewis6991/impatient.nvim")

	--- Lsp
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	})

	use({
		"neovim/nvim-lspconfig",
		requires = {
			"ray-x/lsp_signature.nvim",
			-- "jose-elias-alvarez/nvim-lsp-ts-utils",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("modules.lsp")
		end,
	})

	use({ "b0o/SchemaStore.nvim" })

	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
		wants = "nvim-treesitter",
		config = function()
			require("modules.plugins.nvimgps")
		end,
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("modules.plugins.cmp")
		end,
		requires = {
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
				run = "./install.sh",
				requires = "hrsh7th/nvim-cmp",
				config = function()
					require("modules.plugins.tabnine")
				end,
			},
		},
	})
	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use({ "saadparwaiz1/cmp_luasnip" })
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- auto pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("modules.plugins.autopairs")
		end,
	})

	-- Close Buffer
	use({
		"kazhala/close-buffers.nvim",
		cmd = "BDelete",
		config = function()
			require("modules.plugins.closebuffer")
		end,
	})

	--- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("modules.plugins.telescope")
		end,
	})

	--- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("modules.plugins.treesitter")
		end,
	})

	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/nvim-tree-docs")
	-- use({ "p00f/nvim-ts-rainbow" })
	use("windwp/nvim-ts-autotag")
	use("romgrk/nvim-treesitter-context")

	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("modules.plugins.nvimtree")
		end,
	})

	-- Dev div tools
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("modules.plugins.trouble")
		end,
	})

	-- Git
	use("tpope/vim-fugitive")
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("modules.plugins.gitsigns")
		end,
	})

	use({
		"kdheepak/lazygit.nvim",
		config = function()
			require("modules.plugins.lazygit")
		end,
	})

	-- Colors and nice stuff
	-- Theme: icons
	use({
		"kyazdani42/nvim-web-devicons",
		module = "nvim-web-devicons",
		config = function()
			require("modules.plugins.webdevicons")
		end,
	})

	-- use 'navarasu/onedark.nvim'
	-- use 'folke/tokyonight.nvim'
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("modules.plugins.theme")
		end,
	})

	-- use({
	-- 	"rafamadriz/neon",
	-- 	requires = {
	-- 		"ryanoasis/vim-devicons",
	-- 	},
	-- 	config = function()
	-- 		-- require("modules.plugins.neontheme")
	-- 	end,
	-- })

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("modules.plugins.colorizer")
		end,
	})
	-- Tabs
	use({
		"akinsho/nvim-bufferline.lua",
		--event = "BufReadPre",
		wants = "nvim-web-devicons",
		config = function()
			require("modules.plugins.bufferline")
		end,
	})

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("modules.plugins.lualine")
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("modules.plugins.blankline")
		end,
	})

	use({
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		-- event = "BufReadPost",
		opt = true,
		config = function()
			require("modules.plugins.todo")
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("modules.plugins.symbol-outline")
		end,
	})

	-- Start Screen
	-- use({ "mhinz/vim-startify" })
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("modules.plugins.alphanvim")
		end,
	})

	--[[ use("tpope/vim-dadbod")
  use("kristijanhusak/vim-dadbod-completion")
  use("kristijanhusak/vim-dadbod-ui") ]]
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("modules.plugins.dap")
		end,
	})
	use("theHamsta/nvim-dap-virtual-text")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("Pocco81/DAPInstall.nvim")
	use({
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	})

	use("jose-elias-alvarez/typescript.nvim")

	use("olexsmir/gopher.nvim")
	use("mxsdev/nvim-dap-vscode-js")

	use({
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	})

	use({
		"simrat39/rust-tools.nvim",
		requires = {
			"mfussenegger/nvim-dap",
		},
	})
	-- figet
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})
	-- refactoring
	-- use({
	-- 	"ThePrimeagen/refactoring.nvim",
	-- 	requires = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-treesitter/nvim-treesitter" },
	-- 	},
	-- 	config = function()
	-- 		require("modules.plugins.refactoring")
	-- 	end,
	-- })

	-- adding JAVA plugins
	-- use({
	-- 	"mfussenegger/nvim-jdtls",
	-- })

	use({
		"nacro90/numb.nvim",
		config = function()
			require("modules.plugins.numb")
		end,
	})

	use({
		"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	})

	use({
		"rcarriga/nvim-notify",
		config = function()
			require("modules.plugins.notify")
		end,
	})

	use({
		"RRethy/vim-illuminate",
		config = function()
			vim.g.Illuminate_highlightUnderCursor = 0
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("modules.plugins.terminal")
		end,
	})

	use({
		"filipdutescu/renamer.nvim",
		config = function()
			require("modules.plugins.renamer")
		end,
	})

	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})
	use({
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	})
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("modules.plugins.hop")
		end,
	})

	-- not using now
	-- use({
	-- 	"sindrets/diffview.nvim",
	-- 	requires = "nvim-lua/plenary.nvim",
	-- })
	use({
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("modules.plugins.inlay-hints")
		end,
	})

	-- Set root directory properly
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("modules.plugins.projectnvim")
		end,
	})

	--run any kind of tests from Vim (RSpec, Cucumber, Minitest)
	-- use({
	-- 	-- "vim-test/vim-test",
	-- 	"klen/nvim-test",
	-- 	config = function()
	-- 		require("modules.plugins.nvimtest")
	-- 	end,
	-- })
	use({
		"nvim-neotest/neotest",
		requires = {
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
	})
	-- for lua stuff
	use({
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({})
		end,
	})
	-- fold area
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("modules.plugins.folds")
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
