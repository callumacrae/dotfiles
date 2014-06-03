# Source Prezto if available
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Mac stuff
if [[ `uname` == 'Darwin' ]]; then

	# Cheatsheet: lsvirtualenv, mkvirtualenv, workon, deactivate
	source /usr/local/bin/virtualenvwrapper.sh

	# Autojump or z? I can't decide
	[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
	. `brew --prefix`/etc/profile.d/z.sh

fi