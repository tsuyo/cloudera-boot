FROM centos:latest

MAINTAINER Tsuyoshi Miyake

ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.tar.gz
ENV JDK_VER jdk1.8.0_102
ENV CONF_DIR /cloudera-boot

RUN yum -y install wget
WORKDIR /etc/yum.repos.d
RUN wget "http://archive.cloudera.com/director/redhat/7/x86_64/director/cloudera-director.repo"
RUN yum -y install cloudera-director-client

WORKDIR /tmp
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JDK_URL}
RUN mkdir -p /usr/java
WORKDIR /usr/java
RUN tar zxf /tmp/jdk-*.tar.gz && rm /tmp/jdk-*.tar.gz
RUN alternatives --install /usr/bin/java java /usr/java/${JDK_VER}/bin/java 1
RUN alternatives --install /usr/bin/jar jar /usr/java/${JDK_VER}/bin/jar 1
RUN alternatives --install /usr/bin/javac javac /usr/java/${JDK_VER}/bin/javac 1
RUN alternatives --install /usr/bin/jps jps /usr/java/${JDK_VER}/bin/jps 1
RUN echo JAVA_HOME=/usr/java/${JDK_VER} >> /etc/environment

WORKDIR ${CONF_DIR}
CMD [ "cloudera-director", "bootstrap", "cluster.conf" ]
