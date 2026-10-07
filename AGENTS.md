# Agents

## Cursor Cloud specific instructions

### Project overview

Zdots is a modular Zsh dotfiles/shell-configuration project. There is no build system, no package manager lockfile, and no test framework. The "application" is `setup.sh`, a Bash script that assembles modular `.zsh` config fragments from `zsh/` into `~/.zshrc`, installs Zinit (plugin manager), and optionally copies `starship.toml`.

### Running setup.sh non-interactively

```bash
ZDOTS_NONINTERACTIVE=1 bash setup.sh
```

This uses prompt defaults and automatically skips `chsh` (which would hang without a TTY). For full "yes to everything" behavior, use `ZDOTS_YES=1` — `chsh` is still skipped when no TTY is detected. Setup never launches a shell itself; it prints `exec zsh -l` instead. Add `ZDOTS_SHELLS=zsh` to skip Fish entirely.

To preview without making changes: `bash setup.sh --dry-run`

### Linting

```bash
shellcheck setup.sh
```

Should produce zero findings (all previous info-level notices have been resolved).

### Testing the generated config

```bash
zsh -c 'source ~/.zshrc; echo "ZSH_VERSION=$ZSH_VERSION"'
```

First run after setup downloads Zinit plugins from GitHub (takes ~15s). Subsequent runs are fast (~57ms).

**Note:** turbo-loaded plugins (`zsh-syntax-highlighting`, `zsh-autosuggestions`) only activate in a real interactive terminal with ZLE. Testing via `zsh -i <<'EOF'` heredoc or `zsh -c` won't trigger them — use the Desktop pane terminal instead.

### Startup benchmark

```bash
zsh -c 'time zsh -i -c exit'
```

### Key paths

| Path | Purpose |
|------|---------|
| `setup.sh` | Main installer script |
| `zsh/*.zsh` | Modular Zsh config fragments |
| `zsh/order.txt` | Module load-order manifest |
| `starship.toml` | Starship prompt config |
| `~/.zshrc` | Generated config (output of setup.sh) |
| `~/.zshrc.local` | Machine-local zsh config, sourced last, never overwritten |
| `~/.local/share/zinit/` | Zinit home + downloaded plugins |
| `~/.config/starship.toml` | Installed Starship config |
| `~/.cache/zdots-setup.log` | Setup log |
