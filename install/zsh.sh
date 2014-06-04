#!/bin/sh

[ -x "$(which apt-get)" ] && sudo apt-get install -y zsh
chmod +x zsh.zsh
./zsh.zsh