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

baas-mdb-setup() {
    baas-mdb-teardown

    echo "Initiating test and local replsets."
    mkdir -p ~/db/test
    pushd ~/db/test
    mlaunch init --port 26000 --replicaset --nodes 1
    popd

    mkdir -p ~/db/local
    pushd ~/db/local
    mlaunch init --port 27017 --replicaset --nodes 1
    popd

}

baas-mdb-teardown() {
    echo "Stopping and deleting test and local replsets."
    mkdir -p ~/db/test
    pushd ~/db/test
    mlaunch stop
    rm -rf ./data
    popd

    mkdir -p ~/db/local
    pushd ~/db/local
    mlaunch stop
    rm -rf ./data
    popd
}

baas-run-local() {
    pushd $HOME/projects/baas
    aws-vault exec mms-scratch -- make run-local
    popd
}

baas-run-local-setup-user() {
    echo "Creating user with:"
    echo "    id: unique_user@domain.com"
    echo "    password: password"
    pushd $HOME/projects/baas
    go run -exec="env LD_LIBRARY_PATH=$LD_LIBRARY_PATH" cmd/auth/user.go addUser -domainID 000000000000000000000000 -mongoURI mongodb://localhost:27017 -salt 'DQOWene1723baqD!_@#' -id "unique_user@domain.com" -password "password"
    popd
}

mms-mdb-reset() {
    echo "Stopping and deleting baas-mms replset."
    mkdir -p ~/db/test
    pushd ~/db/test
    mlaunch stop
    rm -rf ./data
    popd

    echo "Initiating local baas replset."
    mkdir -p ~/db/test
    pushd ~/db/test
    mlaunch init --port 26000 --replicaset --nodes 1
    popd

    echo "Initiating local mongodb for mms, resetting any db content."
    pushd $MMS_HOME
    ./scripts/mongodb-start-standalone.bash -d
    bazel run //server:mms_init_local
    popd
}

mms-run-local() {
    pushd $MMS_HOME
    bazel run //server:mms_skip_assets
    popd
}

mms-run-baas() {
    pushd ~/projects/baas-ui
    yarn build
    popd

    pushd ~/projects/baas
    aws-vault exec mms-scratch -- go run -exec="env LD_LIBRARY_PATH=$LD_LIBRARY_PATH" cmd/server/main.go --configFile ./etc/configs/local_cloud_config.json --configFile $HOME/my_cloud_config.json
    popd
}

mms-ngrok-run() {
    ngrok http -subdomain=mongodb-cloud-carl-worley 8080
}


[ -s "/Users/carl.worley/.jabba/jabba.sh" ] && source "/Users/carl.worley/.jabba/jabba.sh"
