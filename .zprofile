# ① 元の stdin を FD 3 に待避
exec 3<&0
# ② シェル自身の stdin を /dev/null へ
exec 0</dev/null
export ZSH_STDIN_LOCK_FD=3   # 後段で使うため変数に FD 番号を残す

source ~/.zshrc
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
source ~/bin/hello_rendaman.sh

# SSH settings
export PATH=/usr/local/opt/openssl/bin:$PATH

# Set PATH, MANPATH, etc., for Homebrew.
BREW=`which brew`
eval "$($BREW shellenv)"

if [[ -n $ZSH_STDIN_LOCK_FD ]]; then
  exec 0<&$ZSH_STDIN_LOCK_FD   # 退避していた FD を stdin に戻す
  exec {ZSH_STDIN_LOCK_FD}<&-  # 退避 FD を閉じる
  unset ZSH_STDIN_LOCK_FD
fi
