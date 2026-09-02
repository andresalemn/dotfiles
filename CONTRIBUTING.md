# Contributing

Thanks for wanting to contribute! Here's how to add your configs and scripts to this repo.

---

## Adding Your Personal Folder

1. Create a folder under `people/` named after your username:
   ```
   people/<your-username>/
   ```
2. Inside your personal folder, add config sub-folders named after the tool they belong to. For example:
   ```
   people/<your-username>/
   ├── wezterm/
   ├── starship/
   └── tmux/
   ```
   The sub-folder name should match the tool name exactly — this makes it easy for others to find configs for a specific tool across all contributors.

---

## Adding Scripts

1. Pick the right category folder under `scripts/`:
   - `scripts/system/` — OS-level helpers (disk cleanup, process management, etc.)
   - `scripts/dev/` — Development workflow tools (git helpers, language version managers, etc.)
   - `scripts/network/` — Networking utilities (VPN toggles, port checks, DNS flush, etc.)
   - `scripts/media/` — Audio/video/image processing scripts
   - `scripts/fun/` — Anything silly, decorative, or just for fun

2. Name your script using the `verb-noun.sh` convention (lowercase, hyphen-separated), for example:
   - `clean-cache.sh`
   - `check-ports.sh`
   - `resize-images.sh`

3. Start every script with a header comment block:
   ```bash
   #!/usr/bin/env bash
   # Purpose:  <one-line description of what the script does>
   # Usage:    <how to run it, including any arguments>
   # Author:   <your-username>
   ```

4. After adding your script, add a row for it in [`scripts/README.md`](scripts/README.md) following the `name | category | description | author` format.

---

## Current Status

> **Note:** This repository currently contains structure only — no install scripts, actual config files, or utility scripts have been added yet. Those will be contributed in a later phase. For now, feel free to set up your `people/<your-username>/` folder and stub out any scripts you plan to add.
