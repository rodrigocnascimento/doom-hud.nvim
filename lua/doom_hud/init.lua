local M = {}

function M.setup(opts)
	opts = opts or {}
	require("doom_hud.theme").apply()

	if opts.integrate_lualine ~= false then
		vim.defer_fn(function()
			local lualine_ok, lualine = pcall(require, "lualine")
			if lualine_ok then
				lualine.setup(require("doom_hud.lualine").get_config())
			end
		end, 100)
	end
end

return M