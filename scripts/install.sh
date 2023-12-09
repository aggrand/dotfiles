#!/usr/bin/env bash
# Run as root!
set -eoux pipefail

./scripts/rebuild.sh
passwd user0
chown -r user0 /home/user0 # To make sure nothing funky with dotfiles.
echo "Restarting in 5 seconds to finalize..."
sleep 5
shutdown -r now
