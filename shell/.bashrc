# Set path
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools

# Set ZSH
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git sublime npm osx sudo brew)
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt
export PROMPT='${ret_status} %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

# Set default editor
export VISUAL=vim
export EDITOR=vim

# Set java home
export JAVA7_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home'
export JAVA8_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home'
export JAVA_HOME=$JAVA8_HOME
export PATH=$JAVA_HOME/bin:$PATH

# Aliases
alias cl='. ~/dotfiles/shell/cl'
alias l='ls -la'
alias less='less -S -N'
alias o='cd ..'
alias nvim='nvim -u ~/.vimrc'
alias vim='/usr/local/bin/vim'
alias m='. ~/dotfiles/shell/mark'
alias c='. ~/dotfiles/shell/change'
alias ss='subl .'
alias gpg='gpg2'

# Git aliases
alias b='git branch'
alias bb='git branch --all'
alias d='git diff'
alias s='git status'
alias gl='git log --name-status'
alias gll= log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
alias p='pwd'
alias c='git checkout'

