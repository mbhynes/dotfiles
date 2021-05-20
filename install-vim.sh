#!/usr/bin/env bash
#
# Install vim packages.

SCRIPT_NAME=$0

VIM_PACKAGE_ROOT=$HOME/.vim/pack
VIM_PACKAGE_FOLDER=main

VIM_PACKAGE_DIR="$VIM_PACKAGE_ROOT/$VIM_PACKAGE_FOLDER/start"

VIM_PACKAGES=(
  'https://github.com/preservim/nerdtree'
  'https://github.com/tomtom/tcomment_vim'
)

log() {
  echo "$(date): $SCRIPT_NAME: $@" 1>&2
}

init() {
  mkdir -p "$VIM_PACKAGE_FOLDER"
}

upsert_package() { pkg="$1";
  package_name=$(basename "$pkg")
  package_root="$VIM_PACKAGE_DIR/$package_name" 
  if [ ! -d "$package_root" ]; then
    log "$package_name not installed; installing to $package_root"
    git clone "$pkg" "$package_root" 1>&2
  else
    log "$package_name exists; updating with 'git pull --ff-only'"
    cd "$package_root"
    git pull origin --ff-only 1>&2 || log "Failed to fast-forward $package_name"
    cd -
  fi
}

init
for pkg in "${VIM_PACKAGES[@]}"; do
  log $pkg
  upsert_package "$pkg"
done
