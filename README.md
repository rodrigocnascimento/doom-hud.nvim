# doom-hud.nvim

![Version](https://img.shields.io/github/v/tag/rodrigocnascimento/doom-hud.nvim?label=version)

Um colorscheme e HUD responsivo para Neovim inspirado na arte clássica de **DOOM (1993)**.

![DOOM 1993 Vim Screenshot](assets/doom_1993_vim.png)

## 📦 Instalação (lazy.nvim)

```lua
return {
  "rodrigo-cesar/doom-hud.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-lualine/lualine.nvim" },
  config = function()
    require("doom_hud").setup()
  end,
}
```

## 🎨 Recursos

- Colorscheme inspirado em DOOM com paleta escura
- Integração automática com lualine (opcional)
- Indicadores de vida, armor e munição estilo HUD
- Doomguy face que muda conforme o modo do Vim