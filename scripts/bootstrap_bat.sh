#!/bin/bash

# Downloads and sets Catppuccin as the default theme for bat
# See https://github.com/catppuccin/bat?tab=readme-ov-file#usage

THEMEDIR="$HOME/.config/bat/themes/"
if [[ ! -d $THEMEDIR ]]; then
  mkdir -p $THEMEDIR
fi
curl --output-dir "$THEMEDIR" -OL "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme"
curl --output-dir "$THEMEDIR" -OL "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme"

BATCONF="$HOME/.config/bat/config"
echo "--theme=Catppuccin%20Macchiato" > $BATCONF
