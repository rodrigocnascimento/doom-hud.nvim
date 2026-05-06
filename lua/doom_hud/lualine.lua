local M = {}
local colors = require("doom_hud.palette")

-- Doomguy Face based on Vim mode
local function doomguy_face()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "i" then
		return "[I]"
	elseif mode:match("[vV]") then
		return "[V]"
	elseif mode == "R" then
		return "[R]"
	else
		return "[N]"
	end
end

-- Armor simulator (file progress)
local function dynamic_armor()
	local progress = math.floor((vim.fn.line(".") / vim.fn.line("$")) * 100)
	return string.format("%d%%", progress)
end

-- Ammo counter (column position)
local function ammo_counter()
	return string.format("%03d", vim.fn.col("."))
end

-- Health based on LSP errors
local function dynamic_health()
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	return errors > 0 and "ERR" or "OK"
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
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{ "mode", fmt = function(str) return " DOOM: " .. str:upper() end },
			},
			lualine_b = { "branch", "diff" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {
				{ dynamic_health, color = { fg = colors.green, bold = true } },
				{ doomguy_face, color = { fg = colors.gold, bg = colors.bg_surface, bold = true } },
			},
			lualine_y = { { ammo_counter, color = { fg = colors.blue, bold = true } } },
			lualine_z = { { dynamic_armor, color = { fg = colors.gold, bold = true } } },
		},
	}
end

return M