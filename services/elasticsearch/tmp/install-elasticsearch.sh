#!/bin/sh

set -e

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.3.deb -O /tmp/elasticsearch.deb -q
dpkg -i /tmp/elasticsearch.deb
rm /tmp/elasticsearch.deb
