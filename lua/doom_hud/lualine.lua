local M = {}
local colors = require("doom_hud.palette")

-- Elemento: Doomguy Face baseada no modo do Vim
local function doomguy_face()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "i" then
		return " 󰚌 [ST RAGED] " -- Atirando (Modo de Inserção)
	elseif mode == "v" or mode == "V" or mode == "" then
		return " 󰕚 [ST SHOCK] " -- Olhando pros lados (Modo Visual)
	else
		return " 󰊭 [ST EVIL] " -- Sorriso clássico (Modo Normal)
	end
end

-- Elemento: Vida calculada dinamicamente via erros de LSP
-- local function dynamic_health()
--   local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
--   if errors > 5 then
--     return "󰏤 35% [CRITICAL]"
--   elseif errors > 0 then
--     return "󰏤 72% [WARNING]"
--   else
--     return "󰏤 100% [HEALTH]"
--   end
-- end
--
-- -- Elemento: Munição baseada no mapeamento de linhas do arquivo
-- local function ammo_counter()
--   local current_line = vim.fn.line(".")
--   local total_lines = vim.fn.line("$")
--   return string.format("󰆧 %d/%d AMMO", current_line, total_lines)
-- end

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
			-- CORREÇÃO AQUI: Substituímos por caracteres universais de bloco/barra
			-- para evitar o estouro de estouro de caractere ilegal na API do Vim
			component_separators = { left = "|", right = "|" },
			section_separators = { left = " ", right = " " },
			globalstatus = true,
		},
		sections = {
			lualine_a = { {
				"mode",
				fmt = function(str)
					return "󰊓 DOOM:" .. str
				end,
			} },
			lualine_b = { { "branch", icon = "" }, "diff" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {
				{ doomguy_face, color = { fg = colors.gold, bg = colors.bg_surface, bold = true } },
			},
			lualine_y = { {
				"progress",
				fmt = function(str)
					return "󱠇 ARMOR: " .. str
				end,
			} },
			lualine_z = { {
				"location",
				fmt = function(str)
					return "󰊓 AMMO: " .. str
				end,
			} },
		},
	}
end
-- function M.get_config()
--   -- Definição de transições de cores da barra
--   local theme = {
--     normal = {
--       a = { bg = colors.orange, fg = colors.bg, bold = true },
--       b = { bg = colors.bg_surface, fg = colors.fg },
--       c = { bg = colors.bg_surface, fg = colors.fg },
--     },
--     insert = {
--       a = { bg = colors.green, fg = colors.bg, bold = true },
--     },
--     visual = {
--       a = { bg = colors.blue, fg = colors.fg, bold = true },
--     },
--     replace = {
--       a = { bg = colors.red, fg = colors.fg, bold = true },
--     },
--     inactive = {
--       a = { bg = colors.bg_surface, fg = colors.muted },
--       b = { bg = colors.bg_surface, fg = colors.muted },
--       c = { bg = colors.bg_surface, fg = colors.muted },
--     },
--   }
--
--   return {
--     options = {
--       theme = theme,
--       component_separators = { left = "┨", right = "┠" },
--       section_separators = { left = "▓▒░", right = "░▒▓" },
--       globalstatus = true,
--     },
--     sections = {
--       lualine_a = { { "mode", fmt = function(str) return "󰊓 DOOM:" .. str end } },
--       lualine_b = { { "branch", icon = "" }, "diff" },
--       lualine_c = { { "filename", path = 1 } },
--       lualine_x = {
--         {
--           dynamic_health,
--           color = function()
--             local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
--             return { fg = errors > 0 and colors.red or colors.green, bold = true }
--           end
--         },
--         { doomguy_face, color = { fg = colors.gold, bg = colors.bg_surface, bold = true } },
--       },
--       lualine_y = {
--         { ammo_counter, color = { fg = colors.blue, bold = true } },
--       },
--       lualine_z = {
--         { "progress", fmt = function(str) return "󱠇 ARMOR: " .. str end }
--       },
--     },
--   }
-- end

return M
