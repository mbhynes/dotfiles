#!/usr/bin/env bash
#
# Install zshell packages.

SCRIPT_NAME=$0

ANTIGEN_ROOT=$HOME/.antigen

log() {
  echo "$(date): $SCRIPT_NAME: $@" 1>&2
}

init() {
  if [ ! -d "$ANTIGEN_ROOT" ]; then
    mkdir -p "$ANTIGEN_ROOT"
    curl -L git.io/antigen > "$ANTIGEN_ROOT/antigen.zsh"
  fi
}

fzf_keybindings() {
  brew install fzf
  /usr/local/opt/fzf/install
}

init
