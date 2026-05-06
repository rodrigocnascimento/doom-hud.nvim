local M = {}

function M.setup(opts)
	opts = opts or {}

	-- Aplica o colorscheme
	require("doom_hud.theme").apply()

	-- Integra lualine automaticamente se disponível e habilitado
	if opts.integrate_lualine ~= false then
		-- Usar VimEnter para garantir que lualine já foi carregado
		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			callback = function()
				local lualine_ok, lualine = pcall(require, "lualine")
				if lualine_ok then
					lualine.setup(require("doom_hud.lualine").get_config())
				end
			end,
		})
	end
end

return M