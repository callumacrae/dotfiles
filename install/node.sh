#!/bin/bash

[ -x "$(which apt-get)" ] && sudo apt-get install -y curl

# Install nvm
git clone https://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh

# Install Node and npm
nvm install 6
nvm alias default 6

# Install common global dependencies
npm config set prefix ~/.npm
npm install -g gulp-cli david trash # Also installs grunt and bower
