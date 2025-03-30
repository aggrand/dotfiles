# There's more stuff here to explore:
# https://thevaluable.dev/zsh-install-configure-mouseless/

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias doom="~/.emacs.d/bin/doom"

alias vim=nvim
bindkey -v
export KEYTIMEOUT=1

# Use editor when we press "v"
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Normal backspace
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

export PATH="$HOME/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

export HISTSIZE=10000
export SAVEHIST=10000

# Zsh reload
alias zr="source ~/.zshrc"

# Git commands
alias gs="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gp="git push"
alias gu="git pull"
alias gl="git log"
alias glo="git log --oneline"
alias glol="git log --oneline --graph --decorate"

# Run tfswitch automatically if 'main.tf' file is present
load-tfswitch() {
  local terraform_versionfile_path="main.tf"
  if [ -f "$terraform_versionfile_path" ]; then
    tfswitch
  fi
}
add-zsh-hook chpwd load-tfswitch
load-tfswitch

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Needs to be at end?
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
