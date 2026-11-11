# alemaniaco — Pending Fixes

Small issues found while reviewing the setup. None of them break anything today;
they're here so they can be fixed later. Tick them off (`[x]`) as they're done.

Line numbers were accurate when this was written and may drift as files change.

---

## Starship (`starship/starship.toml`)

- [ ] **Empty dark sliver when no language/battery is shown**
  The arrows around the languages segment (`#2b2735`) are hardcoded in `format`, so
  when none of `$python … $battery` has output, an empty dark sliver is left between
  the git/directory segment and the time. It's hidden today because the battery always
  shows, but it will appear on a desktop or a machine without a battery. This is the same
  bug that was fixed for the git segment.
  *Fix:* use the same trick as the git segment. Put the segment and its arrows in a
  `( … )` group, plus an "else" arrow for when it's empty.

- [ ] **`[custom.ros]` is defined but never shown** (line ~130)
  It isn't in `format`, so it never renders (also mentioned in `SETUP.md`). When adding it:
  - `style` is never used, because the colors are hardcoded inside `format`. Use `($style)` or drop `style`.
  - `when` uses `test`, which only exists in sh/bash. It fails in native Windows
    PowerShell. Add `shell = ["sh"]` or `os = "linux"` if that matters.
  - `when` as a string starts a shell on every prompt. That's fine, but it costs a few ms.

- [ ] **`[custom.no_git]` doesn't work in native Windows PowerShell** (line ~141)
  It runs through `shell = ["sh"]`, which usually isn't available on Windows. Outside a
  repo you'd get a hard color edge instead of the directory → languages arrow.
  WSL/Linux are fine. Only matters if you use Starship in PowerShell directly.

- [ ] **Redundant second `[[battery.display]]` entry** (line ~124)
  The `threshold = 20` entry has the same style and symbols as the top level, so it
  changes nothing. Delete it, or give it an alert color (e.g. `bg:#2b2735 fg:#f92672`)
  so low battery actually stands out.

---

## WezTerm (`wezterm/wezterm.lua`)

- [ ] **`CTRL+SHIFT+K` overrides "clear scrollback"** (line ~74)
  Pane navigation (`ActivatePaneDirection "Up"`) replaced WezTerm's default
  `ClearScrollback`. If you miss it, bind it elsewhere the same way the debug overlay
  was moved, e.g. `CTRL+SHIFT+ALT+K`:
  `{ key = "k", mods = "CTRL|SHIFT|ALT", action = wezterm.action.ClearScrollback "ScrollbackOnly" }`

- [ ] **Two keybindings repeat WezTerm's defaults** (lines ~76–77)
  `CTRL+SHIFT+T` → `SpawnTab "CurrentPaneDomain"` and `CTRL+Tab` → `ActivateTabRelative(1)`
  are already the defaults. They're harmless. Keep them as documentation or delete them.

- [ ] **The tab bar "+" button uses default colors** (line ~45)
  `colors.tab_bar` sets the active and inactive tabs but not `new_tab`, so the **+**
  button doesn't match the palette. Add:
  `new_tab = { bg_color = "#1a1723", fg_color = "#75715e" },`

---

## Docs (`SETUP.md`)

- [ ] **OSC 7 snippet doesn't percent-encode `$PWD`** (line ~90)
  `file://` URLs should encode special characters. Folders with spaces (or `#`, `%`)
  may not carry over to new tabs/splits. Fine as long as project paths have no spaces;
  otherwise encode the path before printing.
