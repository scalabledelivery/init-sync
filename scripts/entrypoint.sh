#!/bin/bash
set -ex

if [[ ${DEBUG} != 0 ]]; then
    echo "Opening /bin/bash for debugging and setting DEBUG=0"
    export DEBUG=0
    /bin/bash
    exit 0
fi

if ! [[ `hostname` =~ ([A-Za-z0-9_-]+)-([0-9]+)$ ]]; then
    echo "container hostnames must contain ordinals"
    exit 1
fi

# Get the ordinal
export ordinal=${BASH_REMATCH[2]}
export unnumbered_hostname=${BASH_REMATCH[1]}

if [ "${SHARE_DIR}" == "" ]; then
    echo 'SHARE_DIR must be set'
    exit 1
fi

if [ ! -d "${SHARE_DIR}" ] && [[ ${ordinal} -eq 0 ]] && [ "${ACTION}" != "RECV" ]; then
    echo 'SHARE_DIR must be a directory'
    exit 1
fi

if [ "${SHARED_SECRET}" == "" ]; then
    echo 'SHARED_SECRET must be set for encryption'
    exit 1
fi

case "${ACTION}" in
  "SEND")
    /bin/daemon
    ;;

  "RECV")
    /bin/download
    ;;

  *)
    echo -n "ACTION must be set to SEND or RECV"
    exit 1
    ;;
esac