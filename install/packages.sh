#!/bin/bash

if [[ -x `which apt-get` ]]; then
	sudo apt-get update
	sudo apt-get install -y ack-grep autojump htop
fi

if [[ `uname` == 'Darwin' ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	brew install ack autojump htop wget
fi
