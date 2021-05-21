# load zgen
source "${HOME}/.zgen/zgen.zsh"

# Receate the zgen.zsh init script if it doesn't exist (to reload, delete it)
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/colorize
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/git-prompt
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh themes/arrow

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions

  # generate the init script from plugins above
  zgen save
fi

# vi keybindings in the shell
bindkey -v
bindkey 'jk' vi-cmd-mode

PS1="%F{red}%n%F{white}@%F{yellow}%m:%F{green}%1~%f$ "

# Use https://geoff.greer.fm/lscolors/ to reconfigure this
CLICOLOR=1
LSCOLORS='ahfxcxdxbxegedabagacad'
