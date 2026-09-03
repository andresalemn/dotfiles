local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Cross-platform shell configuration:
-- On Windows, WezTerm defaults to cmd.exe. We set default_prog to PowerShell so Starship loads automatically.
-- On Linux/macOS, leaving default_prog unset allows WezTerm to use the user's $SHELL (bash/zsh).
if wezterm.target_triple:find("windows") then
  config.default_prog = { "powershell.exe" }
end



-- Custom desaturated purple-dark, Monokai-vivid-text palette
config.colors = {
  foreground = "#f8f8f2",
  background = "#221f2b",       -- desaturated dark purple
  cursor_bg = "#f92672",
  cursor_fg = "#221f2b",
  selection_bg = "#3b3752",
  selection_fg = "#f8f8f2",

  ansi = {
    "#2b2735", "#f92672", "#a6e22e", "#e6db74",
    "#78dce8", "#ae81ff", "#66d9ef", "#f8f8f2",
  },
  brights = {
    "#75715e", "#ff6188", "#a9dc76", "#ffd866",
    "#78dce8", "#ab9df2", "#78dce8", "#fcfcfa",
  },

  tab_bar = {
    background = "#1a1723",
    active_tab = { bg_color = "#3b3752", fg_color = "#f8f8f2" },
    inactive_tab = { bg_color = "#1a1723", fg_color = "#75715e" },
  },
}

config.font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Medium" })
config.font_size = 16
config.line_height = 1

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.90
config.window_padding = { left = 10, right = 10, top = 8, bottom = 8 }

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false

config.default_cursor_style = "SteadyBar"
config.scrollback_lines = 8000

-- Keybindings: splits + tab navigation
config.keys = {
  { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Left" },
  { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Right" },
  { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Up" },
  { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Down" },
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
  { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
}

return config