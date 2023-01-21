local nvim_test_ok, neotest = pcall(require, "neotest")
if not nvim_test_ok then
	return
end

local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
}, neotest_ns)

neotest.setup({
	-- your neotest config here
	adapters = {
		require("neotest-go")({
			experimental = {
				test_table = true,
			},
			-- args = { "-count=1", "-timeout=60s" }
		}),
		require("neotest-jest")({
			jestCommand = "pnpm test --",
			jestConfigFile = "custom.jest.config.ts",
			env = { CI = true },
			cwd = function(path)
				return vim.fn.getcwd()
			end,
		}),
		require("neotest-rust"),
	},
})

local u = require("modules.utils.utils")

-- vim.g["test#strategy"] = "toggleterm"
-- vim.g["test#neovim#term_position"] = "vert"
--
u.nmap("<leader>tn", ":lua require('neotest').run.run()<CR>") -- Test nearest test
u.nmap("<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>") -- Test file
u.nmap("<leader>td", ":lua require('neotest').run.run({strategy = 'dap'})<CR>")

-- test run output
u.nmap("<leader>ts", ":lua require('neotest').summary.toggle()<CR>") -- Test nearest test
u.nmap("<leader>to", ":lua require('neotest').output.open({ enter = false })<CR>") -- Test nearest test
u.nmap("<leader>tp", ":lua require('neotest').output_panel.toggle()<CR>") -- Test nearest test
-- u.nmap("<leader>ts", ":TestSuite<CR>") -- Test suite
-- u.nmap("<leader>tl", ":TestLast<CR>") -- Test last test run
-- u.nmap("<leader>tv", ":TestVisit<CR>") -- Test visit
