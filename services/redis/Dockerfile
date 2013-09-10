# Redis Server 2.4.15
#
# VERSION               0.0.1

FROM fgrehm/ventriloquist-base
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

RUN apt-get install -y redis-server

EXPOSE 6379:6379
CMD    ["/usr/bin/redis-server"]
