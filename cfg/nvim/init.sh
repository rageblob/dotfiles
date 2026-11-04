#!/bin/bash
# Setup guide
# This config uses telescope-fzf-native, which requires a one time manual build step.
# You need to run this script once before nvim can load properly.

repo="https://github.com/nvim-telescope/telescope-fzf-native.nvim"
libfolder=~/.local/share/nvim/site/pack/plugins/start/telescope-fzf-native.nvim
libfile=$libfolder/build/libfzf.so

if [[ -e $libfile ]]; then
  echo "✅ \"libfzf.so\" is installed. You're all set."
else
  git clone $repo $libfolder
  cd $libfolder
  make
fi
