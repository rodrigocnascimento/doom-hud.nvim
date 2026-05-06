local M = {}
local colors = require("doom_hud.palette")

function M.get_config()
  return {
    options = { theme = "auto", globalstatus = true },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return M
