#!/usr/bin/env bash
# Run as root!
set -eoux pipefail

nix-env --install git
mkdir -p /home/user0/projects

cd /home/user0/projects
git clone https://github.com/aggrand/dotfiles
cd /home/user0/projects/dotfiles

./scripts/rebuild.sh
passwd user0
shutdown -r now
