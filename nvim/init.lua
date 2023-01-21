pcall(require, "impatient")

P = function(v)
	print(vim.inspect(v))
	return v
end

_G.global = {}

require("modules.core")
require("modules.plugins")
