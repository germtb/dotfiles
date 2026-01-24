
# Set path
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
export PATH=$HOME'/.npm-global/bin':$PATH
export PATH=$HOME'/bin':$PATH
export PATH=$HOME'/.gem/ruby/2.4.0/bin':$PATH

# Appearence
export TERM=xterm-256color

# Set ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt
export PROMPT='${ret_status} %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

# Ensure brew is in path
eval $(/opt/homebrew/bin/brew shellenv)

# Set default editor
export VISUAL=vim
export EDITOR=vim

# Aliases
alias l='ls -la'
alias ls='ls -la'
alias less='less -S -N'
alias o='cd ..'
alias vim='vim'
alias python='python3'

cd-ls() {
  cd $1
  ls -la
}
zle -N  cd-ls
alias cl='cd-ls'

# Git aliases
alias gd='git diff'
alias gs='git status'
alias gl='git log --name-status'
alias aa='git add --all && git status'
alias gg='git commit --amend --no-edit'
alias pp='git push -u origin HEAD'
alias pl='git pull'
alias rr='git reset --hard'
alias bb='git branch'

# fzf
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

export FZF_PREVIEW='[[ $(file --mime {}) =~ binary ]] &&
	echo {} is a binary file ||
	(highlight -O ansi -l {} || rougify {} || cat {}) 2> /dev/null | head -500'
export FZF_COMPLETION_TRIGGER='*'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_OPTS=' --extended --preview "[[ $(file --mime {}) =~ binary ]] &&
	echo {} is a binary file ||
	(highlight -O ansi -l {} || rougify {} || cat {}) 2> /dev/null | head -500"'

fzf-git-branch() {
	local branches branch
	branches=$(git branch) &&
	branch=$(echo "$branches" | fzf +m --height 40%) &&
	git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
	zle reset-prompt
}
zle -N  fzf-git-branch
bindkey '^B' fzf-git-branch

fzf-git-remote-branch() {
	local branches branch
	branches=$(git branch --all | grep -v HEAD) &&
	branch=$(echo "$branches" | fzf +m --height 40%) &&
	git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
	zle reset-prompt
}
zle -N  fzf-git-remote-branch
bindkey '^V' fzf-git-remote-branch

fzf-file() {
	local file=$(rg --files | fzf --height 100% --extended --preview $FZF_PREVIEW)
	if [[ -z "$file" ]]; then
		zle redisplay
		return 0
	fi
	</dev/tty vim "$file"
	zle reset-prompt
}
zle -N  fzf-file
bindkey '^P' fzf-file

fzf-dir() {
	local dir
	dir=$(fd -t d '' $HOME | fzf +m --height 100% --preview "exa --tree --level=2 {}") &&
	cd "$dir"
	zle reset-prompt
}
zle -N  fzf-dir
bindkey '^O' fzf-dir


# Created by `pipx` on 2025-11-27 09:52:27
export PATH="$PATH:/Users/gerardmtb/.local/bin"

# pnpm
export PNPM_HOME="/Users/gerardmtb/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/gerardmtb/.bun/_bun" ] && source "/Users/gerardmtb/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
