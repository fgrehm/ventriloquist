# Base image for creating Ventriloquist services

FROM ubuntu:quantal
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y wget curl vim language-pack-en build-essential software-properties-common && \
    apt-get autoremove && \
    apt-get clean && \
    locale-gen en_US && \
    echo 'LANG="en_US.UTF-8"' >> /etc/default/locale
