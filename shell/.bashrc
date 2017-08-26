  # Set path
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

if which ruby >/dev/null && which gem >/dev/null; then
  export PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Add rouge manually to path
export PATH=${PATH}:'/.gem/ruby/2.4.0/gems/rouge-2.2.1/bin'

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
alias cat='rougify'
alias reload='. ~/.bash_profile'
alias l='ls -la'
alias less='less -S -N'
alias o='cd ..'
alias vim='/usr/local/bin/vim'
alias ag='ag --ignore "node_modules/" --ignore "Blizzard/" --ignore "Applications/" --ignore "Desktop/" --ignore "Dropbox/" --ignore "Downloads/" --ignore "Documents/"'

cd-ls() {
  cd $1
  ls -la
}
zle -N  cd-ls
alias cd='cd-ls'

# Git aliases
alias b='git branch'
alias bb='git branch --all'
alias d='git diff'
alias s='git status'
alias ll='git log --name-status'
alias gll= log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
alias c='git cherry-pick'
alias aa='git add --all && git status'
alias gg='git commit --amend --no-edit'
alias pp='git push origin HEAD'
alias rr='git reset --hard'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_PREVIEW='[[ $(file --mime {}) =~ binary ]] &&
  echo {} is a binary file ||
  (highlight -O ansi -l {} || rougify {} || cat {}) 2> /dev/null | head -500'
export FZF_COMPLETION_TRIGGER='*'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_OPTS='--extended --preview "[[ $(file --mime {}) =~ binary ]] &&
  echo {} is a binary file ||
  (highlight -O ansi -l {} || rougify {} || cat {}) 2> /dev/null | head -500"'

fzf-git-branch() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf +m --height 40%) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
zle -N  fzf-git-branch
bindkey '^B' fzf-git-branch

fzf-git-remote-branch() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf +m --height 40%) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
zle -N  fzf-git-remote-branch
bindkey '^V' fzf-git-remote-branch

fzf-file() {
  local file=$(ag -g "" | fzf --height 40% --extended --preview $FZF_PREVIEW)
  if [[ -z "$file" ]]; then
    zle redisplay
    return 0
  fi
  atom "$file"
}
zle -N  fzf-file
bindkey '^P' fzf-file

fzf-js() {
  local file=$(ag -g .js | fzf --height 40% --extended --preview $FZF_PREVIEW)
  if [[ -z "$file" ]]; then
    zle redisplay
    return 0
  fi
  atom "$file"
}
zle -N  fzf-js
bindkey '^J' fzf-js

fzf-dir() {
  local dir
  dir=$(find ${1:-.} -path '*\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf --height 40% --extended --preview "ls -la {}")
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  cd "$dir"
}
zle -N  fzf-dir
bindkey '^O' fzf-dir

source ~/.secretrc
