local M = {}

-- 1. Carga Segura da Paleta
local colors = require("doom_hud.palette")

-- 2. Sistemas Vitais
local function doomguy_face()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" then return " 😡 "
  elseif mode:match("[vV]") then return " 😎 "
  elseif mode == "R" then return " 💀 "
  else return " 🗿 " end
end

local function dynamic_health()
  local ok_err, errors = pcall(function() return #vim.diagnosticolors.get(0, { severity = vim.diagnosticolors.severity.ERROR }) end)
  if not ok_err or errors == 0 then return "  󰄵 HP: 100%%" end
  return string.format("󰅚 HP: %02d%%%%", math.max(0, 100 - (errors * 15)))
end

local function health_color()
  local ok_err, errors = pcall(function() return #vim.diagnosticolors.get(0, { severity = vim.diagnosticolors.severity.ERROR }) end)
  if not ok_err or errors == 0 then return { fg = colors.hp_ok, gui = "bold" } end
  return { fg = colors.hp_danger, gui = "bold" }
end

local function ammo_counter()
  local ok_col, col = pcall(vim.fn.col, ".")
  return string.format("󰊓 AMMO: %03d/200", ok_col and col or 0)
end

local function dynamic_armor()
  local ok_cur, current = pcall(vim.fn.line, ".")
  local ok_tot, total = pcall(vim.fn.line, "$")
  if not ok_cur or not ok_tot or total == 0 then return "󱠇 AR: 100%%" end
  return string.format("󱠇 AR: %3d%%%%", math.floor((current / total) * 100))
end

local function equipped_weapon()
  local weapons = { go = "SUPER SHOTGUN", typescript = "PLASMA RIFLE", lua = "BFG-9000", rust = "CHAINSAW" }
  return "󰢹 WPN: " .. (weapons[vim.bo.filetype] or "PISTOL")
end

-- 3. O Tema Nativo de Marte
local doom_theme = {
  normal  = { a = { bg = colors.orange, fg = colors.bg, gui = "bold" }, b = { bg = colors.bg_surface, fg = colors.fg }, c = { bg = colors.bg, fg = colors.fg } },
  insert  = { a = { bg = colors.hp_ok, fg = colors.bg, gui = "bold" } },
  visual  = { a = { bg = colors.blue, fg = colors.fg, gui = "bold" } },
  replace = { a = { bg = colors.id_red, fg = colors.id_yellow, gui = "bold" } },
  command = { a = { bg = colors.gold, fg = colors.bg, gui = "bold" } },
}

local function modeFormatter(mode)
  -- Tabela de mapeamento direto (O(1) de complexidade)
  local icons = {
    ["NORMAL"]  = "󰰍  ",
    ["INSERT"]  = "󰏫  ",
    ["VISUAL"]  = "󰰔  ",
    ["V-LINE"]  = "󰰔  ",
    ["V-BLOCK"] = "󰰔  ",
    ["COMMAND"] = "󰞷  ",
    ["REPLACE"] = "󰛔  ",
  }
  -- Retorna o ícone do modo, ou um ícone padrão (fallback) se não achar
  return icons[mode] or "󰠭"
end

-- 4. O Construtor do HUD
function M.get_config()
  return {
    options = {
      icons_enabled = true,
      theme = doom_theme, -- Agora a Lualine respeita as suas cores!
      globalstatus = true,
      section_separators = { left = "▓▒░", right = "░▒▓" }, -- O motor nativo assume o controle das transições
      component_separators = { left = "", right = "" },
      refresh = { statusline = 100, tabline = 100, winbar = 100 }
    },
    sections = {
      lualine_a = {
        -- A transição do logo 'id' para a seção A principal
        { function() return " id " end, color = { fg = colors.id_yellow, bg = colors.id_red, gui = "bold" }, padding = 0 },
        { function() return "▓▒░" end, color = { fg = colors.id_red, bg = colors.orange }, padding = 0 },
        { "mode", fmt = function(str) return " DOOM:" .. modeFormatter(str) .. " " end, color = { fg = colors.id_yellow, bg = colors.orange, gui = "bold" }, padding = 0 }
      },
      lualine_b = {
        { "branch", icon = "󰄛  ", color = { fg = colors.text_white, gui = "bold" } }, 
        { "diff", color = { bg = colors.bg_surface } }
      },
      lualine_c = {
        { function() return "▓▒░ " end, color = { fg = colors.bg_surface, bg = colors.bg }, padding = 0 },
        { function() return "󰀻  DOOM 󰀻 " end, color = { fg = colors.text_gold, bg = colors.bg, gui = "bold" } },
        -- Usar branco puro no nome do arquivo para contraste máximo
        { "filename", path = 1, color = { fg = colors.text_white, bg = colors.bg } }
      },
      lualine_x = {
        { equipped_weapon, color = { fg = colors.blue, bg = colors.bg, gui = "bold" } },
        { function() return " ░▒▓" end, color = { fg = colors.bg_surface, bg = colors.bg }, padding = 0 },
      },
      lualine_y = {
        -- Munição ciano neon, está ótimo
        { ammo_counter, color = { fg = colors.cyan_neon, bg = colors.bg_surface, gui = "bold" } } 
      },
      lualine_z = {
        -- Usar dourado neon puro no AR (Armor) para contraste total
        { dynamic_armor, color = { fg = colors.text_gold, bg = colors.bg_surface, gui = "bold" }, padding = { left = 1, right = 1 } },
        { dynamic_health, color = health_color, padding = { left = 0, right = 1 } },
        { doomguy_face, color = { fg = colors.text_gold, bg = colors.orange, gui = "bold" }, padding = { left = 0, right = 1 } }
      }
    }
  }
end

return M
