FROM busybox:latest AS build-env

MAINTAINER Tsuyoshi Miyake <tsuyoshi.miyake@gmail.com>

ARG CD_VER="6.0.0"
ENV CD_VER ${CD_VER}

WORKDIR /app
RUN \
  wget -q http://archive.cloudera.com/director6/${CD_VER}/tars/cloudera-director-server-latest.tar.gz && \
  tar zxf cloudera-director-server-*.tar.gz && \
  rm cloudera-director-server-*.tar.gz && \
  mv cloudera-director-server-* cloudera-director-server
RUN \
  wget -q http://archive.cloudera.com/director6/${CD_VER}/tars/cloudera-director-client-latest.tar.gz && \
  tar zxf cloudera-director-client-*.tar.gz && \
  rm cloudera-director-client-*.tar.gz && \
  mv cloudera-director-[0-9]* cloudera-director-client

FROM openjdk:8-jre-alpine
COPY --from=build-env /app /app
ENV PATH $PATH:/app/cloudera-director-server/bin:/app/cloudera-director-client/bin
RUN \
  apk update && \
  apk add bash
ADD bin /usr/local/bin
RUN \
  chmod +x /usr/local/bin/* && \
  mkdir /workspace && \
  printf "\nlp.remote.hostAndPort: cloudera-director-server:7189\nlp.remote.username: admin\nlp.remote.password: admin\n" >> /app/cloudera-director-client/etc/application.properties
WORKDIR /workspace
CMD ["bash"]
