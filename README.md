## homebrew

### install homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### verify homebrew
```sh
brew --version
```

## Iterm2
```sh
brew install --cask iterm2
```

## oh-my-zsh

### install
```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### powerlevel10k
```sh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
open ~/.zshrc
```

- edit ZSH_THEME on row 9
```
ZSH_THEME="powerlevel10k/powerlevel10k"
```






