-- doom-hud.nvim - Doom-inspired HUD colorscheme for Neovim
-- This file is loaded automatically when the plugin is added to runtimepath

-- Prevent duplicate setup when using lazy-loading
if vim.g.loaded_doom_hud then
	return
end
vim.g.loaded_doom_hud = true

-- Apply colorscheme automatically when loaded via :colorscheme doom
-- or when the plugin is added to packpath
vim.api.nvim_create_autocmd("ColorSchemePre", {
	pattern = "doom",
	callback = function()
		vim.g.colors_name = "doom"
	end,
})