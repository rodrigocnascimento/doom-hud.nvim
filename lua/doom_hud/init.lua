local M = {}

function M.setup(opts)
	opts = opts or {}

	-- Aplica o colorscheme
	require("doom_hud.theme").apply()

	-- Integra lualine automaticamente se disponível e habilitado
	if opts.integrate_lualine ~= false then
		-- Função para configurar lualine
		local function setup_lualine()
			local lualine_ok, lualine = pcall(require, "lualine")
			if lualine_ok then
				lualine.setup(require("doom_hud.lualine").get_config())
			end
		end

		-- Aguardar UIEnter e usar defer_fn para garantir ordem de execução
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				vim.defer_fn(setup_lualine, 50)
			end,
		})
	end
end

return M