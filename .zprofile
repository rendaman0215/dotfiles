# load bashrc
source ~/.zshrc

# bash completion
# source <(kubectl completion zsh)

# SSH settings
export PATH=/usr/local/opt/openssl/bin:$PATH

# GO
export PATH="/usr/local/opt/go@1.13/bin:$PATH"
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

# rbenv settings
eval "$(rbenv init -)"

# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
