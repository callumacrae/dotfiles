#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

. $DOTFILES/install/packages.sh
. $DOTFILES/install/git.sh
. $DOTFILES/install/zsh.sh
. $DOTFILES/install/vim.sh
. $DOTFILES/install/node.sh
. $DOTFILES/install/irssi.sh
. $DOTFILES/install/misc.sh

unset DOTFILES # Don't mess up the PS1

echo "Installed. Exit and come back"
