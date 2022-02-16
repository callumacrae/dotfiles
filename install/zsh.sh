#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

# Install ZSH
[ -x "$(which apt-get)" ] && sudo apt-get install -y zsh

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Install Prezto files
shopt -s extglob
shopt -s nullglob
files=( "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/!(README.md) )
for rcfile in "${files[@]}"; do
	[[ -f $rcfile ]] && ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile##*/}"
done

# Change default shell to ZSH
sudo chsh -s /bin/zsh `whoami`


# Install pure
git clone https://github.com/sindresorhus/pure.git ~/.pure
ln -s ~/.pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
ln -s ~/.pure/async.zsh /usr/local/share/zsh/site-functions/async


# Install zsh-nvm
mkdir "${ZDOTDIR:-$HOME}/.zprezto/contrib"
git clone git@github.com:lukechilds/zsh-nvm.git "${ZDOTDIR:-$HOME}/.zprezto/contrib"


# Set up config files
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc_old
ln -s ${DOTFILES}/zsh/zshrc ~/.zshrc

[ -f ~/.zpreztorc ] && mv ~/.zpreztorc ~/.zpreztorc_old
ln -s ${DOTFILES}/zsh/zpreztorc ~/.zpreztorc
