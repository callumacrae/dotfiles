#!/bin/bash

[ -x "$(which apt-get)" ] && sudo apt-get update

if [[ `uname` == 'Darwin' ]]; then
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

# For .dotfiles testing
if [ -f /vagrant/install/zsh.sh ]; then
	ln -s /vagrant ~/.dotfiles
fi

. ./git.sh
. ./zsh.sh
. ./vim.sh

echo "Installed. Exit and come back"