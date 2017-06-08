FROM centos:latest

MAINTAINER Tsuyoshi Miyake

ARG CD_VER=2
ENV CD_VER ${CD_VER}
ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
ENV JDK_VER jdk1.8.0_131

RUN yum -y install wget
RUN yum -y install iproute

WORKDIR /tmp
RUN wget -q --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JDK_URL}
RUN mkdir -p /usr/java
WORKDIR /usr/java
RUN tar zxf /tmp/jdk-*.tar.gz && rm /tmp/jdk-*.tar.gz
RUN alternatives --install /usr/bin/java java /usr/java/${JDK_VER}/bin/java 1
RUN alternatives --install /usr/bin/jar jar /usr/java/${JDK_VER}/bin/jar 1
RUN alternatives --install /usr/bin/javac javac /usr/java/${JDK_VER}/bin/javac 1
RUN alternatives --install /usr/bin/jps jps /usr/java/${JDK_VER}/bin/jps 1
RUN echo JAVA_HOME=/usr/java/${JDK_VER} >> /etc/environment

WORKDIR /etc/yum.repos.d
# RUN wget "http://archive.cloudera.com/director/redhat/7/x86_64/director/cloudera-director.repo"
RUN echo '[cloudera-director]' >> cloudera-director.repo
RUN echo '# Packages for Cloudera Director, Version 2, on RedHat or CentOS 7 x86_64' >> cloudera-director.repo
RUN echo 'name=Cloudera Director' >> cloudera-director.repo
RUN echo "baseurl=http://archive.cloudera.com/director/redhat/7/x86_64/director/${CD_VER}/" >> cloudera-director.repo
RUN echo 'gpgkey = http://archive.cloudera.com/director/redhat/7/x86_64/director/RPM-GPG-KEY-cloudera' >> cloudera-director.repo
RUN echo 'gpgcheck = 1' >> cloudera-director.repo
RUN yum -y install cloudera-director-plugins
RUN yum -y install cloudera-director-server
RUN yum -y install cloudera-director-client

WORKDIR /
CMD ["sh", "-c", "service cloudera-director-server start && tail -f /var/log/cloudera-director-server/application.log"]
