export FZF_BASE='/usr/local/bin/fzf'

get_brew_path() { bin_name="$1"; path_folder="${2:-$bin_name}"
  find /usr/local/Cellar/$bin_name* -name $bin_name -type f -o -type l \
  | sort -h \
  | tail -n 1 \
  | xargs dirname
}

# vim path override; if a brew version has been installed, prefer this
export VIM_PATH=$(get_brew_path vim)
if [ -n "$VIM_PATH" ]; then
  export PATH=$VIM_PATH:$PATH
fi

# python path override
export PYTHON_PATH=$(get_brew_path python@3)
if [ -n "$PYTHON_PATH" ]; then
  export PATH=$PYTHON_PATH:$PATH
fi

# scala path override
export SCALA_PATH=$(get_brew_path scala)
if [ -n "$SCALA_PATH" ]; then
  export PATH=$PATH:$SCALA_PATH
fi

# google cloud sdk
export GCLOUD_PATH="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [ -d "$GCLOUD_PATH" ]; then
 source "$GCLOUD_PATH/path.zsh.inc"
 source "$GCLOUD_PATH/completion.zsh.inc"
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

# source fzf history search keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ==========================================================================
# Google Cloud SDK fzf helper functions
# ==========================================================================
[ -f ~/.gcloud-fzf.zsh ] && source ~/.gcloud-fzf.zsh
