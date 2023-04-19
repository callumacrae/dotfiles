#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

[ -x "$(which brew)" ] && brew install neovim ccls clang-format lua-language-server gh jq rg
[ -x "$(which apt-get)" ] && sudo apt-get install -y vim neovim
npm i -g typescript typescript-language-server vscode-langservers-extracted @volar/vue-language-server tsun bash-language-server graphql-language-service-cli

/opt/homebrew/opt/fzf/install

[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc_old
ln -s ${DOTFILES}/vim/vimrc ~/.vimrc

[ -f ~/.ideavimrc ] && mv ~/.ideavimrc ~/.ideavimrc_old
ln -s ${DOTFILES}/vim/ideavimrc ~/.ideavimrc

[ -f ~/.vimrc-common ] && mv ~/.vimrc-common ~/.vimrc-common_old
ln -s ${DOTFILES}/vim/vimrc-common ~/.vimrc-common

[ -d ~/.config/nvim ] && mv ~/.config/nvim{,_old}
ln -s ${DOTFILES}/vim/config ~/.config/nvim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PluginInstall +qall
