#!/bin/bash

printf "waiting for director server wakeup "
while [ "$(curl -LIs http://${SERVER_HOST_N_PORT} -o /dev/null -w '%{http_code}\n')" -ne "200" ]; do
  printf "."
  sleep 1
done
echo ""
