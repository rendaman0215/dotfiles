#------------------------------
# zplug
#-----------------------------
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
-
zplug "b-ryan/powerline-shell"
zplug 'zsh-users/zsh-syntax-highlighting'

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in ${precmd_functions[@]}; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load

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

# 自動 change directory
setopt auto_cd

# ------------------------------
# PATH Settings
# ------------------------------
export PATH="/usr/local/Cellar/go@1.13/1.13.15/libexec/bin:$PATH"

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
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # 補完候補に色を付ける

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ls='ls -FG'
alias ll='ls -alFG'


# ------------------------------
# Other Settings
# ------------------------------
# cd時にls
function chpwd() { ls }

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

# oracle
export ORACLE_HOME=/opt/oracle/instantclient_12_2/
export PKG_CONFIG_PATH=${ORACLE_HOME}pkgconfig/
export LD_LIBRARY_PATH=$ORACLE_HOME

# terraform
alias tf='terraform'
alias tfa='terraform apply'
alias tfc='terraform console'
alias tfd='terraform destroy'
alias tff='terraform fmt'
alias tfg='terraform graph'
alias tfim='terraform import'
alias tfin='terraform init'
alias tfo='terraform output'
alias tfp='terraform plan'
alias tfpr='terraform providers'
alias tfr='terraform refresh'
alias tfsh='terraform show'
alias tft='terraform taint'
alias tfut='terraform untaint'
alias tfv='terraform validate'
alias tfw='terraform workspace'
alias tfs='terraform state'
alias tffu='terraform force-unlock'
alias tfwst='terraform workspace select'
alias tfwsw='terraform workspace show'
alias tfssw='terraform state show'
alias tfwde='terraform workspace delete'
alias tfwls='terraform workspace list'
alias tfsls='terraform state list'
alias tfwnw='terraform workspace new'
alias tfsmv='terraform state mv'
alias tfspl='terraform state pull'
alias tfsph='terraform state push'
alias tfsrm='terraform state rm'
alias tfay='terraform apply -auto-approve'
alias tfdy='terraform destroy -auto-approve'
alias tfinu='terraform init -upgrade'
alias tfpde='terraform plan --destroy'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rendaman/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rendaman/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rendaman/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rendaman/google-cloud-sdk/completion.zsh.inc'; fi
