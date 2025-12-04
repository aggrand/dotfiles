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

# This disables tilde expansion
#
LS_COLORS='di=1;32:ln=1;30;47:so=30;45:pi=30;45:ex=1;31:bd=30;46:cd=30;46:su=30'
export LS_COLORS="${LS_COLORS};41:sg=30;41:tw=30;41:ow=30;41:*.rpm=1;31:*.deb=1;31"
export LSCOLORS=CxahafafBxagagabababab
#TODO: Doesn't seem to play nice with zsh-autocomplete. Removed that for now.
autoload -U compinit; compinit
source ~/.config/zsh-plugins/fzf-tab/fzf-tab.plugin.zsh
#zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # Ugly with previews
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:*' ansi true
zstyle ':completion:*' menu no
unsetopt BEEP

alias doom="~/.emacs.d/bin/doom"

alias vim=nvim
alias vi=nvim
#bindkey -v
#export KEYTIMEOUT=1

# TODO: Doesn't work?
# bindkey -M viins 'jk' vi-jk-escape

# Use editor when we press "v"
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Normal backspace
#bindkey "^H" backward-delete-char
#bindkey "^?" backward-delete-char

export PATH="$HOME/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
export HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey -v
bindkey '^R' history-incremental-search-backward

# Set up fzf key bindings and fuzzy completion
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p80%,60%'

#export FZF_TMUX=0
source <(fzf --zsh)

#TODO: Spruce up some of these aliases? Use the plugins from oh my zsh?

# Zsh reload
alias zr="source ~/.zshrc"

# Git commands
# Inspired by here: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
alias g="git"
alias gs="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit --verbose"
#alias gco='git checkout $(tmux popup -d "$PWD" -d "$PWD" -E "git branch | fzf")'
alias gcob='git checkout -b'
alias gd="git diff"
alias gdc="git diff --cached"
alias gf="git fetch"
alias gp="git push"
alias gu="git pull"
alias gl="git log"
alias glo="git log --oneline"
alias glol="git log --oneline --graph --decorate"

alias k="kubectl"
alias kc="kubectx"
alias kn="kubens"

alias ls="ls --color"

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

eval "$(zoxide init zsh --cmd cd)"

alias envy='~/projects/ops/env-bootstrap/envy.sh'

# Yazi wrapper, can use it to "exit" in a dir
function rr() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Needs to be at end?
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/projects/dotfiles/p10k.zsh.
[[ ! -f ~/projects/dotfiles/p10k.zsh ]] || source ~/projects/dotfiles/p10k.zsh
export PATH=/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/raiden/.nvm/versions/node/v22.14.0/bin:/Users/raiden/bin:/Applications/iTerm.app/Contents/Resources/utilities:/Users/raiden/Library/Python/3.13/bin:/Users/raiden/Library/Python/3.13/bin
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export PATH="/Users/raiden/.local/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"

. "$HOME/.cargo/env"
