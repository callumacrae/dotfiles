# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles for macOS (and secondarily apt-based Linux). Configs live here and are symlinked into `$HOME` by the install scripts; nothing is generated, the repo IS the source of truth.

## Common commands

- `~/.dotfiles/install/install.sh` — full bootstrap. Sources every `install/*.sh` in order and then runs `make`. Individual scripts (`install/zsh.sh`, `install/vim.sh`, etc.) are safe to re-run on their own when only one stack needs reinstalling; they each move any pre-existing target file aside to `*_old` before symlinking.
- `make` — builds the two Swift tmux status helpers (`tmux/status/next-event-2`, `tmux/status/audio-status-2`). Both binaries are gitignored and must be rebuilt after pulling Swift changes. Targets: `build-tmux-next-event`, `build-tmux-audio-status`.
- `reload` (zsh alias) — re-sources `~/.zshrc` after editing any zsh file.

## Architecture

### Install layer (`install/`)
`install.sh` sources sibling scripts in a fixed order: `packages → git → zsh → node → vim → irssi → htop → misc`, then runs `make`. Each script is platform-aware via `which brew` / `which apt-get` guards and uses `[[ -z $DOTFILES ]] && export DOTFILES=...` so it works both standalone and when sourced. The pattern for every config is: move existing dotfile to `*_old`, then `ln -s` from this repo into `$HOME` (or `~/Library/...` for macOS app configs).

The `apt-get` branches are legacy — they haven't been exercised in years and likely don't work as-is. Treat macOS/Homebrew as the supported path; the Linux paths are kept around for reference, not relied on.

### Shell layer (`zsh/`)
`zshrc` loops over `~/.dotfiles/zsh/*.zsh{rc,}` and sources every match alphabetically, **then** sources Prezto. Order matters: `node.zshrc` must run before Prezto. Adding a new shell config file just means dropping a `*.zsh` or `*.zshrc` into `zsh/` — no manual wiring.

`zsh/git.zsh` aliases `git` to `hub` when available and defines the `g`/`gca`/`ghn`/`ghpr` functions plus fzf completion hooks. The `ghn`/`ghpr` flows shell out to scripts in `zsh/git_scripts/` (GitHub notifications picker and PR picker, both rendered via `fzf`).

`~/.localrc` is sourced last for machine-local secrets (gitignored, never committed).

### Editor layer (`vim/`)
- `vimrc-common` — settings shared between vim and neovim.
- `vimrc` — sources `vimrc-common`, adds vim-only bits.
- `config/init.vim` — neovim entrypoint: sources `~/.vimrc`, declares vim-plug plugins, then auto-sources every `*.vim` and `*.lua` under `config/plugin-config/`. To add a plugin's config, drop a new file into `plugin-config/` — it'll be picked up on next launch.
- `ideavimrc` — JetBrains IdeaVim config.
- `.luarc.json` (repo root) — lua-language-server workspace library list pointing at the user's installed nvim plugins so the LSP resolves plugin Lua APIs while editing files in this repo.

### tmux layer (`tmux/`)
`tmux.conf` sources `tmux/config/vim.tmux` and `tmux/config/status.tmux`, then loads tpm plugins. The status bar shells out to scripts in `tmux/status/`; the `-2.swift` ones are compiled binaries (see `make` above). `.sh`/`.py`/`.scpt`/`.awk` siblings are interpreted at runtime.

### Misc app configs (`misc/`)
`install/misc.sh` symlinks `misc/BetterTouchTool` → `~/Library/Application Support/BetterTouchTool`, `misc/karabiner` → `~/.config/karabiner`, and `misc/rectangle.plist` → `~/Library/Preferences/com.knollsoft.Rectangle.plist`. **BetterTouchTool's `btt_data_store.*` SQLite files churn constantly** as the app rewrites them on version bumps — expect them to show up in `git status` after every BTT release. Only commit them when intentionally syncing BTT changes.

### Global git
`install/git.sh` symlinks `misc/gitignore_global` to `~/.gitignore_global` and registers it via `git config --global core.excludesfile`. Edit that file (not per-repo `.gitignore`s) for cross-machine ignores.

## Conventions

- Indentation: 2-space, LF line endings, trailing whitespace trimmed (enforced by `.editorconfig`).
- When adding a new install step, follow the existing pattern: guard with `[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"`, branch on `which brew` / `which apt-get`, move the existing target to `*_old` before symlinking, and add a `.` source line to `install/install.sh`.
- Don't add new top-level dotfile entries by hand into `$HOME` — go through an install script so the setup stays reproducible on a fresh machine.
