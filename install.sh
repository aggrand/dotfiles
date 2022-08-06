#!/usr/bin/env bash

set -ux

# May fail if already installed.
sudo xcode-select --install

set -eo pipefail

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Bootstrap python
brew update
brew install pyenv
source ./pyenv.sh
pyenv install -s 3.9.9
pyenv global 3.9.9
