#!/bin/bash
set -ex

if [[ ${ordinal} -eq 0 ]]; then
    echo "skipping ordinal 0, it should handle genesis"
    exit 0
fi

if [ -f "${SHARE_DIR}/.init-sync" ]; then
    echo "${SHARE_DIR}/.init-sync exists, skipping sync"
    exit 0
fi

if [ "${SERVICE_NAME}" == "" ]; then
    echo "SERVICE_NAME must be set so we can contact POD_BASE_NAME-(ORDINAL-1).SERVICE_NAME"
    exit 1
fi

cd /



ncat --recv-only "${unnumbered_hostname}-$(($ordinal-1)).${SERVICE_NAME}" ${SYNC_PORT} | openssl enc -aes-256-cbc -pbkdf2 -d -pass "pass:${SHARED_SECRET}" | tar xf -

touch "${SHARE_DIR}/.init-sync"

echo "files were copied from ${unnumbered_hostname}-$(($ordinal-1))"

ls -lah "${SHARE_DIR}"
