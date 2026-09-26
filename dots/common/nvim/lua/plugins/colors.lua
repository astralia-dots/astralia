-- Astralia palette (keep in sync with ~/astralia-shell/src/render/palette.h)
local palette = {
  accent = "#9B57F4",
  accent_alt = "#DBAA24",
}

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl)
        -- pane / float borders
        hl.WinSeparator = { fg = palette.accent }
        hl.FloatBorder = { fg = palette.accent }
        hl.SnacksPickerBorder = { fg = palette.accent }
        -- bar on the left of the active buffer tab
        hl.BufferLineIndicatorSelected = { fg = palette.accent }
        -- dashboard: ASTRALIA title, command labels, and their keys
        hl.SnacksDashboardHeader = { fg = palette.accent }
        hl.SnacksDashboardDesc = { fg = palette.accent }
        hl.SnacksDashboardKey = { fg = palette.accent_alt }
      end,
    },
  },
}
