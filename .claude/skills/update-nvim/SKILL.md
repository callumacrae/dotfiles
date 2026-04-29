---
name: update-nvim
description: Update Neovim and its vim-plug plugins. Runs `brew upgrade neovim`, pre-cleans known vim-plug failure modes, runs `:PlugUpdate` headlessly, verifies nvim still starts cleanly, and reports what changed. Use when the user asks to update nvim, update plugins, or run PlugUpdate.
---

# Update Neovim and plugins

Run the steps below in order. Report progress concisely between major steps.

The user's nvim config is in `~/.dotfiles/vim/` and uses vim-plug. Plugins live in `~/.local/share/nvim/plugged/`.

## 1. Capture baseline

In parallel:
- `nvim --version | head -1` — current nvim version
- `brew info --json=v2 neovim | python3 -c "import json,sys; d=json.load(sys.stdin)['formulae'][0]; print('stable:', d['versions']['stable']); print('installed:', [v['version'] for v in d['installed']])"` — see whether brew has a newer version
- Snapshot pre-update plugin SHAs so we can diff at the end:
  ```sh
  cd ~/.local/share/nvim/plugged && for d in */; do
    [ -d "$d/.git" ] && echo "${d%/} $(git -C "$d" rev-parse --short HEAD)"
  done > /tmp/plug-pre.txt
  ```

## 2. Update nvim itself

If brew shows a newer stable version than what's installed, run `brew upgrade neovim`. Otherwise skip and say so. **Don't** run `brew update` first — too slow; the user can refresh formula info themselves if they need to.

## 3. Pre-clean known vim-plug failure modes

vim-plug aborts a plugin's update when an untracked working-tree file would be overwritten by `git pull`. The recurring offender is auto-generated `doc/tags`. Clear them before `:PlugUpdate`:

```sh
cd ~/.local/share/nvim/plugged && for d in */; do
  if [ -f "$d/doc/tags" ] && [ -d "$d/.git" ]; then
    if git -C "$d" status --porcelain doc/tags 2>/dev/null | grep -q "^??"; then
      rm "$d/doc/tags"
    fi
  fi
done
```

## 4. Update vim-plug and the plugins

Run headlessly:
```sh
nvim --headless '+PlugUpgrade' '+qa' 2>&1
nvim --headless '+PlugUpdate --sync' '+qa' 2>&1
```

The `--sync` flag is required — without it, `+qa` exits before vim-plug finishes pulling.

If any plugin fails to update for an unanticipated reason, **stop and report to the user** rather than trying to force-resolve. Plugin failures often signal real upstream changes worth surfacing.

## 5. Clean orphaned plugin directories

`:PlugClean!` skips the confirmation prompt:
```sh
nvim --headless '+PlugClean!' '+qa' 2>&1
```

## 6. Regenerate helptags and verify clean startup

In parallel:
- `nvim --headless '+helptags ALL' '+qa' 2>&1`
- `nvim --headless '+qa' 2>&1` — captures any deprecation warnings or load-time errors

The second command is the verification step. **Anything that prints to stderr here is something the user wants to see** — upstream APIs changing, plugins emitting deprecation warnings, syntax errors in the user's config. Don't filter or hide it.

## 7. Report

Summarize in this format:

- **nvim**: `0.11.1 → 0.12.2` (or "already on 0.12.2")
- **Plugins updated**: list each one that moved, with old → new short SHA. Compute by diffing pre/post snapshots:
  ```sh
  cd ~/.local/share/nvim/plugged && for d in */; do
    [ -d "$d/.git" ] && echo "${d%/} $(git -C "$d" rev-parse --short HEAD)"
  done > /tmp/plug-post.txt
  diff /tmp/plug-pre.txt /tmp/plug-post.txt
  ```
- **Plugins removed**: anything `:PlugClean!` deleted
- **Startup warnings/errors**: anything from step 6's verification run

## Boundaries

Don't touch in this skill:
- LSP server binaries (npm/brew packages) — separate concern
- The user's dotfiles repo — never auto-commit; the user reviews and commits manually if any config changes are needed
- nvim plugins NOT managed by vim-plug — none today, but if treesitter or similar gets added later, that's separate

## When something breaks

If startup verification (step 6) surfaces new errors that look config-related (not just deprecation warnings):
1. Don't try to fix in-flight without asking — diagnosing requires the user's input on intent
2. Note the error verbatim in the report
3. Offer to investigate as a follow-up

For framework-level deprecation warnings (like the `require('lspconfig')` warning in mid-2026), the user generally wants to migrate when prompted. Surface clearly but don't auto-migrate.
