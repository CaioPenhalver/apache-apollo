FROM debian:stable
MAINTAINER Caio Penhalver

RUN echo "deb http://ftp.debian.org/debian experimental main" >> /etc/apt/sources.list
RUN echo "deb http://ftp.debian.org/debian sid main" >> /etc/apt/sources.list
RUN apt-get update -qq
RUN apt-get install libc6 libstdc++6 unixodbc-dev -y --force-yes
RUN apt-get install -y --no-install-recommends vim locales curl gnupg

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="en_US.utf8"

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer

RUN curl -L -O http://ftp.unicamp.br/pub/apache/activemq/activemq-apollo/1.7.1/apache-apollo-1.7.1-unix-distro.tar.gz
RUN tar -zxvf apache-apollo-1.7.1-unix-distro.tar.gz
WORKDIR /apache-apollo-1.7.1
RUN ./bin/apollo create /var/lib/mybroker

RUN mkdir -p /workspace

WORKDIR /workspace
ADD . /workspace
