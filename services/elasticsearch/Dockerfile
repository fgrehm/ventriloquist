# Elasticsearch 0.90.3
#
# VERSION               0.0.1

FROM fgrehm/ventriloquist-openjdk7
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

# TODO: Move this to base image
RUN apt-get install -y wget
RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.6.deb -O /tmp/elasticsearch.deb -q --no-check-certificate && \
    dpkg -i /tmp/elasticsearch.deb

EXPOSE 9200
CMD    ["/usr/share/elasticsearch/bin/elasticsearch", "-f"]
