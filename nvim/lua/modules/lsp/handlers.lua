local u_ok, u = pcall(require, 'modules.utils.utils')
if not u_ok then
  return
end

local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = ",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  -- commands
  u.lua_command('LspFormatting', 'vim.lsp.buf.formatting()')
  u.lua_command('Format', 'vim.lsp.buf.formatting()')
  u.lua_command('LspHover', 'vim.lsp.buf.hover()')
  u.lua_command('LspRename', 'vim.lsp.buf.rename()')
  u.lua_command('LspDiagPrev', 'vim.diagnostic.goto_prev({ popup_opts = global.lsp.popup_opts })')
  u.lua_command('LspDiagNext', 'vim.diagnostic.goto_next({ popup_opts = global.lsp.popup_opts })')
  u.lua_command('LspDiagLine', 'vim.diagnostic.open_float(0, { scope="line" })')
  u.lua_command('LspSignatureHelp', 'vim.lsp.buf.signature_help()')
  u.lua_command('LspTypeDef', 'vim.lsp.buf.type_definition()')
  u.lua_command('LspProblem', 'vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })')
  u.lua_command('LspDeclaration', 'vim.lsp.buf.declaration()')
  u.lua_command('LspImplementation', 'vim.lsp.buf.implementation()')
  u.lua_command('LspDiagList', 'vim.diagnostic.setloclist()')

  -- bindings
  u.buf_map('n', '<leader>R', ':LspRename<CR>', nil, bufnr)
  u.buf_map('n', 'gy', ':LspTypeDef<CR>', nil, bufnr)
  u.buf_map('n', 'K', ':LspHover<CR>', nil, bufnr)
  u.buf_map('n', '[d', ':LspDiagPrev<CR>', nil, bufnr)
  u.buf_map('n', ']d', ':LspDiagNext<CR>', nil, bufnr)
  u.buf_map('n', '<leader>D', ':LspDiagLine<CR>', nil, bufnr)
  u.buf_map('n', '<leader>d', ':LspProblem<CR>', nil, bufnr)
  u.buf_map('n', '<C-k>', ':LspSignatureHelp<CR>', nil, bufnr)
  u.buf_map('n', '<leader>q', ':LspDiagList<CR>', nil, bufnr)

  -- telescope
  u.buf_map('n', '<leader>lr', ':LspRef<CR>', nil, bufnr)
  u.buf_map('n', 'gr', ':LspRef<CR>', nil, bufnr)
  u.buf_map('n', 'gd', ':LspDef<CR>', nil, bufnr)
  u.buf_map('n', 'gD', ':LspDeclaration<CR>', nil, bufnr)
  u.buf_map('n', 'gi', ':LspImplementation<CR>', nil, bufnr)
  u.buf_map('n', 'gT', ':LspDef<CR>', nil, bufnr)
  u.buf_map('n', 'la', ':LspAct<CR>', nil, bufnr)
  u.buf_map('n', 'ls', ':LspSym<CR>', nil, bufnr)
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client) -- disable this if it is anonying
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local signature_ok, signature = pcall(require, 'lsp_signature')
if not signature_ok then
  return
end

-- signature
signature.on_attach({
  bind = true,
  handler_opts = {
    border = 'rounded',
    virtual_text_pos = 'eol',
  },
  floating_window_above_cur_line = true,
  zindex = 50,
  --toggle_key = '<M-x>',
})

return M
