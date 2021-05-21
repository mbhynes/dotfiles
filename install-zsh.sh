#!/usr/bin/env bash
#
# Install zshell packages.

SCRIPT_NAME=$0

ZGEN_ROOT=$HOME/.zgen

log() {
  echo "$(date): $SCRIPT_NAME: $@" 1>&2
}

init() {
  if [ ! -d "$ZGEN_ROOT" ]; then
    git clone https://github.com/tarjoilija/zgen.git "$ZGEN_ROOT"
  else
    cd "$ZGEN_ROOT"
    git pull origin --ff-only 1>&2 || log "Failed to fast-forward $package_name"
    cd -
  fi
}

fzf_keybindings() {
  brew install fzf
  /usr/local/opt/fzf/install
}

init
