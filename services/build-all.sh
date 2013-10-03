#!/bin/sh

set -e

PREFIX='fgrehm/ventriloquist'

docker build -t ${PREFIX}-base base

docker build -t ${PREFIX}-pg:latest postgresql/9.2
docker tag ${PREFIX}-pg:latest ${PREFIX}-pg 9.2
docker build -t ${PREFIX}-pg:9.1 postgresql/9.1

docker build -t ${PREFIX}-mysql mysql

docker build -t ${PREFIX}-openjdk7 openjdk7
docker build -t ${PREFIX}-elasticsearch elasticsearch
docker build -t ${PREFIX}-solr solr

docker build -t ${PREFIX}-memcached memcached

docker build -t ${PREFIX}-redis redis

docker build -t ${PREFIX}-mailcatcher mailcatcher
