#!/usr/bin/env bash
set -eoux pipefail

shellcheck ./scripts/*

sudo nixos-rebuild switch --flake .#nixos --show-trace

# TODO: Use the nix doom repo. I had trouble with it before.
# Remember to install nerd fonts inside emacs
if [ ! -f "/home/user0/.emacs.d/bin/doom" ]; then
	pushd /home/user0
	git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	echo "Don't forget to install nerd fonts inside emacs"
	sleep 5
	popd
fi

/home/user0/.emacs.d/bin/doom sync
/home/user0/.emacs.d/bin/doom doctor
