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

# Set ZSH
export ZSH=~/.oh-my-zsh
ZSH_THEME="candy"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Prompt
export PROMPT='${ret_status} %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info) '


# Set default editor
export VISUAL=vim
export EDITOR=vim

# Aliases
alias l='ls -la'
alias ls='ls -la'
alias less='less -S -N'
alias o='cd ..'
alias ctags="`brew --prefix`/bin/ctags"

# Python
alias python='python3'
alias pip='pip3'

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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Start zellij automatically (only if not already in a session)
if [[ -z "$ZELLIJ" ]]; then
  zellij
fi
