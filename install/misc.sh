#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

# Link ~/.jshintrc
[ -f ~/.jshintrc ] && mv ~/.jshintrc ~/.jshintrc_old
ln -s ${DOTFILES}/misc/jshintrc ~/.jshintrc