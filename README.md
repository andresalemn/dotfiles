# dotfiles

A shared repository for terminal configurations and utility scripts. Configs are organized per-person under `people/` so each contributor keeps their own setup self-contained, while reusable utility scripts live under `scripts/` sorted by category — making it easy to browse, borrow, and contribute regardless of whose machine you're on.

## Structure

| Folder | Purpose |
|--------|---------|
| `people/` | One sub-folder per contributor (e.g. `people/alice/`). Each person's folder holds their own dotfiles and configs, organized by tool name (e.g. `wezterm/`, `starship/`, `tmux/`). |
| `scripts/` | Shared utility scripts organized by category: `system/`, `dev/`, `network/`, `media/`, and `fun/`. See [`scripts/README.md`](scripts/README.md) for the full index. |
| `docs/` | Guides and documentation. See [`docs/BEGINNERS_GUIDE.md`](docs/BEGINNERS_GUIDE.md) for a beginner-friendly overview of Linux terminals and tools. |

## Contributors

| Name | Setup Highlights | Folder |
|------|-----------------|--------|
| alemaniaco | WezTerm + Starship (Monokai dark purple palette, contextual ROS 2 workspace module, battery status) | [`people/alemaniaco/`](people/alemaniaco/) |

## Adding Your Own Stuff

See [CONTRIBUTING.md](CONTRIBUTING.md) for step-by-step instructions on how to add your personal folder and contribute scripts.
