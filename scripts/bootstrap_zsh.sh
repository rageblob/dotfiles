#!/bin/bash

# create zsh config folder if it doesn't exist
# otherwise create a backup
if ! [[ -d "$HOME/.config/zsh" ]]; then
  mkdir -p $HOME/.config/zsh/
else
  mv $HOME/.config/zsh{,.bak}
fi

# link the config files to `~/.config/zsh/`
ln $PWD/cfg/shell/aliases $HOME/.config/zsh/aliases
ln $PWD/cfg/shell/env $HOME/.config/zsh/env
ln $PWD/cfg/shell/zsh_cfg $HOME/.config/zsh/settings
