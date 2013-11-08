# Elasticsearch 0.90.3
#
# VERSION               0.0.1

FROM fgrehm/ventriloquist-openjdk7
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

ADD . /
RUN /tmp/install-elasticsearch.sh && rm /tmp/install-elasticsearch.sh

EXPOSE 9200
CMD    ["/usr/share/elasticsearch/bin/elasticsearch", "-f"]
