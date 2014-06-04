#!/bin/bash

if [[ -x `which apt-get` ]]; then
	sudo apt-get update
	sudo apt-get install -y ack-grep autojump htop
fi

if [[ `uname` == 'Darwin' ]]; then
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

	brew install ack autojump htop
	brew install caskroom/cask/brew-cask
fi