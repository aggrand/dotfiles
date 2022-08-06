#!/usr/bin/env bash

set -u

echo "Note: Installing xcode-select may fail if already present. Errors can be ignored."
sudo xcode-select --install

set -eo pipefail

which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing homebrew."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating homebrew."
    brew update
fi

echo "Bootstrapping python."
brew install pyenv
brew upgrade pyenv
if brew ls --versions pyenv >/dev/null; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade pyenv 
else
    HOMEBREW_NO_AUTO_UPDATE=1 brew install pyenv
fi
source .bashrc
pyenv install -s 3.9.9
pyenv global 3.9.9
sudo pip3 install --upgrade pip

echo "Installing ansible."
pip3 install ansible

echo "Running ansible."
ansible-playbook install-playbook.yaml

echo "Next steps:"
echo "    Firefox addons"
echo "        ABP, Bitwarden"
echo "    Login everywhere"
echo "        google, slack, zoom, github"
echo "    Configure Kanopy access"
echo "        https://github.com/10gen/kanopy-docs/blob/master/docs/configuration/kubeconfig.md"
