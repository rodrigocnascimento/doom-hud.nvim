local M = {}

-- 1. Carga Segura da Paleta
local ok, colors = pcall(require, "doom_hud.palette")
if not ok or type(colors) ~= "table" then 
  colors = {} 
end

local c = {
  orange     = colors.orange     or "#D9896C",
  bg         = colors.bg         or "#1A1A1A",
  bg_surface = colors.bg_surface or "#2D2D2D",
  fg         = colors.fg         or "#F2D0A7",
  blue       = colors.blue       or "#594F57",
  gold       = colors.gold       or "#F2D0A7",
  cyan_neon  = "#00E5FF",
  hp_ok      = "#A6E3A1",
  hp_danger  = "#F38BA8",
  id_red     = "#880000",
  id_yellow  = "#FFFF00",
  
  -- Nossas NOVAS cores neon de contraste total (para as letras)
  text_white  = "#FFFFFF", -- Contraste máximo para o filename e branch
  text_yellow = "#FFFF00", -- O amarelo do logo 'id' Software (para AR e modo)
  text_green  = "#00FF00", -- Verde neon puro para o HP
  text_cyan   = "#00E5FF", -- Ciano neon puro para o AMMO (já estava bom)
  text_gold   = "#FFD700", -- Dourado neon puro para o AR (Armor)
}

-- 2. Sistemas Vitais
local function doomguy_face()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" then return " 😡 "
  elseif mode:match("[vV]") then return " 😎 "
  elseif mode == "R" then return " 💀 "
  else return " 🗿 " end
end

local function dynamic_health()
  local ok_err, errors = pcall(function() return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) end)
  if not ok_err or errors == 0 then return "󰄵 HP: 100%%" end
  return string.format("󰅚 HP: %02d%%%%", math.max(0, 100 - (errors * 15)))
end

local function health_color()
  local ok_err, errors = pcall(function() return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) end)
  if not ok_err or errors == 0 then return { fg = c.hp_ok, gui = "bold" } end
  return { fg = c.hp_danger, gui = "bold" }
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
  normal  = { a = { bg = c.orange, fg = c.bg, gui = "bold" }, b = { bg = c.bg_surface, fg = c.fg }, c = { bg = c.bg, fg = c.fg } },
  insert  = { a = { bg = c.hp_ok, fg = c.bg, gui = "bold" } },
  visual  = { a = { bg = c.blue, fg = c.fg, gui = "bold" } },
  replace = { a = { bg = c.id_red, fg = c.id_yellow, gui = "bold" } },
  command = { a = { bg = c.gold, fg = c.bg, gui = "bold" } },
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
        { function() return " id " end, color = { fg = c.id_yellow, bg = c.id_red, gui = "bold" }, padding = 0 },
        { function() return "▓▒░" end, color = { fg = c.id_red, bg = c.orange }, padding = 0 },
        { "mode", fmt = function(str) return " DOOM:" .. modeFormatter(str) .. " " end, color = { fg = c.id_yellow, bg = c.orange, gui = "bold" }, padding = 0 }
      },
      lualine_b = { 
        { "branch", icon = "󰄛  ", color = { fg = c.text_white, gui = "bold" } }, 
        { "diff", color = { bg = c.bg_surface } }
      },
      lualine_c = { 
        { function() return "▓▒░ " end, color = { fg = c.bg_surface, bg = c.bg }, padding = 0 },
        { function() return "󰀻  DOOM 󰀻 " end, color = { fg = c.text_gold, bg = c.bg, gui = "bold" } },
        -- Usar branco puro no nome do arquivo para contraste máximo
        { "filename", path = 1, color = { fg = c.text_white, bg = c.bg } }
      },
      lualine_x = { 
        { equipped_weapon, color = { fg = c.blue, bg = c.bg, gui = "bold" } },
        { function() return " ░▒▓" end, color = { fg = c.bg_surface, bg = c.bg }, padding = 0 },
      },      
      lualine_y = { 
        -- Munição ciano neon, está ótimo
        { ammo_counter, color = { fg = c.cyan_neon, bg = c.bg_surface, gui = "bold" } } 
      },      
      lualine_z = { 
        -- Usar dourado neon puro no AR (Armor) para contraste total
        { dynamic_armor, color = { fg = c.text_gold, bg = c.bg_surface, gui = "bold" }, padding = { left = 1, right = 1 } },
        { dynamic_health, color = health_color, padding = { left = 0, right = 1 } },
        { doomguy_face, color = { fg = c.text_gold, bg = c.orange, gui = "bold" }, padding = { left = 0, right = 1 } }
      }    
    }
  }
end

return M
