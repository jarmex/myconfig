-- adopted from https://github.com/n3wborn/nvim/blob/main/lua/modules/plugins/packer.lua

local cmd = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local fn = vim.fn

-- install packer if needed
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

packer.init({
  compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
	display = {
    working_sym = '🛠️ ', -- The symbol for a plugin being installed/updated
    error_sym = '🧨', -- The symbol for a plugin with an error in installation/updating
    done_sym = '🎉', -- The symbol for a plugin which has completed installation/updating
    removed_sym = '🔥', -- The symbol for an unused plugin which was removed
    moved_sym = '🚀', -- The symbol for a plugin which was moved (e.g. from opt to start)
    open_fn = function()
      return require("packer.util").float { border = 'rounded'}
    end,
	},
})

return packer.startup(function(use)
  -- Plugin manager
  use('wbthomason/packer.nvim')

  -- Libs lua
  use({
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
  })

  --- impatient 
  use 'lewis6991/impatient.nvim'

  --- Lsp
  use({
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('modules.lsp')
    end
  })

  use({
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    wants = "nvim-treesitter",
    module = "nvim-gps",
    config = function()
      require("nvim-gps").setup({ separator = " " })
    end,
  })

  -- Completion
  use({
    'hrsh7th/nvim-cmp',
    config = function()
      require('modules.plugins.cmp')
    end,
    requires = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim',
      {
        'L3MON4D3/luasnip',
      },
      "rafamadriz/friendly-snippets",
      {
        module = "nvim-autopairs",
        "windwp/nvim-autopairs",
        config = function()
          require('modules.plugins.autopairs')
        end,
      },
      "hrsh7th/cmp-calc",
      {
        'tzachar/cmp-tabnine', 
        run='./install.sh',
        requires = 'hrsh7th/nvim-cmp',
        config = function()
          require('modules.plugins.tabnine')
        end
      },
    }
  })

  -- Tab Nine configuration

  -- Close Buffer
  use({ 
    "kazhala/close-buffers.nvim",
    cmd = "BDelete",
    config=function()
      require('modules.plugins.closebuffer')
    end
  })

  -- TS Context comment string
  use({ "JoosepAlviste/nvim-ts-context-commentstring", module = "ts_context_commentstring" })

  --- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function()
      require('modules.plugins.telescope')
    end,
  })

  --- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-tree-docs'
    },
    config = function()
        require('modules.plugins.treesitter')
    end,
  })

    -- File explorer
  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('modules.plugins.nvimtree')
    end,
  })


  -- Dev div tools
  use({
    --'editorconfig/editorconfig-vim',
    'b3nj5m1n/kommentary',
    --'junegunn/vim-easy-align',
    -- 'tpope/vim-surround',
  })

  use ({
    'folke/trouble.nvim',
     requires = "kyazdani42/nvim-web-devicons",
     config = function ()
       require('modules.plugins.trouble')
    end
  })


  --[[ use({
    'kkoomen/vim-doge',
    run = ':call doge#install()',
    config = function()
      require('modules.plugins.doge')
    end
  }) ]]

  -- Git
  use 'tpope/vim-fugitive'
  use({
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('modules.plugins.gitsigns')
    end
  })

  use({
    'kdheepak/lazygit.nvim',
    config = function ()
      require('modules.plugins.lazygit')
    end
  })

  -- Colors and nice stuff
  -- Theme: icons
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require('modules.plugins.webdevicons')
    end,
  }

  -- use 'navarasu/onedark.nvim'
  -- use 'folke/tokyonight.nvim'
  use({
    'rafamadriz/neon',
    requires = {
      'ryanoasis/vim-devicons',
    },
    config = function()
      require('modules.plugins.colorscheme')
    end
  })

  use({
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('modules.plugins.colorizer')
    end,
  })
   -- Tabs
  use {
    "akinsho/nvim-bufferline.lua",
    --event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require('modules.plugins.bufferline')
    end,
  }

  -- Statusline
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons'},
    config = function()
      require('modules.plugins.lualine')
    end
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('modules.plugins.blankline')
    end,
  })

  use {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- event = "BufReadPost",
    opt = true,
    config = function()
      require('modules.plugins.todo')
    end
  }

  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
  })

  -- Start Screen
  use ({'mhinz/vim-startify'})

  --[[ use("tpope/vim-dadbod")
  use("kristijanhusak/vim-dadbod-completion")
  use("kristijanhusak/vim-dadbod-ui") ]]
  use{
    "mfussenegger/nvim-dap",
    requires = {
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require('modules.plugins.dap')
    end
  }

  use {
    "nathom/filetype.nvim",
    config = function()
      vim.g.did_load_filetypes = 1
    end,
  }

  use {
    "simrat39/rust-tools.nvim",
    requires = {
      "mfussenegger/nvim-dap"
    }
  }
  -- figet 
  use ({
    "j-hui/fidget.nvim",
    config = function()
      require"fidget".setup{}
    end
  })

  -- adding JAVA plugins 

  if packer_bootstrap then
      require('packer').sync()
  end

end
)
