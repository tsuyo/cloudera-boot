#!/bin/bash

OPTIND=1 # Reset in case getopts has been used previously in the shell.

push=0
cache_flag=""
cd_ver_full=6.0.0
repo="kirasoa/cloudera-director"

while getopts "h?pcv:r:" opt; do
    case "$opt" in
    h|\?)
        echo "Usage: $0 [-p] [-c] [-v <cloudera_director_version>] [-r <repository>]"
        exit 0
        ;;
    p)  push=1
        ;;
    c)  cache_flag="--no-cache"
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

docker build ${cache_flag} --build-arg CD_VER=${cd_ver_full} -t ${repo}:${cd_ver_full} -t ${repo}:${cd_ver} -t ${repo}:latest .
if [[ "$push" == "1" ]]; then
  docker push ${repo}:${cd_ver_full} && \
  docker push ${repo}:${cd_ver} && \
  docker push ${repo}:latest
fi
