#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

if [[ -x "$(which brew)" ]]; then
	brew install irssi
elif [[ -x "$(which apt-get)" ]]; then
	sudo apt-get install -y irssi
fi

[ -f ~/.irssi ] && mv ~/.irssi ~/.irssi_old
ln -s ${DOTFILES}/irssi ~/.irssi