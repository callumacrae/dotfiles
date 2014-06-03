#!/bin/sh

# For .dotfiles testing
if [ -f /vagrant/install/zsh.sh ]; then
	ln -s /vagrant ~/.dotfiles
fi

. ./git.sh
. ./zsh.sh

echo "Installed. Exit and come back"