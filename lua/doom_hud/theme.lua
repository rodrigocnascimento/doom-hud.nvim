local M = {}
local colors = require("doom_hud.palette")

function M.apply()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "doom"

	local hl = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- Fillchars configuration
	-- Option: uncomment below for DOOM-style HUD borders
	-- vim.opt.fillchars = {
	--   horiz     = "-",  -- horizontal line
	--   horizup   = "+",  -- bottom junction
	--   horizdown = "+",  -- top junction
	--   vert      = "|",  -- vertical line
	--   eob       = " ",  -- hide tildes
	-- }
	vim.opt.fillchars = {
		eob = " ", -- clear tildes at end of file
	}

	-- Editor interface
	hl("Normal", { fg = colors.fg, bg = colors.bg })
	hl("NormalFloat", { fg = colors.fg, bg = colors.bg_surface })
	hl("CursorLine", { bg = colors.bg_select })
	hl("Visual", { bg = colors.bg_select, bold = true })

	-- HUD-style borders and dividers
	hl("LineNr", { fg = colors.muted })
	hl("CursorLineNr", { fg = colors.gold, bold = true })
	hl("WinSeparator", { fg = colors.gold, bg = colors.bg })
	hl("VertSplit", { fg = colors.gold, bg = colors.bg })

	-- Syntax (The Rip & Tear Style)
	hl("Comment", { fg = colors.comment, italic = true })
	hl("Constant", { fg = colors.orange })
	hl("String", { fg = colors.orange, italic = true })
	hl("Number", { fg = colors.gold })
	hl("Boolean", { fg = colors.gold, bold = true })

	hl("Identifier", { fg = colors.fg })
	hl("Function", { fg = colors.red, bold = true })

	hl("Statement", { fg = colors.green, bold = true })
	hl("Keyword", { fg = colors.green, bold = true })
	hl("Conditional", { fg = colors.green, bold = true })
	hl("Repeat", { fg = colors.green, bold = true })
	hl("Operator", { fg = colors.gold })

	hl("PreProc", { fg = colors.red })
	hl("Include", { fg = colors.red })
	hl("Type", { fg = colors.gold })

	-- Treesitter
	hl("@variable", { fg = colors.fg })
	hl("@keyword", { fg = colors.green, bold = true })
	hl("@function", { fg = colors.red, bold = true })
	hl("@string", { fg = colors.orange })
	hl("@number", { fg = colors.gold })
	hl("@operator", { fg = colors.gold })
	hl("@type", { fg = colors.gold })
	hl("@comment", { fg = colors.comment, italic = true })

	-- LSP Diagnostics
	hl("DiagnosticError", { fg = colors.red })
	hl("DiagnosticWarn", { fg = colors.orange })
	hl("DiagnosticInfo", { fg = colors.green })
	hl("DiagnosticHint", { fg = colors.gold })
end

return M