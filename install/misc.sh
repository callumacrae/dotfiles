#!/bin/bash

# Only define if not already defined
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/.dotfiles"

# Link ~/.jshintrc
[ -f ~/.jshintrc ] && mv ~/.jshintrc ~/.jshintrc_old
ln -s ${DOTFILES}/misc/jshintrc ~/.jshintrc

# Link BetterTouchTools config
( cd ~/Library/Application\ Support/ && [ -d BetterTouchTool ] && mv BetterTouchTool{,_old})
ln -s ${DOTFILES}/misc/BetterTouchTool ~/Library/Application\ Support/BetterTouchTool

# Is this required? It seems to refuse to read from linked files…
# export btt_plist="${HOME}/Library/Preferences/com.hegenberg.BetterTouchTool.plist"
# [ -f $btt_plist ] && mv ${btt_plist}{,_old}
# ln -s ${DOTFILES}/misc/com.hegenberg.BetterTouchTool.plist ${btt_plist}

# Link Karabiner config
[ -d ~/.config/karabiner ] && mv ~/.config/karabiner{,_old}
ln -s ${DOTFILES}/misc/karabiner ~/.config/karabiner
