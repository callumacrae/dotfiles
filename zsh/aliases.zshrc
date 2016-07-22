alias reload=". ~/.zshrc" # Reloads ZSH config
alias phpstorm="open -a phpstorm ." # Opens current directory in PhpStorm
alias intellij="open -a 'IntelliJ IDEA 15' ." # Opens current directory in idea
[ -x "$(which ack-grep)" ] && alias ack=ack-grep # ack sometimes ack-grep
alias govim="vim +"NERDTree `pwd`""
alias treeAll="tree -I 'node_modules|\.git|\.sass-cache|\.idea' -a"

# Shut the fuck up, ZSH
alias vim="nocorrect vim"
alias trash="nocorrect trash"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; reloadFinder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; reloadFinder'
alias reloadFinder='killall Finder /System/Library/CoreServices/Finder.app'

alias fuck='$(thefuck $(fc -ln -1))'
alias FUCK='fuck'

# Clones a project from GitHub into ~/Sites, and opens it in PhpStorm
function starton {
	dir=${1##*/}

	# Remove .git from directory if present
	if [[ $dir =~ ".git" ]]; then
		dir=$dir[0,-5]
	fi

	hub clone $1 ~/Sites/$dir
	open -a 'IntelliJ IDEA 13' $_
}
