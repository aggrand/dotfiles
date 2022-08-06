#!/usr/bin/env bash

set -u

echo "Note: Installing xcode-select may fail if already present. Errors can be ignored."
sudo xcode-select --install

set -eo pipefail

# Install/Update Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Bootstrap python
brew install pyenv
brew upgrade pyenv
if brew ls --versions pyenv >/dev/null; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade pyenv 
else
    HOMEBREW_NO_AUTO_UPDATE=1 brew install pyenv
fi
source ./pyenv.sh
pyenv install -s 3.9.9
pyenv global 3.9.9
sudo pip3 install --upgrade pip

# Run the ansible playbook.
pip3 install ansible
