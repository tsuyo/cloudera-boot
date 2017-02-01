#!/bin/bash

service cloudera-director-server start
printf "waiting for director server wakeup "
while [ "$(ss -tl | grep '*:7189' | wc -l)" -ne "1" ]; do
  printf "."
  sleep 3
done
echo ""
cloudera-director bootstrap-remote cluster.conf --lp.remote.username=admin --lp.remote.password=admin --lp.remote.hostAndPort=localhost:7189
