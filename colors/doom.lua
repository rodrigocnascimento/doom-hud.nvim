-- Garante que o motor do plugin seja invocado se alguém rodar :colorscheme doom
local ok, err = pcall(function()
	require("doom_hud.theme").apply()
end)
if not ok then
	vim.notify("Error loading doom colorscheme: " .. err, vim.log.levels.ERROR)
end