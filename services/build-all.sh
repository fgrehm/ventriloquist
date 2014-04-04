#!/bin/sh

set -e

PREFIX='fgrehm/ventriloquist'

docker build --rm -t ${PREFIX}-base base

docker build --rm -t ${PREFIX}-pg-9.3 postgresql/9.3
docker build --rm -t ${PREFIX}-pg-9.2 postgresql/9.2
docker build --rm -t ${PREFIX}-pg-9.1 postgresql/9.1
#
# docker build -t ${PREFIX}-mysql mysql/5.6
# docker build -t ${PREFIX}-mysql:5.5 mysql/5.5
#
# docker build -t ${PREFIX}-rethinkdb rethinkdb
#
# docker build -t ${PREFIX}-openjdk7 openjdk7
# docker build -t ${PREFIX}-elasticsearch elasticsearch
#
# docker build -t ${PREFIX}-memcached memcached
#
docker build -t ${PREFIX}-redis-2.8 redis
#
# docker build -t ${PREFIX}-mailcatcher mailcatcher
