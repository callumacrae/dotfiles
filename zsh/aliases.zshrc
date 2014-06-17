alias reload=". ~/.zshrc" # Reloads ZSH config
alias phpstorm="open -a phpstorm ." # Opens current directory in PhpStorm
alias intellij="open -a 'IntelliJ IDEA 13' ." # Opens current directory in idea
[ -x "$(which ack-grep)" ] && alias ack=ack-grep # ack sometimes ack-grep

# Shut the fuck up, ZSH
alias vim="nocorrect vim"
alias trash="nocorrect trash"

# Clones a project from GitHub into ~/Sites, and opens it in PhpStorm
function starton {
	dir=${1##*/}

	# Remove .git from directory if present
	if [[ $dir =~ ".git" ]]; then
		dir=$dir[0,-5]
	fi

	git clone $1 ~/Sites/$dir
	open -a 'IntelliJ IDEA 13' $_
}
