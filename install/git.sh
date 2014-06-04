#!/bin/bash

if [[ -x "$(which brew)" ]]; then
	brew install hub
elif [[ -x "$(which apt-get)" ]]; then
	# Install git
	sudo apt-get install -y git

	# Install hub
	sudo apt-get install -y rake # Needed to install
	git clone https://github.com/github/hub.git
	cd hub
	sudo rake install prefix=/usr/local
	cd ..
	rm -rf hub
fi
