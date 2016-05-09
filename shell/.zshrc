export ZSH=/home/gerardb/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle:~/dev/brjs/brjs-sdk/sdk"
source $ZSH/oh-my-zsh.sh

# PS1
GREEN="\[$(tput setaf 2)\]"
CYAN="\[$(tput setaf 6)\]"
RED="\[$(tput setaf 1)\]"
BLUE="\[$(tput setaf 4)\]"
RESET="\[$(tput sgr0)\]"

PS1="${BLUE}{ \`pwd\` }${RESET} ${RED}»${RESET} "

# Aliases
alias a='git add'
alias b='git branch'
alias bb='git branch --all'
alias c='clear'
alias cl='. ~/cl'
alias cll='. ~/cll'
alias d='cd ~/dev'
alias less='less -S -N'
alias s='git status'
alias o='cd ..'
