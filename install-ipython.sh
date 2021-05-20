#!/usr/bin/env bash

brew install ipython

IPYTHON_CONFIG="$HOME/.ipython/profile_default/ipython_config.py"

if [ ! -e "$IPYTHON_CONFIG" ]; then
  cat <<<eof
c.TerminalInteractiveShell.editing_mode = 'vi'
  eof > "$IPYTHON_CONFIG"
fi
