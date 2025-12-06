#!/usr/bin/env bash

set -eou pipefail

echo >> ~/notes/inbox.md
echo >> ~/notes/inbox.md
echo "## $(date)" >> ~/notes/inbox.md
nvim /tmp/inbox-scratch.md

cat /tmp/inbox-scratch.md >> ~/notes/inbox.md
rm /tmp/inbox-scratch.md
