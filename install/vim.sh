#!/bin/sh

[ -x "$(which apt-get)" ] && sudo apt-get install -y vim

[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc_old
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc