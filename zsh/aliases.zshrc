alias reload=". ~/.zshrc" # Reloads ZSH config
alias intellij="open -a 'IntelliJ IDEA' ." # Opens current directory in idea
[ -x "$(which ack-grep)" ] && alias ack=ack-grep # ack sometimes ack-grep
alias treeAll="tree -I 'node_modules|\.git|\.sass-cache|\.idea' -a"

# Shut the fuck up, ZSH
alias vim="nocorrect vim"
alias trash="nocorrect trash"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; reloadFinder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; reloadFinder'
alias reloadFinder='killall Finder /System/Library/CoreServices/Finder.app'

alias irc="mosh irc tmux attach"
