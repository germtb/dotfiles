export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-8-oracle:/opt/local/bin:/opt/local.sbin"
source $ZSH/oh-my-zsh.sh
# PS1
GREEN="\[$(tput setaf 2)\]"
CYAN="\[$(tput setaf 6)\]"
RED="\[$(tput setaf 1)\]"
BLUE="\[$(tput setaf 4)\]"
RESET="\[$(tput sgr0)\]"
export VISUAL=vim
export EDITOR="$VISUAL"

# Aliases
alias a='git add'
alias b='git branch'
alias bb='git branch --all'
alias c='clear'
alias cl='. ~/dotfiles/shell/cl'
alias d='cd ~/dev'
alias l='ls -la'
alias ll='ls -lad'
alias less='less -S -N'
alias s='git status'
alias o='cd ..'
alias vim='/usr/local/Cellar/vim/7.4.1910/bin/vim'
alias vi='/usr/local/Cellar/vim/7.4.1910/bin/vim'

