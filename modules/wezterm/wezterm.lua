local wezterm = require("wezterm")
local act = wezterm.action
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Kanagawa Dragon (Gogh)"

config.font_size = 20
config.font = wezterm.font("JetBrains Mono")
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 4
config.enable_wayland = true
config.warn_about_missing_glyphs = false

config.keys = {
  {
    key = "t",
    mods = "SHIFT|ALT",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
}

return config
