local M = {}
local colors = require("doom_hud.palette")

-- Doomguy Face baseada no modo do Vim
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

-- Armor simulator (file progress 0 to 100%)
local function dynamic_armor()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local progress = math.floor((current_line / total_lines) * 100)
	return string.format("ARM:%3d%%", progress)
end

-- Ammo counter (column position)
local function ammo_counter()
	local col = vim.fn.col(".")
	return string.format("AMO:%03d", col)
end

-- Health based on LSP errors
local function dynamic_health()
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	if errors > 5 then
		return "HLTH:35%"
	elseif errors > 0 then
		return "HLTH:72%"
	else
		return "HLTH:100%"
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
			component_separators = "",
			section_separators = "",
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
		},
		sections = {
			lualine_a = { {
				"mode",
				fmt = function(str)
					return " DOOM: " .. str:upper()
				end,
			} },
			lualine_b = { "branch", "diff" },
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