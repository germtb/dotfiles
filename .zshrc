# Set path

export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin':$PATH
if [ "$(uname)" = "Darwin" ]; then
  export PATH='/opt/homebrew/bin':$PATH
fi
export PATH=$HOME'/.npm-global/bin':$PATH
export PATH=$HOME'/bin':$PATH
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
export PATH='/usr/local/go/bin':$PATH
if [ "$(uname)" = "Darwin" ]; then
  export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
fi
export PATH="$HOME/dev/tokki/cli/dist:$PATH"
export PATH="$PATH:$HOME/go/bin"

# Homebrew libraries (for WeasyPrint/pango, etc.)
export DYLD_LIBRARY_PATH="/opt/homebrew/lib:$DYLD_LIBRARY_PATH"

# Load secrets (API keys, etc.) - not tracked in git
[ -f ~/.secrets ] && source ~/.secrets

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# Appearence
export TERM=xterm-256color

# Colors
autoload -Uz colors && colors

# Prompt - git branch inline (replaces oh-my-zsh)
git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  local dirty=""
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    dirty=" %{$fg[yellow]%}✗%{$reset_color%}"
  fi
  echo " %{$fg[blue]%}($branch${dirty}%{$fg[blue]%})%{$reset_color%}"
}
setopt PROMPT_SUBST
setopt AUTO_CD
local ret_status="%(?:%{$fg_bold[green]%}∴ :%{$fg_bold[red]%}∴ )"
PROMPT='${ret_status}%{$fg[cyan]%}%~%{$reset_color%}$(git_branch) '


# Set default editor
export VISUAL=vim
export EDITOR=vim

# Aliases
alias l='eza --icons --git --group-directories-first'
alias ll='eza -la --icons --git --group-directories-first'
alias ls='eza --icons --git --group-directories-first'
alias less='less -S -N'
alias o='cd ..'

# bat alias for Linux (installed as batcat)
command -v batcat &>/dev/null && alias bat='batcat'

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
export FZF_DEFAULT_COMMAND='rg --files'

# Cmd-P file finder: rg + fzf -> vim
fzf-open-file() {
  local file
  file=$(rg --files 2>/dev/null | fzf --preview 'bat --style=plain --color=always --line-range=:100 {} 2>/dev/null || head -100 {}')
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
if [ "$(uname)" = "Darwin" ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
bindkey '^[^M' autosuggest-accept

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Start zellij automatically (only if not already in a session)
if [[ -z "$ZELLIJ" ]]; then
  zellij
fi
