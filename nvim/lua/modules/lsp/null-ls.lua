local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local b = null_ls.builtins

local sources = {
  function()
    local utils = require("null-ls.utils").make_conditional_utils()
    return utils.root_has_file(".eslintrc.js") and b.formatting.eslint_d or b.formatting.prettierd
  end,
  b.code_actions.eslint_d,
  b.diagnostics.eslint_d,
  b.formatting.stylua,
  b.formatting.rustfmt,
  b.diagnostics.yamllint,
  b.formatting.google_java_format,
}


null_ls.setup({
  debug = false,
  -- on_attach = on_attach,
  sources = sources,
})

