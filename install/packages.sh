#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

if [[ -x `which apt-get` ]]; then
	sudo apt-get update
	sudo apt-get install -y ack-grep silversearcher-ag autojump fzf
fi

if [[ `uname` == 'Darwin' ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	brew install ack the_silver_searcher autojump wget tree fzf
fi

[ -f ~/.fzf.zsh ] && mv ~/.fzf.zsh ~/.fzf.zsh_old
ln -s ${DOTFILES}/zsh/fzf.zsh ~/.fzf.zsh
