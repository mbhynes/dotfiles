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
  'https://github.com/derekwyatt/vim-scala'
  'https://github.com/tpope/vim-surround'
  'https://github.com/ycm-core/YouCompleteMe.git'
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

install_youcomplete_me() {
  if ! which python3 >/dev/null; then
    log "Error preparing YouCompleteMe installation; could not find python3 in the PATH." 
    return 1
  fi

  cd $VIM_PACKAGE_DIR/YouCompleteMe.git
  git submodule update --init --recursive && python3 install.py --all
  cd -
}

init
for pkg in "${VIM_PACKAGES[@]}"; do
  log $pkg
  upsert_package "$pkg"
done

install_youcomplete_me
