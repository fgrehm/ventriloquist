# Elasticsearch

FROM fgrehm/ventriloquist-openjdk7

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.deb -O /tmp/elasticsearch.deb -q --no-check-certificate && \
    dpkg -i /tmp/elasticsearch.deb && \
    rm /tmp/elasticsearch.deb

EXPOSE 9200
CMD    ["/usr/share/elasticsearch/bin/elasticsearch", "-f"]
