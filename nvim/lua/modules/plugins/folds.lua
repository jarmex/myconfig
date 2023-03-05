vim.o.foldcolumn = "1"

local ufo_ok, ufo = pcall(require, "ufo")

if not ufo_ok then
	vim.o.foldmethod = "indent"
	vim.o.foldlevelstart = 99
	vim.o.foldminlines = 2
	return
end

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

ufo.setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
