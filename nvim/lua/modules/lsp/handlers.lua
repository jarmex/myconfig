local u = require('modules.utils.utils')
local M = {}


M.setup = function()
  local icons = require "modules.utils.icons"
  local signs = {

    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
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
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
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
  if client.resolved_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  end
end

local function lsp_keymaps(bufnr)
  -- commands
  u.lua_command('LspFormatting', 'vim.lsp.buf.formatting()')
  u.lua_command('LspHover', 'vim.lsp.buf.hover()')
  u.lua_command('LspRename', 'vim.lsp.buf.rename()')
  u.lua_command('LspDiagPrev', 'vim.diagnostic.goto_prev({ popup_opts = popup_opts })')
  u.lua_command('LspDiagNext', 'vim.diagnostic.goto_next({ popup_opts = popup_opts })')
  u.lua_command('LspDiagLine', 'vim.diagnostic.open_float(0, { scope="line" })')
  u.lua_command('LspSignatureHelp', 'vim.lsp.buf.signature_help()')
  u.lua_command('LspTypeDef', 'vim.lsp.buf.type_definition()')
  u.lua_command('LspProblem', 'vim.diagnostic.open_float()')
  u.lua_command('LspDeclaration', 'vim.lsp.buf.declaration()')
  u.lua_command('LspImplementation', 'vim.lsp.buf.implementation()')
  u.lua_command('LspDiagList', 'vim.diagnostic.setloclist()')
  u.lua_command('LspCodeAction', 'vim.lsp.buf.code_action()')

  -- bindings
  u.buf_map('n', '<Leader>R', ':LspRename<CR>', nil, bufnr)
  u.buf_map('n', 'gy', ':LspTypeDef<CR>', nil, bufnr)
  u.buf_map('n', 'K', ':LspHover<CR>', nil, bufnr)
  u.buf_map('n', '[d', ':LspDiagPrev<CR>', nil, bufnr)
  u.buf_map('n', ']d', ':LspDiagNext<CR>', nil, bufnr)
  u.buf_map('n', '<Leader>dk', ':LspDiagPrev<CR>', nil, bufnr)
  u.buf_map('n', '<Leader>dj', ':LspDiagNext<CR>', nil, bufnr)
  u.buf_map('n', '<Leader>D', ':LspDiagLine<CR>', nil, bufnr)
  u.buf_map('n', '<Leader>d', ':LspProblem<CR>', nil, bufnr)
  u.buf_map('n', '<C-k>', ':LspSignatureHelp<CR>', nil, bufnr)
  u.buf_map('n', '<Leader>q', ':LspDiagList<CR>', nil, bufnr)
  u.buf_map('n', 'ga', ':LspCodeAction<CR>', nill, bufnr)
  -- u.buf_map('i', '<C-x><C-x>', '<cmd>LspSignatureHelp<CR>', nil, bufnr)

  -- telescope
  u.buf_map('n', 'gr', ':LspRef<CR>', nil, bufnr)
  u.buf_map('n', 'gd', ':LspDef<CR>', nil, bufnr)
  u.buf_map('n', 'gT', ':LspDef<CR>', nil, bufnr)
  u.buf_map('n', 'gD', ':LspDeclaration<CR>', nil, bufnr)
  u.buf_map('n', 'gi', ':LspImplementation<CR>', nil, bufnr)
end

M.on_attach = function(client, bufnr)
  -- vim.notify(client.name .. " starting...")
  if client.name == "tsserver" or client.name == "html" then
    client.resolved_capabilities.document_formatting = false
  end

  if client.name == "jdt.ls" then
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.formatting()
    augroup end
  ]]
  vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
  M.remove_augroup "format_on_save"
  vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("modules.lsp.handlers").toggle_format_on_save()' ]]

return M

