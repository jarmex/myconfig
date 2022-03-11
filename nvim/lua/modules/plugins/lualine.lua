
-- https://github.com/hoob3rt/lualine.nvim
local lualine_ok, lualine = pcall(require, 'lualine')
if not lualine_ok then
  return
end

-- Disabling separators
-- options = {section_separators = '', component_separators = ''}

local options = { theme = 'auto', section_separators = '', component_separators = '' }
local extensions = { 'quickfix', 'nvim-tree' }

-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

lualine.setup({
  options = options,
  extensions = extensions,
})
