# ---- Lazy-load NVM ----
set -gx NVM_DIR "$HOME/.nvm"

# Put the default node on PATH without loading nvm.sh
set -l v default
set -l hops 0
# Follow alias chains like default -> lts/* -> lts/krypton -> v24.x.y
while test -s "$NVM_DIR/alias/$v"; and test $hops -lt 5
    read v <"$NVM_DIR/alias/$v"
    set hops (math $hops + 1)
end

if test "$v" != default
    set -l pattern (string replace -r '^v' '' -- $v)
    if test "$v" = node; or test "$v" = stable
        set pattern ''
    end
    set -l dirs $NVM_DIR/versions/node/v$pattern*/
    if set -q dirs[1]
        set -l dir (printf '%s\n' $dirs | sort -V | tail -1)
        fish_add_path -gP (string trim -r -c / -- $dir)/bin
    end
end
