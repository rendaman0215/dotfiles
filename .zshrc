# export PATH=$PATH:/Users/rendaman/.nodebrew/current/bin

# tmux起動
if command -v tmux>/dev/null; then
         [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi


# シェルの補完
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
compinit -u

# シェルのカラーリング
PROMPT='
%*: %c 
%F{magenta}%B%n%b@localhost%F{blue}%#%f '

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ls='ls -FG'
alias ll='ls -alFG'

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
#export KUBECONFIG=/Users/rendaman/.kube/config
#alias k='kubectl'
#alias kg='kubectl get'
#alias kd='kubectl describe'
#alias krm='kubectl delete'
