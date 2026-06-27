# Login-shell environment setup only.
# Interactive shell setup belongs in ~/.zshrc.

# SSH settings
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# Set PATH, MANPATH, etc., for Homebrew.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
