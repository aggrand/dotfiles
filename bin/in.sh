#!/usr/bin/env bash

set -eou pipefail


INBOX_MD="${HOME}/notes/inbox.md"
SCRATCH_MD="/tmp/scratch-in.md"

CREATION_DATE=$(date)

echo >> ${INBOX_MD}
echo >> ${INBOX_MD}
echo "## ${CREATION_DATE}" >> ${INBOX_MD}
nvim ${SCRATCH_MD}

if [ ! -f ${SCRATCH_MD} ] || [ ! -s ${SCRATCH_MD} ]; then
    rm ${SCRATCH_MD} &> /dev/null || true  # Silence error if nonexistent
    echo "Empty input; aborting capture"
    exit
fi

cat ${SCRATCH_MD} >> ${INBOX_MD}
rm ${SCRATCH_MD}
