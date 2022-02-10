#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

if [[ `uname` == 'Darwin' ]]; then
	brew install tmux
fi

# Set up config files
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux_old.conf
ln -s ${DOTFILES}/tmux/tmux.conf ~/.tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

