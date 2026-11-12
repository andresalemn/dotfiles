# alemaniaco — Setup Guide

My terminal setup: WezTerm + Starship, dark purple palette (Monokai-vivid-inspired).

**Contents**

1. [Prerequisites](#prerequisites)
2. [One-Time Install (Links & Shell Setup)](#one-time-install-links--shell-setup)
   - [Linux / macOS](#linux--macos-symlinks) · [Bash OSC 7 snippet](#bash-report-the-current-folder-to-wezterm-osc-7) · [Windows](#windows-symlinks--powershell)
3. [Windows + WSL](#windows--wsl-wezterm-on-windows-shell-in-wsl) — WezTerm on Windows, shell in WSL
4. [Linux vs Windows Notes](#linux-vs-windows-notes)
5. [Troubleshooting](#troubleshooting)
6. Reference: [Custom Modules](#custom-modules) · [Seeing Changes](#seeing-changes) · [Finding Nerd Font Icons](#finding-nerd-font-icons)

---

## Prerequisites

Make sure these are installed before linking:

### Linux
```bash
# Starship
curl -sS https://starship.rs/install.sh | sh

# JetBrainsMono Nerd Font (required for icons in the prompt)
mkdir -p ~/.local/share/fonts
# Download JetBrainsMono.zip from https://www.nerdfonts.com/font-downloads, unzip it, then:
# (wezterm.lua uses the "NL" variant — no ligatures — whose files are JetBrainsMonoNLNerdFont-*.ttf)
cp JetBrainsMonoNLNerdFont*.ttf ~/.local/share/fonts/
fc-cache -fv
fc-list | grep -q "JetBrainsMonoNL Nerd Font" && echo "Font OK"   # should print "Font OK"

# WezTerm — install from https://wezfurlong.org/wezterm/installation/linux/
```

### Windows
```powershell
# Starship (via winget)
winget install Starship.Starship

# JetBrainsMono Nerd Font
# Download JetBrainsMono.zip from https://www.nerdfonts.com/font-downloads, extract it,
# and install the JetBrainsMonoNLNerdFont-*.ttf files (the "NL" ones are what wezterm.lua uses).

# WezTerm
# Download installer from https://wezfurlong.org/wezterm/installation/windows.html or `winget install wez.wezterm`
```

---

## One-Time Install (Links & Shell Setup)

Run this **once per machine**. The config files stay in this repo — links point back to them.

The repo can be cloned anywhere. Every command below uses a `DOTFILES` variable
for this folder (`people/alemaniaco`), so nothing depends on a specific path.
The easiest way to set it is to `cd` into this folder first, as shown below.

### Linux / macOS (Symlinks)

```bash
# Run from inside people/alemaniaco, wherever the repo lives on this machine
cd path/to/dotfiles/people/alemaniaco   # e.g. ~/sandbox/dotfiles/people/alemaniaco
DOTFILES="$(pwd)"

# Starship
mkdir -p ~/.config
ln -sfn "$DOTFILES/starship/starship.toml" ~/.config/starship.toml

# WezTerm
mkdir -p ~/.config/wezterm
ln -sfn "$DOTFILES/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua

# Shell integration (bash/zsh)
echo 'eval "$(starship init bash)"' >> ~/.bashrc   # for bash
echo 'eval "$(starship init zsh)"' >> ~/.zshrc     # for zsh
exec $SHELL
```

#### Bash: report the current folder to WezTerm (OSC 7)

Add this to `~/.bashrc` **after** the `starship init` line. It tells WezTerm which
folder you're in, so new tabs and splits open there. It's **required for WSL** (see
[Windows + WSL](#windows--wsl-wezterm-on-windows-shell-in-wsl)) and harmless elsewhere.

```bash
# Tell WezTerm the current directory (OSC 7) so new tabs/panes inherit it.
# Hooked via Starship so the last command's exit status is captured first.
__wezterm_osc7() { printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$PWD"; }
starship_precmd_user_func="__wezterm_osc7"
```

> Don't add this to `PROMPT_COMMAND` ahead of Starship. It would overwrite the
> last command's exit status, and the prompt arrow would never show a failed command.

### Windows (Symlinks & PowerShell)

Windows supports real symlinks, the same as Linux. Creating them without Administrator
rights needs **Developer Mode**, which you turn on once:

1. Open **Settings → System → Advanced** (called **For developers** on older Windows 11 builds).
2. Turn on **Developer Mode**.
3. Check it in PowerShell. This should print `1`:
   ```powershell
   (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock').AllowDevelopmentWithoutDevLicense
   ```

Then run this in **PowerShell 7 (`pwsh`)**. Windows PowerShell 5.1 (`powershell.exe`)
may still ask for Administrator rights even with Developer Mode on.

```powershell
# Run from inside people\alemaniaco, wherever the repo lives on this machine
cd path\to\dotfiles\people\alemaniaco   # e.g. $HOME\Documents\sandbox\dotfiles\people\alemaniaco
$Dotfiles = (Get-Location).Path

# Create config folders
New-Item -ItemType Directory -Force -Path "$HOME\.config\wezterm"

# Create symlinks (-Force replaces any existing file at that path; back it up first if it has changes)
New-Item -ItemType SymbolicLink -Force -Path "$HOME\.config\starship.toml"       -Target "$Dotfiles\starship\starship.toml"
New-Item -ItemType SymbolicLink -Force -Path "$HOME\.config\wezterm\wezterm.lua" -Target "$Dotfiles\wezterm\wezterm.lua"

# Check: LinkType should be SymbolicLink, with Target pointing into the repo
Get-Item "$HOME\.config\starship.toml", "$HOME\.config\wezterm\wezterm.lua" | Select-Object FullName, LinkType, Target
```

> Paths shown after `e.g.` are only examples — use wherever you cloned the repo.

#### Fallback: hard links (no Developer Mode)

If you can't enable Developer Mode, hard links work without any special rights, but
only on the same drive as the repo:

```powershell
New-Item -ItemType HardLink -Force -Path "$HOME\.config\starship.toml"       -Target "$Dotfiles\starship\starship.toml"
New-Item -ItemType HardLink -Force -Path "$HOME\.config\wezterm\wezterm.lua" -Target "$Dotfiles\wezterm\wezterm.lua"
```

> **Hard links break easily.** `git pull` and many editors replace a file instead of
> editing it in place. The repo gets the new file, and the linked config silently
> becomes an old, separate copy. After every pull that changes these files, check the
> link and redo it if needed (see [Troubleshooting](#links)). Symlinks don't have this problem.

Then add Starship initialization to your PowerShell `$PROFILE`:

```powershell
# Add to $PROFILE
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
} elseif (Test-Path 'C:\Program Files\starship\bin\starship.exe') {
    Invoke-Expression (&'C:\Program Files\starship\bin\starship.exe' init powershell)
}
```

---

## Windows + WSL (WezTerm on Windows, shell in WSL)

For when the native Linux install isn't available: WezTerm runs on Windows, but every
tab opens a WSL (Ubuntu) shell. You need **both** halves:

| What | Where it lives | How to set it up |
|------|----------------|------------------|
| WezTerm config | **Windows**: `%USERPROFILE%\.config\wezterm\wezterm.lua` | [Windows steps](#windows-symlinks--powershell) (symlink) |
| Starship config + bash | **Inside WSL**: `~/.config/starship.toml`, `~/.bashrc` | [Linux steps](#linux--macos-symlinks) from a clone *inside* WSL, plus the [OSC 7 snippet](#bash-report-the-current-folder-to-wezterm-osc-7) |

`wezterm.lua` already handles this in its `is_windows` block:

- `config.default_domain = "WSL:Ubuntu"` opens WSL by default. PowerShell stays
  available from the launcher (right-click the **+** on the tab bar). If your distro
  isn't called `Ubuntu`, check the name with `wsl -l -v` and change it.
- `wsl_domains[*].default_cwd = "~"` makes the first tab start in the Linux home
  instead of `/mnt/c/Users/<you>`.

Why both matter:

- **`/mnt/c` is slow from WSL.** Windows files are reached through a slow file-sharing
  bridge, and Starship scans the current folder on every prompt. Starting in `/mnt/c`
  is what causes the `Scanning current directory timed out` warning (see
  [Troubleshooting](#troubleshooting)). Keep your projects in the Linux home, not under `/mnt/c`.
- **WezTerm can't see inside WSL.** It doesn't know which folder bash is in unless the
  shell reports it with OSC 7. Without that, new tabs and splits (`CurrentPaneDomain`)
  fall back to the Windows folder of `wsl.exe` and open in `/mnt/c/Users/<you>`.
  `default_cwd` only covers the first tab; the OSC 7 snippet covers the rest.

Keep the Windows clone and the WSL clone in sync with git: commit on one side and pull on the other.

---

## Linux vs Windows Notes

- **Default Shell**:
  - **Linux/macOS**: WezTerm defaults to your user's `$SHELL` (bash/zsh).
  - **Windows**: WezTerm defaults to `cmd.exe`. `wezterm.lua` sets `config.default_prog = { "powershell.exe" }` for Windows so Starship loads in local tabs. With `default_domain = "WSL:Ubuntu"`, the default tab is WSL instead (see above).
- **Link Privileges**:
  - **Linux**: Standard symlinks (`ln -sfn`) work without root elevation.
  - **Windows**: Symlinks work without Administrator rights once Developer Mode is enabled (use PowerShell 7, or `mklink` in `cmd`). Hard links (`New-Item -ItemType HardLink` or `mklink /H`) need no special rights, but only work on the same drive as the repo, and `git pull` or editor saves can quietly break them.
- **Compositor (Linux)**: Running GNOME, so `window_background_opacity` in WezTerm works out of the box — no extra setup needed.

---

## Troubleshooting

### Prompt & directories

**`[WARN] (starship::context): Scanning current directory timed out`**
Starship gave up scanning the current folder (default limit: 30 ms). This is usually a
cold start or a slow folder such as `/mnt/c` in WSL or a network drive.
- `starship.toml` sets `scan_timeout = 100`. Raise it to `200` if it still happens.
- In WSL, the real fix is to start in `~`, not `/mnt/c` (see [Windows + WSL](#windows--wsl-wezterm-on-windows-shell-in-wsl)).
- Run `starship timings` in the slow folder to see which module is slow.

**New WezTerm tabs/splits open in `/mnt/c/Users/<you>` (WSL)**
bash isn't reporting its folder to WezTerm. Add the [OSC 7 snippet](#bash-report-the-current-folder-to-wezterm-osc-7)
to `~/.bashrc`, then open a **new window** (existing tabs keep the old `.bashrc`).

### Links

**Prompt suddenly looks like the default Starship prompt**
`~/.config/starship.toml` is probably a broken symlink, for example after renaming or
moving the repo folder. Starship falls back to its defaults without any warning. Check and relink:
```bash
ls -la ~/.config/starship.toml      # does the target still exist?
cd path/to/dotfiles/people/alemaniaco && ln -sfn "$(pwd)/starship/starship.toml" ~/.config/starship.toml
```
The same applies to `~/.config/wezterm/wezterm.lua` on native Linux.

**Windows config changes don't match the repo**
The config is probably a plain copy instead of a link. Check in PowerShell:
```powershell
Get-Item "$HOME\.config\starship.toml", "$HOME\.config\wezterm\wezterm.lua" | Select-Object FullName, LinkType, Target
```
- `LinkType` is `SymbolicLink`: it's linked. Make sure `Target` still exists (moving or renaming the repo breaks the link).
- `LinkType` is empty: it's a plain file. Either it was never linked, or it was a hard link
  that broke after a `git pull` or an editor save. To tell those apart,
  `fsutil hardlink list "$HOME\.config\wezterm\wezterm.lua"` shows two paths for a working
  hard link and only one for a plain copy.

To fix it, copy any changes made only on Windows into the repo first, then re-run the
[Windows symlink commands](#windows-symlinks--powershell).

### Fonts & WezTerm

**Icons render as boxes in WezTerm**
Make sure `JetBrainsMonoNL Nerd Font` is installed (see [Prerequisites](#prerequisites)).
Note the **NL**: the regular `JetBrainsMonoNerdFont-*` files are a different family, and
WezTerm will fall back to its built-in font (with a warning) if only those are installed.
Check on Linux with `fc-list | grep "JetBrainsMonoNL Nerd Font"`.

**Icons render as boxes in VS Code's integrated terminal**
VS Code sets its terminal font separately from WezTerm. Add this to VS Code's `settings.json`:
```json
"terminal.integrated.fontFamily": "'JetBrainsMonoNL Nerd Font', 'JetBrains Mono', monospace"
```

**WezTerm config errors**
Open the debug overlay with `CTRL+SHIFT+ALT+L` to see what failed to load.
(It's not the WezTerm default `CTRL+SHIFT+L`, because that key moves to the right pane in this config.)

---

## Custom Modules

Custom contextual modules can be defined in `starship.toml` for specific frameworks or tools.

### ROS 2 (`$custom.ros`)
- **Note**: defined as `[custom.ros]` in `starship.toml`. It only shows if `$custom.ros` is added to the `format` string, and it isn't there yet.
- **Triggers when**: A ROS 2 workspace overlay (`install/setup.bash` or `local_setup.bash`) is explicitly sourced in the active terminal session (detected via `$AMENT_PREFIX_PATH` or `$COLCON_PREFIX_PATH`).
- **Displays**: `󰚩 <ros_distro>` styled within the languages segment.

---

## Seeing Changes

Just edit and save any file in this repo — no commands needed.

| Tool | How it reloads |
|------|----------------|
| **WezTerm** | Reloads automatically on save. You'll see a small notification in the corner. Force-reload anytime with `CTRL+SHIFT+R`. |
| **Starship** | Re-reads config on every new prompt. Just press `Enter` to see the updated prompt. |

---

## Finding Nerd Font Icons

To find matching monochrome symbols (instead of emojis) for custom modules:
1. Visit the [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet).
2. Search for keywords (e.g., `robot`, `chip`, `gear`, `cpu`).
3. Copy the icon glyph or UTF code and paste it into your `starship.toml`.
