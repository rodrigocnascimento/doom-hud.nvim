# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-13

### Added

- Initial release of `doom-hud.nvim`.
- Full colorscheme inspired by the classic DOOM (1993) palette.
- Responsive HUD-style statusline components for `lualine.nvim`:
  - Dynamic health indicator based on diagnostic errors.
  - Armor indicator based on warnings.
  - Ammo counter based on information diagnostics.
  - Doomguy face that reacts to Vim mode and health status.
  - Equipped weapon display (chainsaw, shotgun, plasma, BFG).
- Custom `doom_theme` for lualine with DOOM-inspired colors and transitions.
- Neon contrast colors (`text_white`, `text_yellow`, `text_green`, `text_cyan`, `text_gold`) for maximum HUD readability.
- Project screenshot (`assets/doom_1993_vim.png`) showcasing the theme in action.

### Changed

- Refactored `lualine.lua` to load colors directly from `doom_hud.palette` instead of maintaining a local fallback table.
- Cleaned up trailing whitespace and formatting across lualine components.

### Fixed

- Corrected UTF-8 encoding issues in color definitions and palette files.
- Removed potentially problematic or corrupted characters from HUD strings to prevent `E539` and illegal character errors.
- Fixed module name reference in README (`doom-hud` -> `doom_hud`).
- Resolved race conditions in setup by using `UIEnter` with `defer_fn` for lualine integration.

[1.0.0]: https://github.com/rodrigocnascimento/doom-hud.nvim/releases/tag/v1.0.0
