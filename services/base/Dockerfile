# Base image for creating Ventriloquist services

FROM debian:jessie
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

RUN apt-get update && apt-get install -y \
      git \
      libxml2-dev \
      build-essential \
      make \
      gcc \
      locales \
      curl \
      psmisc \
      vim \
      cron \
      python \
      logrotate \
      lsb-release \
      wget && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean
