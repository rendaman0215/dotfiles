# ------------------------------
# General Settings
# ------------------------------
### Complement ###
autoload -Uz compinit          # 補完機能を有効にする
compinit
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

# すべてのヒストリを表示する
function history-all { history -E 1 }

# シェルの補完
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi


# ------------------------------
# PATH Settings
# ------------------------------
if [ -d ~/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ -d ~/.pyenv ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
fi

if [ -x "`which go`" ]; then
    mkdir -p $HOME/go/
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/go/
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi


# ------------------------------
# Look And Feel Settings
# ------------------------------
# フォーマット
PROMPT='
%*: %c 
%F{magenta}%B%n%b@localhost%F{magenta}%#%f '

### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # 補完候補に色を付ける

# git 関連
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ls='ls -FG'
alias ll='ls -alFG'


# ------------------------------
# Other Settings
# ------------------------------

# kubectl があれば補完をロードする
if [ $commands[kubectl] ]; then
    source <(kubectl completion zsh)
fi

### Aliases ###
#時刻を表示させる
alias history='history -E'
alias vi='vim'

# [docker-compose]
alias dc='docker-compose'

# ghql
function ghql() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      cd ${selected_file}
    fi
  fi
}

# GHQ + PECO をZLEで登録のうえ、キーバインド
zle -N ghql
bindkey '^]' ghql

# repo,repos,github をエイリアス
alias repos='ghq list -p | peco'
alias repo='cd $(repos)'
alias github='gh open $(repos)'

# kubectl
export KUBECONFIG=/Users/rendaman/.kube/config
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias krm='kubectl delete'

