# Add npm global install path to $PATH
export PATH=$HOME/.npm/bin:/usr/local/bin:$PATH

# Load nvm
if [[ -s "~/.nvm/nvm.sh" ]]; then
	source "~/.nvm/nvm.sh"
elif [[ `uname` == 'Darwin' ]]; then
	source $(brew --prefix nvm)/nvm.sh
fi

export NVM_DIR=~/.nvm
nvm use default
source ~/.nvm/*/lib/node_modules/npm/lib/utils/completion.sh
