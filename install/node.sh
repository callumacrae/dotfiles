#!/bin/bash

[ -x "$(which apt-get)" ] && sudo apt-get install -y curl

# Install nvm
git clone https://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh

# Install Node and npm
nvm install --lts
nvm alias default stable

npm install -g yarn
