# ---- Lazy-load NVM ----
export NVM_DIR="$HOME/.nvm"

# Put the default node on PATH without loading nvm.sh (no subprocesses).
() {
  local v=default dir hops=0
  local -a dirs
  # Follow alias chains like default -> lts/* -> lts/krypton -> v24.x.y
  while [[ -s "$NVM_DIR/alias/$v" ]] && (( hops++ < 5 )); do
    v="$(<"$NVM_DIR/alias/$v")"
  done
  [[ $v == default ]] && return
  if [[ $v == node || $v == stable ]]; then
    dirs=("$NVM_DIR"/versions/node/v*(N/nOn))
  else
    dirs=("$NVM_DIR"/versions/node/v${v#v}*(N/nOn))
  fi
  dir=${dirs[1]}
  [[ -n $dir && -d $dir/bin ]] && path=("$dir/bin" $path)
}

nvm() {
  unset -f nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
  nvm "$@"
}
