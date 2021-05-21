export FZF_BASE='/usr/local/bin/fzf'

# vim path override; if a brew version has been installed, prefer this
export VIM_PATH=$(
  find /usr/local/Cellar/vim -name vim -type f \
  | sort -h \
  | tail -n 1 \
  | xargs dirname \
)
if [ -n "$VIM_PATH" ]; then
  export PATH=$VIM_PATH:$PATH
fi

# python path override
export PYTHON_PATH=$(
  find /usr/local/Cellar/ -name python3 \
  | sort -h \
  | tail -n 1 \
  | xargs dirname \
)
if [ -n "$PYTHON_PATH" ]; then
  export PATH=$PYTHON_PATH:$PATH
fi

# load zgen
source "${HOME}/.zgen/zgen.zsh"

reload_zsh_plugins() {
  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/colorize
  zgen oh-my-zsh plugins/colored-man-pages
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/git-prompt
  zgen oh-my-zsh plugins/sudo

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions

  # generate the init script from plugins above
  zgen save
}

# Regenerate plugins in hte zgen.zsh init script
if ! zgen saved; then
  reload_zsh_plugins
fi

# vi keybindings in the shell
bindkey -v
bindkey 'jk' vi-cmd-mode

export PS1="%F{red}%n%F{white}@%F{yellow}%m:%F{green}%1~%f$ "

# Use https://geoff.greer.fm/lscolors/ to reconfigure this
export CLICOLOR=1
export LSCOLORS='ahfxcxdxbxegedabagacad'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
