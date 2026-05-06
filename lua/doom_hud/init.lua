local M = {}

function M.setup(opts)
	opts = opts or {}
	require("doom_hud.theme").apply()
end

return M