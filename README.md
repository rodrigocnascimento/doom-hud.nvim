# doom-hud.nvim

Um colorscheme e HUD responsivo para Neovim inspirado na arte clássica de **DOOM (1993)**.

## 📦 Instalação (lazy.nvim)

```lua
return {
  "rodrigo-cesar/doom-hud.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-lualine/lualine.nvim" },
  config = function()
    require("doom-hud").setup()
  end,
}
```
