export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-8-oracle:/opt/local/bin:/opt/local.sbin"
source $ZSH/oh-my-zsh.sh

# Prompt
#export PROMPT="${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"
#export PROMPT="[%n@%m:%~]%#"
#export PROMPT="${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"

# PS1
GREEN="\[$(tput setaf 2)\]"
CYAN="\[$(tput setaf 6)\]"
RED="\[$(tput setaf 1)\]"
BLUE="\[$(tput setaf 4)\]"
RESET="\[$(tput sgr0)\]"

# Set default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Aliases
alias c='clear'
alias cl='. ~/dotfiles/shell/cl'
alias l='ls -la'
alias ll='ls -la'
alias less='less -S -N'
alias o='cd ..'
alias vim='/usr/local/Cellar/vim/7.4.1910/bin/vim'
alias nvim='nvim -u ~/.vimrc'

# Git aliases
alias a='git add'
alias b='git branch'
alias bb='git branch --all'
alias d='git diff'
alias s='git status'
alias p='git push'

