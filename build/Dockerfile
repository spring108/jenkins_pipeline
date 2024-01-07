FROM ubuntu:20.04

#set time zone for java
RUN ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

RUN apt update
RUN apt install git -y
RUN apt install docker.io -y

RUN apt install default-jdk -y
RUN apt install maven -y
