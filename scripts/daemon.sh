#!/bin/bash
set -ex
cd /
echo sharing ${SHARE_DIR} over port ${SYNC_PORT}
ncat --listen --keep-open --send-only --max-conns=1 ${SYNC_PORT} -c "tar cf - ${SHARE_DIR#/} | openssl enc -aes-256-cbc -pbkdf2 -pass 'pass:${SHARED_SECRET}'"