# alemaniaco — Setup Guide

My terminal setup: WezTerm + Starship, dark purple palette (Monokai-vivid-inspired).

---

## Prerequisites

Make sure these are installed before linking:

```bash
# Starship
curl -sS https://starship.rs/install.sh | sh

# JetBrainsMono Nerd Font (required for icons in the prompt)
mkdir -p ~/.local/share/fonts
# Download from https://www.nerdfonts.com/font-downloads, then:
cp JetBrainsMonoNerdFont*.ttf ~/.local/share/fonts/
fc-cache -fv

# WezTerm — install from https://wezfurlong.org/wezterm/installation/linux/
```

---

## One-Time Install (Symlinks)

Run this **once**. The config files stay in this repo — the symlinks just point to them.

```bash
# Starship
ln -sf ~/Sandbox/dotfiles/people/alemaniaco/starship/starship.toml \
        ~/.config/starship.toml

# WezTerm
mkdir -p ~/.config/wezterm
ln -sf ~/Sandbox/dotfiles/people/alemaniaco/wezterm/wezterm.lua \
        ~/.config/wezterm/wezterm.lua
```

Then add Starship to your shell RC (only needed once):

```bash
# bash → add to ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# zsh → add to ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

Reload your shell:

```bash
exec $SHELL
```

### Verify symlinks are set up correctly

```bash
ls -la ~/.config/starship.toml
ls -la ~/.config/wezterm/wezterm.lua
```

Both should point back to `~/Sandbox/dotfiles/people/alemaniaco/...`.

---

## Custom Modules

Custom contextual modules can be defined in `starship.toml` for specific frameworks or tools.

### ROS 2 (`$custom.ros2`)
- **Triggers when**: A ROS 2 workspace overlay (`install/setup.bash` or `local_setup.bash`) is explicitly sourced in the active terminal session (detected via `$AMENT_PREFIX_PATH` or `$COLCON_PREFIX_PATH`).
- **Displays**: `󰚩 <ros_distro>` styled within the languages segment.

---

## Finding Nerd Font Icons

To find matching monochrome symbols (instead of emojis) for custom modules:
1. Visit the [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet).
2. Search for keywords (e.g., `robot`, `chip`, `gear`, `cpu`).
3. Copy the icon glyph or UTF code and paste it into your `starship.toml`.

---

## Seeing Changes

Just edit and save any file in this repo — no commands needed.

| Tool | How it reloads |
|------|----------------|
| **WezTerm** | Reloads automatically on save. You'll see a small notification in the corner. Force-reload anytime with `CTRL+SHIFT+R`. |
| **Starship** | Re-reads config on every new prompt. Just press `Enter` to see the updated prompt. |

---

## Notes

- **VS Code Integrated Terminal**: VS Code manages its own terminal font settings independently of WezTerm. If icons/symbols render as boxes or missing characters in VS Code's embedded terminal, update your VS Code `settings.json`:
  ```json
  "terminal.integrated.fontFamily": "'JetBrainsMonoNL Nerd Font', 'JetBrains Mono', monospace"
  ```
- **Compositor**: Running GNOME, so `window_background_opacity` in WezTerm works out of the box — no extra setup needed.
- **Font**: If icons render as boxes in WezTerm, ensure `JetBrainsMonoNL Nerd Font` is installed.
- **WezTerm errors**: Open the debug overlay with `CTRL+SHIFT+L` to inspect config errors.
