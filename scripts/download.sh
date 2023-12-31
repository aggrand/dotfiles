#!/usr/bin/env bash
# Run as root!
set -eoux pipefail

nix-env --install git vim
mkdir -p /home/user0/projects

cd /home/user0/projects
git clone https://github.com/aggrand/dotfiles
cd /home/user0/projects/dotfiles

echo "If running on new hardware, do the following:"
echo "tcp /etc/nixos/hardware-configuration.nix ."
echo "After installation, make sure to commit."
echo " "
echo "Either way, then do the following as root:"
echo "./scripts/install"
