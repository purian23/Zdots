# ---- User Extras ----
# Place any personal aliases, functions, or experimental configs here.
alias engage='make && sudo make install'
alias smi='make && sudo make install'

# ---- Machine-local config (never overwritten by setup.sh) ----
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
