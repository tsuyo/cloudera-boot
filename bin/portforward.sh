#!/bin/bash

if [[ -z "${REMOTE_USER}" ]] || [[ -z "${REMOTE_HOST}" ]] || [[ -z "${SSH_PRIVATE_KEY}" ]]; then
  echo "REMOTE_USER, REMOTE_HOST and SSH_PRIVATE_KEY are required"
  exit 1
fi

ssh -i ${SSH_PRIVATE_KEY} -L 7189:localhost:7189 -N -o "StrictHostKeyChecking no" -o "AddressFamily inet" ${REMOTE_USER}@${REMOTE_HOST} 2>/dev/null &
