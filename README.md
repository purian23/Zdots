# Zdots

![Zsh Startup](https://img.shields.io/badge/zsh-35ms-brightgreen)
![Fish Startup](https://img.shields.io/badge/fish-8ms-brightgreen)
![License: MIT](https://img.shields.io/badge/license-MIT-blue)

Modular dotfiles for **Zsh** and **Fish**. One repo, both shells configured, switch anytime.

## Features

| | Zsh (~35ms) | Fish (~8ms) |
|---|---|---|
| Autosuggestions | `match_prev_cmd → history → completion` via plugin | Built-in |
| Syntax highlighting | Turbo-loaded plugin | Built-in |
| Completions | fzf-tab + zsh-completions | Built-in |
| Plugins needed | 4 (managed by Zinit) | 0 |
| Config style | Modules assembled into single `.zshrc` | `conf.d/` + `functions/` |

**Shared:** Starship prompt, zoxide, lazy-loaded NVM, compiled `.zshrc` bytecode, `--dry-run` mode, non-interactive/CI support, backup merge flow.

## Install

```bash
git clone https://github.com/purian23/zdots.git ~/.zdots
cd ~/.zdots
./setup.sh          # configures both shells
./setup.sh --dry-run  # preview only
```

Both shells are installed if missing. Switch anytime with `zsh` or `fish`.

## Distro support

Auto-detects: pacman, apt, dnf, zypper, yum, apk, nix-env, xbps-install, emerge, Homebrew.

Tested on Arch, Ubuntu, Fedora 43, Alpine, macOS.

## Environment variables

| Variable | Purpose |
|----------|---------|
| `ZDOTS_SHELLS=zsh\|fish\|zsh,fish` | Only set up these shells, without asking about the others |
| `ZDOTS_YES=1` | Answer yes to all prompts |
| `ZDOTS_NO=1` | Answer no to all prompts |
| `ZDOTS_NONINTERACTIVE=1` | Use defaults, skip `chsh` |
| `ZDOTS_PM=<name>` | Force a package manager |
| `ZDOTS_MERGE=all\|yes\|no` | Control backup merge |
| `ZDOTS_LOGFILE=<path>` | Override log path |

## Machine-local config

`setup.sh` regenerates `~/.zshrc`, so don't edit it by hand. Put per-machine aliases, exports and PATH entries in `~/.zshrc.local`, which the generated `~/.zshrc` sources last. When setup replaces an existing `.zshrc`, it can merge that file's aliases, exports, PATH lines and functions into `~/.zshrc.local`. Re-running setup with no module changes leaves `~/.zshrc` untouched and makes no backup.

For Fish, add your own files to `~/.config/fish/conf.d/`. Setup only overwrites the files Zdots ships.

## Performance

```bash
time zsh -i -c exit    # ~0.035s
time fish -c exit      # ~0.008s
```

Profile Zsh: add `zmodload zsh/zprof` to top of `.zshrc`, run `zprof`.

## VS Code

```json
"terminal.integrated.profiles.linux": {
  "zsh": { "path": "/bin/zsh", "args": ["-l"] },
  "fish": { "path": "/usr/bin/fish", "args": ["-l"] }
},
"terminal.integrated.defaultProfile.linux": "zsh"
```

## Recommended packages

Not auto-installed: `bat`, `eza`, `fzf`, `p7zip`, `starship`, `unrar`, `unzip`, `zoxide`.

## Uninstall

```bash
# Zsh — restore backup
mv ~/.zshrc ~/.zshrc.generated.bak
mv ~/.zshrc.bak.YYYYMMDDHHMM ~/.zshrc

# Fish — remove zdots configs
rm ~/.config/fish/conf.d/{00-options,10-path,20-nvm,30-prompt,40-zoxide,99-extras}.fish
rm ~/.config/fish/functions/nvm.fish

# Remove repo
rm -rf ~/.zdots
```

## Contributing

PRs welcome. Priorities: clarity, speed, portability.
