
local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

local u = require('modules.utils.utils')

u.nmap("<F5>", "<cmd> lua require(\"dap\").continue<CR>" )
u.nmap("<F10>", "<cmd> lua require(\"dap\").step_over<CR>" )
u.nmap("<F11>", "<cmd> lua require(\"dap\").step_into<CR>" )
u.nmap("<F12>", "<cmd> lua require(\"dap\").step_out<CR>" )
u.nmap("<F3>", "<cmd> lua require(\"dap\").toggle_breakpoint<CR>" )
--[[ u.nmap("<space>dr", "<cmd> lua require(\"dap\").repl.open<CR>" )
u.nmap("<space>dl", "<cmd> lua require(\"dap\").run_last<CR>" ) ]]
--[[ vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Breakpoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Stopped" }) ]]
require("telescope").load_extension "dap" 

