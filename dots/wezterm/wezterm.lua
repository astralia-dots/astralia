local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- X201's Ironlake GPU only has OpenGL 2.1, so render on the CPU
config.front_end = "Software"

config.font = wezterm.font("ComicShannsMono Nerd Font Mono")
config.font_size = 15

config.window_background_opacity = 0.7
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- same palette as foot.ini
config.colors = {
  background = "#000000",
  foreground = "#F0ECF9",
  cursor_bg = "#F0ECF9",
  cursor_fg = "#0A0614",
  cursor_border = "#F0ECF9",
  selection_fg = "#AB9DC8",
  selection_bg = "#1D113B",
  ansi = { "#0A0614", "#ff6b6b", "#a8e6cf", "#DBAA24", "#806FBE", "#9B57F4", "#806FBE", "#F0ECF9" },
  brights = { "#1D113B", "#ff8e8e", "#c3f0d8", "#DBAA24", "#CE8AFF", "#806FBE", "#AB9DC8", "#F0ECF9" },
}

return config
