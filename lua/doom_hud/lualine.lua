local M = {}
local colors = require("doom_hud.palette")

-- Elemento: Doomguy Face baseada no modo do Vim
-- 1. Detecção dinâmica do Doomguy baseado no Modo de Edição
local function doomguy_face()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "i" then
		return " 😡 " -- Insert mode: Doomguy metendo bala
	elseif mode:match("[vV]") then
		return " 😎 " -- Visual mode: Sorrisinho de canto
	elseif mode == "R" then
		return " 💀 " -- Replace mode: Quase morto
	else
		return " 🗿 " -- Normal mode: Alerta, olhando pros lados
	end
end

-- 2. Simulador de Armor (Mapeia o progresso do arquivo de 0 a 100%)
local function dynamic_armor()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local progress = math.floor((current_line / total_lines) * 100)
	return string.format("󱠇 ARMOR: %3d%%", progress)
end

-- 3. Simulador de Munição (Mapeia a coluna atual como balas no pente)
local function ammo_counter()
	local col = vim.fn.col(".")
	return string.format("󰊓 AMMO: %03d/200", col)
end

-- Elemento: Vida calculada dinamicamente via erros de LSP
local function dynamic_health()
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	if errors > 5 then
		return "󰏤 35% [CRITICAL]"
	elseif errors > 0 then
		return "󰏤 72% [WARNING]"
	else
		return "󰏤 100% [HEALTH]"
	end
end

function M.get_config()
	local theme = {
		normal = {
			a = { bg = colors.orange, fg = colors.bg, bold = true },
			b = { bg = colors.bg_surface, fg = colors.fg },
			c = { bg = colors.bg_surface, fg = colors.fg },
		},
		insert = { a = { bg = colors.green, fg = colors.bg, bold = true } },
		visual = { a = { bg = colors.blue, fg = colors.fg, bold = true } },
		replace = { a = { bg = colors.red, fg = colors.fg, bold = true } },
	}

	return {
		options = {
			theme = theme,
			component_separators = { left = "┨", right = "┠" },
			section_separators = { left = "▓▒░", right = "░▒▓" }, -- Blocos de densidade clássicos
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
		},
		sections = {
			lualine_a = { {
				"mode",
				fmt = function(str)
					return "󰊓 DOOM:" .. str:upper()
				end,
			} },
			lualine_b = { { "branch", icon = "" }, "diff" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {
				{
					dynamic_health,
					color = { fg = colors.green, bold = true },
				},
				{ doomguy_face, color = { fg = colors.gold, bg = colors.bg_surface, bold = true } },
			},
			lualine_y = { { ammo_counter, color = { fg = colors.blue, bold = true } } },
			lualine_z = { { dynamic_armor, color = { fg = colors.gold, bold = true } } },
		},
	}
end

return M
