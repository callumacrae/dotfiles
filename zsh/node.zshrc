# Add npm global install path to $PATH
export PATH=$HOME/.npm/bin:/usr/local/bin:$PATH

export NODE_PATH=$NODE_PATH:/Users/callumacrae/.npm/lib/node_modules

# Load nvm
source ~/.nvm/nvm.sh

export NVM_DIR=~/.nvm
nvm use default

if [ ! -f ~/.npm_completion ]; then
	npm completion > ~/.npm_completion
fi

source ~/.npm_completion

function chpwd() {
    if [ -r $PWD/.nvmrc ]; then
        nvm use `cat $PWD/.nvmrc`
    fi
}
