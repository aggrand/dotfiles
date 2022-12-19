#!/usr/bin/env bash

export PROMPT_COMMAND=""
export PYENV_ROOT=$HOME/.pyenv
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source $HOME/.poetry/env

PATH="$PATH:$(go env GOPATH)/bin"
PATH="$PATH:$HOME/bin"
export LD_LIBRARY_PATH=~/projects/baas/etc/dylib/lib
export AWS_DEFAULT_REGION=us-east-1
alias baas='make -f $HOME/projects/baas/Makefile'
alias baas-test='aws-vault exec mms-scratch -- make -f $HOME/projects/baas/Makefile test-all'

# Kanopy config
export KUBECONFIG=~/.kube/config.staging:~/.kube/config.prod

export GPG_TTY=$(tty)

baas-setup-mdb() {

    echo "Deleting test and local replsets and re-initiating."
    mkdir -p ~/db/test
    pushd ~/db/test
    mlaunch stop
    rm -rf ./data
    mlaunch init --port 26000 --replicaset --nodes 1
    popd

    mkdir -p ~/db/local
    pushd ~/db/local
    mlaunch stop
    rm -rf ./data
    mlaunch init --port 27017 --replicaset --nodes 1
    popd
}

baas-run-local() {
    pushd $HOME/projects/baas
    aws-vault exec mms-scratch -- make run-local
    popd
}

baas-setup-user() {
    echo "Creating user with:"
    echo "    id: unique_user@domain.com"
    echo "    password: password"
    pushd $HOME/projects/baas
    go run -exec="env LD_LIBRARY_PATH=$LD_LIBRARY_PATH" cmd/auth/user.go addUser -domainID 000000000000000000000000 -mongoURI mongodb://localhost:27017 -salt 'DQOWene1723baqD!_@#' -id "unique_user@domain.com" -password "password"
    popd
}
