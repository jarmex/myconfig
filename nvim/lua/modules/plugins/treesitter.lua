--- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true,
  },
  textobjects = {
    lookahead = true,
    lsp_interop = {
      enable = true,
      border = 'rounded',
      ["<leader>df"] = "@function.outer",
      ["<leader>dF"] = "@class.outer",
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  tree_docs = {
    enable = true,
    spec_config = {
      jsdoc = {
        slots = {
          class = {author = true}
        },
        processors = {
          author = function()
            return " * @author James Amo"
          end
        }
      }
    }
  }
})

