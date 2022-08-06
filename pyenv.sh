#!/usr/bin/env bash

export PROMPT_COMMAND=""
export PYENV_ROOT=$HOME/.pyenv
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
