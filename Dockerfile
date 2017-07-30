FROM centos:latest

MAINTAINER Tsuyoshi Miyake <@tsuyokb>

ARG CD_VER=2
ENV CD_VER ${CD_VER}
ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
ENV JDK_VER jdk1.8.0_131

RUN mkdir -p /usr/java
WORKDIR /usr/java
RUN \
  curl -sOL --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JDK_URL} && \
  tar zxf jdk-*.tar.gz && rm jdk-*.tar.gz && \
  alternatives --install /usr/bin/java java /usr/java/${JDK_VER}/bin/java 1 && \
  alternatives --install /usr/bin/jar jar /usr/java/${JDK_VER}/bin/jar 1 && \
  alternatives --install /usr/bin/javac javac /usr/java/${JDK_VER}/bin/javac 1 && \
  alternatives --install /usr/bin/jps jps /usr/java/${JDK_VER}/bin/jps 1 && \
  echo JAVA_HOME=/usr/java/${JDK_VER} >> /etc/environment

WORKDIR /opt
RUN \
  curl -sOL http://archive.cloudera.com/director/director/${CD_VER}/cloudera-director-server-latest.tar.gz && \
  tar zxf cloudera-director-server-*.tar.gz && rm cloudera-director-server-*.tar.gz && \
  mv cloudera-director-server-* cloudera-director-server
RUN \
  curl -sOL http://archive.cloudera.com/director/director/${CD_VER}/cloudera-director-client-latest.tar.gz && \
  tar zxf cloudera-director-client-*.tar.gz && rm cloudera-director-client-*.tar.gz && \
  mv cloudera-director-[0-9]* cloudera-director-client

RUN yum -y install openssh-clients

ENV PATH $PATH:/opt/cloudera-director-client/bin
ADD bin /usr/bin
RUN chmod +x /usr/bin/cd-*
WORKDIR /opt/cloudera-director-server/bin
CMD ["sh", "-c", "./start && tail -f ../logs/application.log"]
