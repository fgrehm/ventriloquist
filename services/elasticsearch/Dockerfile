# Elasticsearch

FROM fgrehm/ventriloquist-openjdk7

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.0.deb -O /tmp/elasticsearch.deb -q --no-check-certificate && \
    dpkg -i /tmp/elasticsearch.deb && \
    rm /tmp/elasticsearch.deb && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

EXPOSE 9200
CMD    ["/usr/share/elasticsearch/bin/elasticsearch", "-f"]
