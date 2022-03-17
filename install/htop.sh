#!/bin/bash

if [[ -x "$(which brew)" ]]; then
	brew install automake autoconf
elif [[ -x "$(which apt)" ]]; then
	sudo apt install libncursesw5-dev autotools-dev autoconf build-essential
fi

(
	cd $DOTFILES
	git clone git@github.com:KoffeinFlummi/htop-vim.git
	cd htop-vim
	# there's a conflict atm:
	# git remote add upstream git@github.com:htop-dev/htop.git
	# git pull upstream main
	./autogen.sh && ./configure && make
	make install
)
