# vi keybindings in the shell
bindkey -v
bindkey 'jk' vi-cmd-mode

# readline vi keybindings
set -o vi

# Set up zsh completion system
autoload -U compinit
compinit

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

if [ -f "$HOME/.antigen/antigen.zsh" ]; then 
  source "$HOME/.antigen/antigen.zsh"

  antigen bundle colorize
  antigen bundle colored-man-pages
  antigen bundle git-prompt

  antigen bundle Aloxaf/fzf-tab
  antigen bundle mbhynes/fzf-gcloud --branch=main
fi

export PS1="%F{red}%n%F{white}@%F{yellow}%m:%F{green}%1~%f$ "

# # Use https://geoff.greer.fm/lscolors/ to reconfigure this
export CLICOLOR=1
export LSCOLORS='ahfxcxdxbxegedabagacad'

# Source fzf history search keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# google cloud sdk
export GCLOUD_PATH="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [ -d "$GCLOUD_PATH" ]; then
 source "$GCLOUD_PATH/path.zsh.inc"
 source "$GCLOUD_PATH/completion.zsh.inc"
fi

antigen apply

alias x='open -a "MPlayer OSX Extended.app"'
# display color escape characters as colours in less (e.g. jq -C [file] | less -R)
alias less='less -R'

POSTGRESQL_PATH="/usr/local/opt/postgresql/bin"
if [ -d "$POSTGRESQL_PATH" ]; then
  export PATH=$PATH:$POSTGRESQL_PATH
fi
export PATH=$PATH:$HOME/bin
