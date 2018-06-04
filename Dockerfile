-------------------------------------------
net-tools / java 
-------------------------------------------
FROM ubuntu:16.04
MAINTAINER mysam

RUN apt-get update 
RUN apt-get install -y net-tools 
RUN apt-get install -y openssh-server
RUN apt-get install -y vim 
RUN apt-get install -y wget
RUN apt-get install -y apache2
RUN apt-get install -y openjdk-8-jdk
RUN apt-get clean

ENV TERM=xterm
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV CLASSPATH=$JAVA_HOME/lib/*:.
ENV PATH=$PATH:$JAVA_HOME/bin

RUN apt-get clean
RUN mkdir /var/run/sshd
RUN echo 'root:sam' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"] 
