local lspconfig = require('lspconfig')
local u = require('modules.utils.utils')

local ts_utils_settings = {
  enable_import_on_completion = true,
  import_all_scan_buffers = 100,
  eslint_bin = 'eslint_d',
  eslint_enable_diagnostics = true,
  eslint_opts = {
    condition = function(utils)
      return utils.root_has_file('.eslintrc.js')
    end,
    diagnostics_format = '#{m} [#{c}]',
  },
  enable_formatting = true,
  formatter = 'eslint_d',
  update_imports_on_move = true,
  -- filter out dumb module warning
  filter_out_diagnostics_by_code = { 80001 },
   -- inlay hints
  auto_inlay_hints = true,
  inlay_hints_highlight = "Comment",
}

local M = {}
M.setup = function(onAttach)
 lspconfig.tsserver.setup({
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client, bufnr)
    onAttach(client, bufnr)
    client.resolved_capabilities.documentformatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    -- defaults
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,

      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
          same_file = 1, -- add to existing import statement
          local_files = 2, -- git files or files with relative path markers
          buffer_content = 3, -- loaded buffer content
          buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      -- if false will avoid organizing imports
      always_organize_imports = true,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},

      -- inlay hints
      auto_inlay_hints = false,
      inlay_hints_highlight = "Comment",
      inlay_hints_priority = 200, -- priority of the hint extmarks
      inlay_hints_throttle = 150, -- throttle the inlay hint request
      inlay_hints_format = { -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
        -- Example format customization for `Type` kind:
        -- Type = {
        --     highlight = "Comment",
        --     text = function(text)
        --         return "->" .. text:sub(2)
        --     end,
        -- },
      },

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,
    })
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    u.buf_map('n', '<Leader>gs', ':TSLspOrganize<CR>', nil, bufnr)
    u.buf_map('n', '<Leader>gi', ':TSLspImportAll<CR>', nil, bufnr)
    u.buf_map('n', '<Leader>gr', ':TSLspRenameFileCR>', nil, bufnr)
    u.buf_map('n', '<Leader>ii', ':TSLspImportCurrent<CR>', nill, bufnr)
  end,
  flags = {
      debounce_text_changes = 150,
    },
})
end

return M
