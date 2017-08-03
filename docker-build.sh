#!/bin/bash

OPTIND=1 # Reset in case getopts has been used previously in the shell.

push=0
cd_ver_full=2
repo="kirasoa/cloudera-boot"

while getopts "h?pv:r:" opt; do
    case "$opt" in
    h|\?)
        echo "Usage: $0 [-p] [-v <cloudera_director_version>] [-r <repository>]"
        exit 0
        ;;
    p)  push=1
        ;;
    v)  cd_ver_full=$OPTARG
        ;;
    r)  repo=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

a=( ${cd_ver_full//./ } )
cd_ver=${a[0]}

docker build --build-arg CD_VER=${cd_ver} -t ${repo}:${cd_ver_full} -t ${repo}:${cd_ver} -t ${repo}:latest .
if [[ "$push" == "1" ]]; then
  docker push ${repo}:${cd_ver_full} && \
  docker push ${repo}:${cd_ver} && \
  docker push ${repo}:latest
fi
