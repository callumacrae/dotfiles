# Add npm global install path to $PATH
export PATH=$HOME/.npm/bin:/usr/local/bin:$PATH

source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm
nvm use default
source ~/.nvm/v0.10.28/lib/node_modules/npm/lib/utils/completion.sh