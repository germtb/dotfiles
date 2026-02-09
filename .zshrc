# Set path

export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin':$PATH
export PATH='/opt/homebrew/bin':$PATH
export PATH=$HOME'/.npm-global/bin':$PATH
export PATH=$HOME'/bin':$PATH
export PATH=$HOME'/.cargo/env':$PATH
export PATH=$HOME'/.cargo/bin':$PATH
export PATH='/usr/local/go/bin':$PATH
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH="$HOME/dev/tokki/cli/dist:$PATH"

# Load secrets (API keys, etc.) - not tracked in git
[ -f ~/.secrets ] && source ~/.secrets

# Appearence
export TERM=xterm-256color

# Colors
autoload -Uz colors && colors

# Prompt - git branch inline (replaces oh-my-zsh)
git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  echo " %{$fg[blue]%}($branch)%{$reset_color%}"
}
setopt PROMPT_SUBST
local ret_status="%(?:%{$fg_bold[green]%}∴ :%{$fg_bold[red]%}∴ )"
PROMPT='${ret_status}%{$fg[cyan]%}%~%{$reset_color%}$(git_branch) '


# Set default editor
export VISUAL=vim
export EDITOR=vim

# Aliases
alias l='ls -lah'
alias ls='ls -lah'
alias less='less -S -N'
alias o='cd ..'

# Python
alias python='python3'
alias pip='pip3'

# Lazygit
alias lg='lazygit'

# Git aliases
alias gd='git diff'
alias gs='git status'
alias gl='git log --name-status'
alias gc='git checkout'
alias gr='git rebase'
alias cc='git commit -m'
alias ga='git add --all && git status'
alias gg='git commit --amend --no-edit'
alias gp='git push -u origin HEAD'
alias gpull='git pull'
alias grr='git reset --hard'
alias gb='git branch'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Cmd-P file finder: rg + fzf -> vim
fzf-open-file() {
  local file
  file=$(rg --files 2>/dev/null | fzf --preview 'head -100 {}')
  if [[ -n "$file" ]]; then
    vim "$file"
  fi
  zle reset-prompt
}
zle -N fzf-open-file
bindkey '^P' fzf-open-file

# Completions (cached, regenerates daily)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# zoxide
eval "$(zoxide init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Start zellij automatically (only if not already in a session)
if [[ -z "$ZELLIJ" ]]; then
  zellij
fi
