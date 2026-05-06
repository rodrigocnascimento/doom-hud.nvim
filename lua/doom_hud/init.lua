local M = {}

function M.setup(opts)
	opts = opts or {}

	-- Aplica o colorscheme
	require("doom_hud.theme").apply()

	-- Integra lualine automaticamente se disponível
	if opts.integrate_lualine ~= false then
		local lualine_ok, lualine = pcall(require, "lualine")
		if lualine_ok then
			lualine.setup(require("doom_hud.lualine").get_config())
		end
	end
end

return M