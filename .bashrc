#!/usr/bin/env bash

export PROMPT_COMMAND=""
export PYENV_ROOT=$HOME/.pyenv
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source $HOME/.poetry/env

PATH="$PATH:$(go env GOPATH)/bin"

# Kanopy config
export KUBECONFIG=~/.kube/config.staging:~/.kube/config.prod
