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

# kubectl
export KUBECONFIG=/Users/rendaman/.kube/config
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias krm='kubectl delete'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rendaman/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rendaman/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rendaman/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rendaman/google-cloud-sdk/completion.zsh.inc'; fi
