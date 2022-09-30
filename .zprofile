# load zshrc
if [ -f ~/.zshrc ]; then
	source ~/.zshrc
fi

# SSH settings
export PATH=/usr/local/opt/openssl/bin:$PATH

# Set PATH, MANPATH, etc., for Homebrew.
BREW=`which brew`
eval "$($BREW shellenv)"

