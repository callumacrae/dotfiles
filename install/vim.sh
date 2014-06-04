#!/bin/sh

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

[ -x "$(which apt-get)" ] && sudo apt-get install -y vim

[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc_old
ln -s ${DOTFILES}/vim/vimrc ~/.vimrc