#!/usr/bin/env bash
#
# Install typical brew packages.

BREW_SOURCE_SCRIPT='https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh'
SCRIPT_NAME=$0

BREW_PACKAGES=(
  'mitmproxy'
  'lulu'
  'xcode'
  'highlight'
  'xclip'
  'ranger'
  'dos2unix'
  'wget'
  'eclipse-java'
  'scala@2.12'
  'ipython'
)

log() {
  echo "$(date): $SCRIPT_NAME: $@" 1>&2
}

init() {
  if ! which brew -q; then
    log "brew could not be found; installing from source"
    /bin/bash -c "$(curl -fsSL $BREW_SOURCE_SCRIPT)"
  fi
}

init
brew install "${BREW_PACKAGES[@]}"
