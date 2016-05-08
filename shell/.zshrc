export ZSH=/home/gerardb/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle:~/dev/brjs/brjs-sdk/sdk"
source $ZSH/oh-my-zsh.sh
alias o='cd ..'
alias s='git status'
alias a='git add'
alias b='git branch'
alias bb='git branch --all'
alias d='cd ~/dev'
alias cl='. ~/cl'
alias cll='. ~/cll'
