#!/bin/zsh

# Only define if not already defined
$DOTFILES && export DOTFILES="$HOME/.dotfiles"


# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

sudo chsh -s /bin/zsh `whoami`


# Install pure
wget https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
mv pure.zsh ~/.zprezto/modules/prompt/functions/prompt_pure_setup


# Set up config files
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc_old
ln -s "$DOTFILES/zsh/zshrc" ~/.zshrc

[ -f ~/.zpreztorc ] && mv ~/.zpreztorc ~/.zpreztorc_old
ln -s ~/.dotfiles/zsh/zpreztorc ~/.zpreztorc