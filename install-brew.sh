#!/usr/bin/env bash
#
# Install typical brew packages.

SCRIPT_NAME=$0

BREW_SOURCE_SCRIPT='https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh'

BREW_PACKAGES=(
  'gpg'
  'mitmproxy'
  'lulu'
  'highlight'
  'tmux'
  'xclip'
  'ranger'
  'dos2unix'
  'wget'
  'openjdk'
  'scala@2.12'
  'ipython'
  'fzf'
  'z'
  'ctags'
  '1password-cli'
  'cmake'
  'python'
  'vim'
  'mono'
  'go'
  'nodejs'
  'ffmpeg'
  'gifsicle'
)

log() {
  echo "$(date): $SCRIPT_NAME: $@" 1>&2
}

init() {
  if which brew > /dev/null; then
    log "brew already installed; skipping"
  else
    log "brew could not be found; installing from source"
    /bin/bash -c "$(curl -fsSL $BREW_SOURCE_SCRIPT)"
  fi
  brew analytics off
}

init
brew install "${BREW_PACKAGES[@]}"
