# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
eval "$(rbenv init -)"
source ~/.bashrc
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH=/usr/local/opt/openssl/bin:$PATH
## alias awscon='ssh -i ~/Desktop/key.pem centos@18.178.37.117'

