-- https://github.com/lukas-reineke/indent-blankline.nvim

local cmd = vim.cmd
local g = vim.g

-- g.indent_blankline_char = '▏'

g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true

g.indent_blankline_show_first_indent_level = false
g.indent_blankline_show_trailing_blankline_indent = false

g.indent_blankline_context_patterns = {
  "class",
  "return",
  "function",
  "method",
  "^if",
  "^do",
  "^switch",
  "^while",
  "jsx_element",
  "^for",
  "^object",
  "^table",
  "block",
  "arguments",
  "if_statement",
  "else_clause",
  "jsx_element",
  "jsx_self_closing_element",
  "try_statement",
  "catch_clause",
  "import_statement",
  "operation_type",
}

g.indent_blankline_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "terminal",
}
g.indent_blankline_buftype_exclude = { 'help', 'terminal', 'nofile' }
g.indent_blankline_char_highlight = 'LineNr'
g.indent_blankline_max_indent_increase = 1
cmd([[ hi IndentBlanklineChar guifg=#aaaaaa ]])

vim.opt.termguicolors = true
vim.opt.listchars:append("eol:↴")
vim.wo.colorcolumn = "99999"

require("indent_blankline").setup {
  char = "|",
  show_trailing_blankline_indent = false,
  show_end_of_line = true,
}
