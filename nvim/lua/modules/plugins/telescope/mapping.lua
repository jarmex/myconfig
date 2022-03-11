
local u = require('modules.utils.utils')

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua require('modules.plugins.telescope.config')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    u.map(mode, key, rhs, map_options)
  else
    u.buf_map(mode, key, rhs, map_options)
  end
end

-- generic mappings

--find * commands/mappings
u.command('Files', 'Telescope find_files theme=ivy')
u.command('Rg', 'Telescope live_grep theme=get_ivy')
u.command('GrepStr', 'Telescope grep_string theme=ivy')
u.command('BLines', 'Telescope current_buffer_fuzzy_find')
u.command('History', 'Telescope oldfiles')
u.command('Buffers', 'Telescope buffers')

--git * commands
u.command('BCommits', 'Telescope git_bcommits')
u.command('Commits', 'Telescope git_commits')
u.command('Branchs', 'Telescope git_branches')
u.command('GStatus', 'Telescope git_status')

--help commands
u.command('HelpTags', 'Telescope help_tags')
u.command('ManPages', 'Telescope man_pages')

--- LSP Commands
u.command('LspRef', 'Telescope lsp_references')
u.command('LspDef', 'Telescope lsp_definitions')
u.command('LspSym', 'Telescope lsp_workspace_symbols')
u.command('LspAct', 'Telescope lsp_code_actions theme=cursor')
u.command('FixSuggestion', 'Telescope lsp_range_code_actions theme=cursor')


-- local map = vim.api.nvim_set_keymap
u.nmap('<Leader>T', ':Telescope<CR>')
u.nmap('<C-p>', "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>")
-- u.nmap('<Leader>p', ":Telescope file_browser path='%:p:h'<cr>") --not working
-- u.nmap('<Leader>e', '<cmd>lua require\'modules.plugins.telescope.config\'.project_files({theme=ivy})<cr>')
map_tele("<space>e", "project_files", { theme = "ivy" })
map_tele("<space>p", "file_browser")
map_tele("<space>fz", "search_only_certain_files")
map_tele("<space>fd", "fd")
map_tele("<space>dl", "Telescope diagnostics theme=ivy")
map_tele("<space>gw", "grep_string", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})


u.nmap('<Leader>sp', '<cmd>Rg<CR>')
u.nmap('<Leader>fs', '<cmd>GrepStr<CR>')
u.nmap('<Leader>b', '<cmd>Buffers<CR>')
u.nmap('<Leader>o', '<cmd>History<CR>')

-- lsp mappings/commands
u.map('n', '<Leader>r', '<cmd>LspRef<CR>')
u.map('n', '<Leader>w', '<cmd>FixSuggestion<CR>')
u.map('n', '<Leader>cc', '<cmd>LspAct<CR>')


-- u.nmap('<Leader>t', ':Telescope treesitter<CR>')
-- u.map('n', '<Leader>p', "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({cwd = require'telescope.utils'.buffer_dir()})<CR>")
-- u.map('n', '<Leader>H', ':HelpTags<CR>')
-- u.map('n', '<leader>m', ':ManPages<CR>')
-- u.nmap('<Leader>gc', '<cmd>Commits<CR>')
-- u.nmap('<Leader>gp', '<cmd>BCommits<CR>')
-- u.nmap('<Leader>gb', '<cmd>Branchs<CR>')
-- u.nmap('<Leader>gs', '<cmd>GStatus<CR>')
