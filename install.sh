#!/usr/bin/env bash
#
# Run each dotfile install script.

SCRIPT_NAME=$0

log() {
  echo "$(date): $SCRIPT_NAME: $@" 1>&2
}

# Install dependencies
./install-brew.sh
./install-zsh.sh
./install-vim.sh
./install-ipython.sh

# Relink dotfiles
DOTFILES=(
  'vimrc'
  'inputrc'
  'tmux.conf'
  'zshrc'
)

for dotfile in "${DOTFILES[@]}"; do
  log "Linking $dotfile in $HOME"
  ln -s -f "$PWD/$dotfile" "$HOME/.$dotfile"
done
