# ---- Zinit Bootstrap ----
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "${ZINIT_HOME:h}" \
  && git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

# ---- Plugins (turbo-loaded after prompt) ----
# Order matters: zsh-completions adds to fpath, then compinit scans it
zinit ice wait'0' lucid
zinit light zsh-users/zsh-completions
# compinit -C skips the rescan; rebuild the dump once a day so new completions appear
_zdots_compinit() {
  autoload -Uz compinit
  local dump="${ZDOTDIR:-$HOME}/.zcompdump"
  local -a stale=($dump(N.mh+24))  # glob qualifiers don't expand inside [[ ]]
  if [[ -f $dump && ${#stale} -eq 0 ]]; then compinit -C; else compinit; touch "$dump"; zcompile "$dump"; fi
  unfunction _zdots_compinit
}
zinit ice wait'0' lucid atinit"_zdots_compinit; zicdreplay -q"
zinit light Aloxaf/fzf-tab

# ---- zoxide ----
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
