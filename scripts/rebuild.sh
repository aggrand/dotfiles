#!/usr/bin/env bash
set -eoux pipefail

sudo nixos-rebuild switch --flake .#nixos

# TODO: Use the nix doom repo. I had trouble with it before.
~/.emacs.d/bin/doom sync
~/.emacs.d/bin/doom doctor
