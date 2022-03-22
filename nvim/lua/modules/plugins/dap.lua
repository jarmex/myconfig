
local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
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

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      -- { id = "stacks", size = 0.25 },
      -- { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "right", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = {},
    -- elements = { "repl" },
    -- size = 10,
    -- position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
