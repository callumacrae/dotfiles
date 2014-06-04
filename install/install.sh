#!/bin/sh

[ -x "$(which apt-get)" ] && sudo apt-get update

# For .dotfiles testing
if [ -f /vagrant/install/zsh.sh ]; then
	ln -s /vagrant ~/.dotfiles
fi

. ./git.sh
. ./zsh.sh
. ./vim.sh

echo "Installed. Exit and come back"