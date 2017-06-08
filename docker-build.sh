#!/bin/bash

CD_VER=$1
CD_VER=${CD_VER:=2}

docker build --build-arg CD_VER=${CD_VER} -t kirasoa/cloudera-director-server:${CD_VER} -t kirasoa/cloudera-director-server:latest server
docker build --build-arg CD_VER=${CD_VER} -t kirasoa/cloudera-director-client:${CD_VER} -t kirasoa/cloudera-director-client:latest client
