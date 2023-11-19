#!/usr/bin/env bash
set -eoux pipefail

sudo nix flake update
~/.emacs.d/bin/doom upgrade

./scripts/rebuild.sh
