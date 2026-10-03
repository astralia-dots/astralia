-- Sync with ~/astralia-shell/src/render/palette.h
local palette = {
    accent = "#9B57F4",
    accent_alt = "#DBAA24",
}

return {
    {
        "folke/tokyonight.nvim",
        opts = {
            -- Use the terminal's background instead of the colorscheme's
            transparent = true,
            styles = { sidebars = "transparent", floats = "transparent" },
            on_highlights = function(hl)
                hl.WinSeparator = { fg = palette.accent }
                hl.FloatBorder = { fg = palette.accent }
                hl.SnacksPickerBorder = { fg = palette.accent }
                hl.BufferLineIndicatorSelected = { fg = palette.accent }
                hl.SnacksDashboardHeader = { fg = palette.accent }
                hl.SnacksDashboardDesc = { fg = palette.accent }
                hl.SnacksDashboardKey = { fg = palette.accent_alt }
            end,
        },
    },
}
