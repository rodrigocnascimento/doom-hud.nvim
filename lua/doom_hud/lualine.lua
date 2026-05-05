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
	-- Paleta de cores agressiva do Doom HUD
	local theme = {
		normal = {
			a = { bg = colors.orange or "#D9896C", fg = "#1A1A1A", bold = true },
			b = { bg = "#2D2D2D", fg = colors.fg or "#F2D0A7" },
			c = { bg = "#1A1A1A", fg = colors.fg or "#F2D0A7" },
		},
		insert = { a = { bg = colors.green or "#A65B4B", fg = "#1A1A1A", bold = true } },
		visual = { a = { bg = colors.blue or "#594F57", fg = "#F2D8D8", bold = true } },
		replace = { a = { bg = colors.red or "#A65B4B", fg = "#1A1A1A", bold = true } },
	}

	return {
		options = {
			theme = theme,
			-- Usando os blocos pixelados clássicos escapados nativamente para não quebrar a API
			component_separators = { left = "ii", right = "ii" },
			section_separators = { left = "--", right = "--" },
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						return "󰊓 " .. str:upper()
					end,
				},
			},
			lualine_b = {
				{ "branch", icon = "" },
				{ "diff", colored = true },
			},
			lualine_c = {
				{ "filename", file_status = true, path = 1 },
			},
			lualine_x = {
				-- O Doomguy centralizado cuidando dos status
				{ doomguy_face, color = { fg = "#F2D0A7", bg = "#2D2D2D", bold = true } },
			},
			lualine_y = {
				{ dynamic_armor, color = { fg = "#D9896C", bold = true } },
			},
			lualine_z = {
				{ ammo_counter, color = { fg = "#A65B4B", bg = "#F2D0A7", bold = true } },
			},
		},
	}
end

-- function M.get_config()
-- 	local theme = {
-- 		normal = {
-- 			a = { bg = colors.orange, fg = colors.bg, bold = true },
-- 			b = { bg = colors.bg_surface, fg = colors.fg },
-- 			c = { bg = colors.bg_surface, fg = colors.fg },
-- 		},
-- 		insert = { a = { bg = colors.green, fg = colors.bg, bold = true } },
-- 		visual = { a = { bg = colors.blue, fg = colors.fg, bold = true } },
-- 		replace = { a = { bg = colors.red, fg = colors.fg, bold = true } },
-- 	}
--
-- 	return {
-- 		options = {
-- 			theme = theme,
-- 			-- CORREÇÃO AQUI: Substituímos por caracteres universais de bloco/barra
-- 			-- para evitar o estouro de estouro de caractere ilegal na API do Vim
-- 			component_separators = { left = "|", right = "|" },
-- 			section_separators = { left = " ", right = " " },
-- 			globalstatus = true,
-- 		},
-- 		sections = {
-- 			lualine_a = { {
-- 				"mode",
-- 				fmt = function(str)
-- 					return "󰊓 DOOM:" .. str
-- 				end,
-- 			} },
-- 			lualine_b = { { "branch", icon = "" }, "diff" },
-- 			lualine_c = { { "filename", path = 1 } },
-- 			lualine_x = {
-- 				{ doomguy_face, color = { fg = colors.gold, bg = colors.bg_surface, bold = true } },
-- 			},
-- 			lualine_y = { {
-- 				"progress",
-- 				fmt = function(str)
-- 					return "󱠇 ARMOR: " .. str
-- 				end,
-- 			} },
-- 			lualine_z = { {
-- 				"location",
-- 				fmt = function(str)
-- 					return "󰊓 AMMO: " .. str
-- 				end,
-- 			} },
-- 		},
-- 	}
-- end
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
