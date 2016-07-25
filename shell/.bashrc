# Set path
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

# Set ZSH
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Prompt
# export PROMPT='${ret_status} %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

# Set default editor
export VISUAL=vim
export EDITOR='$VISUAL'

# Set java home
export JAVA7_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home'
export JAVA8_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home'
export JAVA_HOME=$JAVA8_HOME
export PATH=$JAVA_HOME/bin:$PATH

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
alias b='git branch'
alias bb='git branch --all'
alias d='git diff'
alias s='git status'
alias gl='git log'
