# Add npm global install path to $PATH
export PATH=$HOME/.npm/bin:/usr/local/bin:$PATH

export NODE_PATH=$NODE_PATH:/Users/callumacrae/.npm/lib/node_modules

# Load nvm
source ~/.nvm/nvm.sh

export NVM_DIR=~/.nvm

if [ ! -f ~/.npm_completion ]; then
  npm completion > ~/.npm_completion
fi

source ~/.npm_completion

# From https://github.com/nvm-sh/nvm#calling-nvm-use-automatically-in-a-directory-with-a-nvmrc-file
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
