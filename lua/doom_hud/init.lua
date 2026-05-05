local M = {}

function M.setup(opts)
	opts = opts or {}
	-- Aplica apenas o motor de cores e bordas
	require("doom_hud.theme").apply()
	vim.g.colors_name = "doom"
end

return M
