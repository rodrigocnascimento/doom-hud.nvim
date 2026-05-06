local M = {}
local colors = require("doom_hud.palette")

function M.setup(opts)
	opts = opts or {}
	require("doom_hud.theme").apply()
end

return M