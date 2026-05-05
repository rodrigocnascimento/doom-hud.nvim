local M = {}

function M.setup(opts)
  opts = opts or {}
  
  vim.g.colors_name = "doom"
  -- 1. Carrega o motor de destaques
  require("doom_hud.theme").apply()
  
  -- Se o Lualine estiver instalado no ambiente, injeta o HUD automaticamente
  local status_ok, lualine = pcall(require, "lualine")
  if status_ok then
    local config = require("doom_hud.lualine").get_config()
    lualine.setup(config)
  end
end

return M
