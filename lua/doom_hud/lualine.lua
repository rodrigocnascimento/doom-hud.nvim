local M = {}
local colors = require("doom_hud.palette")

function M.get_config()
	local theme = {
		normal = {
			a = { bg = colors.orange, fg = colors.bg, bold = true },
			b = { bg = colors.bg_surface, fg = colors.fg },
			c = { bg = colors.bg_surface, bg = colors.fg },
		},
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
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	}
end

return M