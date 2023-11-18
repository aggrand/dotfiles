#!/usr/bin/env bash
set -eoux pipefail

sudo nixos-rebuild switch --flake .#nixos
