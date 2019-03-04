#
# Maintainer: Rafael Kallis <rk@rafaelkallis.com>
#

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# vim keybindings
bindkey -v
alias :q=exit

export TERM="xterm-256color"
export EDITOR=/usr/bin/vim

# chromium
if (( $+commands[chromium] )) then
  export BROWSER=/usr/bin/chromium
fi

# export PATH="$HOME/miniconda3/bin:$PATH"

# pip
if (( $+commands[python] )) then
  export PATH="$(python -c 'import site; print(site.USER_BASE)')/bin:$PATH"
else
  echo "python not installed"
fi

# rust
if (( $+commands[rustup] )) then
  export PATH="$HOME/.cargo/bin:$PATH"
else
  echo "rustup not installed"
fi

# go
if (( $+commands[go] )) then
  export PATH="$(go env GOPATH)/bin:$PATH"
else
  echo "go not installed"
fi

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# nvm
if [[ -a /usr/share/nvm/init-nvm.sh ]]; then
  # nvm setup (AUR install)
  source /usr/share/nvm/init-nvm.sh
elif [[ -d "$HOME/.nvm" ]]; then
  # nvm setup (script install)
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
else
  echo "nvm not installed"
fi

# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"

export PURE_PROMPT_SYMBOL=">"
export PURE_PROMPT_VICMD_SYMBOL="<"
export PURE_GIT_UP_ARROW="↑"
export PURE_GIT_DOWN_ARROW="↓"
