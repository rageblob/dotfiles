#!/bin/bash

# Only applicable for MacOS.
# Run this script from within this folder!
# Creates symlinks between your VSCode settings and the ones in this repo in order to keep them updated

files=('keybindings.json' 'settings.json')
settings_dir="$HOME/Library/Application\ Support/Code/User"

rm $settings_dir/keybindings.json $settings_dir/settings.json
(
  cd ../cfg/VSCode
  for file in $files; do
    ln $file $settings_dir/$file
  done
)