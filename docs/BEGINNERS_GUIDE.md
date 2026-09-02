# 🚀 Linux Terminal & Customization Guide for Beginners

Welcome! If you are new to Linux or have only used the default terminal out-of-the-box, this guide is for you. 

The terminal is not just a black window for running basic system updates — it is an incredibly customizable workspace. With modern terminal emulators, shell prompts, CLI utilities, and custom scripts, you can build a setup tailored to your exact workflow.

---

## 1. Core Concepts: What's the Difference?

Before diving in, it helps to understand how the pieces fit together:

```
┌─────────────────────────────────────────────────────────────┐
│                      Terminal Emulator                      │
│      (The GUI Window app: WezTerm, Alacritty, Kitty)        │
│ ┌─────────────────────────────────────────────────────────┐ │
│ │                         Shell                           │ │
│ │          (The Command Interpreter: Bash, Zsh, Fish)     │ │
│ │ ┌─────────────────────────────────────────────────────┐ │ │
│ │ │                    Prompt Engine                    │ │ │
│ │ │                 (Starship, Oh-My-Posh)              │ │ │
│ │ └─────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

| Term | What it is | Examples |
|---|---|---|
| **Terminal Emulator** | The graphical window application that renders text and captures keystrokes. | WezTerm, Alacritty, Kitty, Ghostty, GNOME Terminal |
| **Shell** | The interpreter running inside the terminal that executes your commands and scripts. | Bash, Zsh, Fish |
| **Prompt Engine** | A tool that styles the line where you type commands (showing git status, paths, colors). | Starship, Oh-My-Posh |
| **Terminal Multiplexer** | A tool to split terminal windows into panes and keep background sessions alive. | `tmux`, Zellij |

---

## 2. Choosing a Modern Terminal Emulator

Your Linux distro comes with a default terminal (like GNOME Terminal or Konsole). They work fine, but modern alternative emulators offer:
- **GPU Acceleration**: Faster rendering and smooth scrolling.
- **Custom Themes & Transparency**: Full control over fonts, colors, and opacity.
- **Tabs & Pane Splits**: Built-in split windows without relying on mouse menus.
- **Cross-Platform Configs**: Store your configuration as a text file (Lua, TOML, YAML) and sync it across computers.

### Popular Modern Alternatives:
- **WezTerm** *(Lua config)*: Highly feature-rich, supports native split panes, tabs, GPU acceleration, and multiplexing.
- **Alacritty** *(TOML config)*: Ultra-fast, minimal, focused purely on speed and simplicity.
- **Kitty** *(Conf format)*: Fast, GPU-accelerated with native support for viewing images directly in the terminal.
- **Ghostty** *(Key-value config)*: Fast, modern, native platform integration.

---

## 3. Tuning Your Prompt (Making It Look & Feel Great)

By default, Linux prompts are often a simple green text string like `user@hostname:~$`.

Using a prompt engine like **[Starship](https://starship.rs/)**, you can transform your prompt into a rich, contextual status bar that shows:
- 📁 **Current Directory** (truncated neatly)
- 🌿 **Git Branch & Status** (uncommitted changes, stashes, ahead/behind status)
- 🛠️ **Active Tool/Language Versions** (Node.js, Python, Rust, Go, ROS 2)
- ⚡ **Execution Time** for long-running commands

### Powerline Fonts & Nerd Fonts
To display symbols like `` (git), `󰚩` (robot), `` (node), or `🔋` (battery), you need a **Nerd Font** installed (such as *JetBrainsMono Nerd Font* or *FiraCode Nerd Font*).

---

## 4. Modern CLI Productivity Tools

Replacing standard legacy Unix commands with modern, colorful CLI tools can make browsing files and searching code significantly faster:

| Traditional Command | Modern Alternative | Key Features |
|---|---|---|
| `ls` (List files) | `eza` / `lsd` | Colorful output, icons, tree views, git status integration |
| `cat` (View file) | `bat` | Syntax highlighting, line numbers, git diff markers |
| `find` (Search files) | `fd` | Fast, smart case search, ignores `.git` by default |
| `grep` (Search text) | `ripgrep` (`rg`) | Blazing fast search inside project files |
| `cd` (Change directory) | `zoxide` (`z`) | Smart directory jumper that learns your frequent folders |

---

## 5. Custom Scripts & Automation

One of the biggest advantages of Linux is automation. In this repository's `scripts/` directory, you'll find custom helper scripts organized by category (`system/`, `dev/`, `network/`, `media/`, `fun/`).

### Why write custom scripts?
- **Automate repetitive tasks**: Clean temporary files, back up directories, update system packages.
- **Create personal CLI shortcuts**: Chain multiple commands into a single `verb-noun.sh` script.
- **Share setups**: Write modular scripts that your team or friends can use.

### Basic Script Anatomy (`clean-cache.sh` example):
```bash
#!/usr/bin/env bash
# Purpose:  Clean temporary system cache files
# Usage:    ./clean-cache.sh
# Author:   alemaniaco

echo "Cleaning temporary files..."
rm -rf ~/.cache/thumbnails/*
echo "Done!"
```

---

## 6. How to Use This Dotfiles Repo

1. **Browse Configs**: Check out [`people/`](../people/) to see how different contributors configure their terminals.
2. **Borrow Scripts**: Check out [`scripts/`](../scripts/) for reusable utility scripts.
3. **Add Your Own**: Read [`CONTRIBUTING.md`](../CONTRIBUTING.md) to add your own personal folder and scripts!
