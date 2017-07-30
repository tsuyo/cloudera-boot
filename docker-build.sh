#!/bin/bash

CD_VER_FULL=$1
CD_VER_FULL=${CD_VER_FULL:=2}
a=( ${CD_VER_FULL//./ } )
CD_VER=${a[0]}

docker build --build-arg CD_VER=${CD_VER} -t kirasoa/cloudera-boot:${CD_VER_FULL} -t kirasoa/cloudera-boot:${CD_VER} -t kirasoa/cloudera-boot:latest .
