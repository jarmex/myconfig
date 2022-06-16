--hrsh7th/nvim-cmp
-- autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo,spectre_panel nnoremap <silent> <buffer> q :close<CR> 
    autocmd FileType qf set nobuflisted
  augroup end
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    ]])
	end,
})

-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.cmd([[
    setlocal wrap
    setlocal spell
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})
-- vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
-- 	callback = function()
-- 		local winbar_filetype_exclude = {
-- 			"help",
-- 			"startify",
-- 			"dashboard",
-- 			"packer",
-- 			"neogitstatus",
-- 			"NvimTree",
-- 			"Trouble",
-- 			"alpha",
-- 			"lir",
-- 			"Outline",
-- 			"spectre_panel",
-- 			"toggleterm",
-- 		}
--
-- 		if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
-- 			vim.opt_local.winbar = nil
-- 			return
-- 		end
--
-- 		local value = require("modules.core.winbar").gps()
--
-- 		if value == nil then
-- 			value = require("modules.core.winbar").filename()
-- 		end
--
-- 		vim.opt_local.winbar = value
-- 	end,
-- })
