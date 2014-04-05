# Memcached

FROM fgrehm/ventriloquist-base

RUN wget -q http://www.memcached.org/files/memcached-1.4.17.tar.gz -O /tmp/memcached.tar.gz && \
    cd /tmp && \
    tar xvfz memcached.tar.gz && \
    cd memcached-1.4.17 && \
    apt-get update && \
    apt-get install libevent-dev -y && \
    ./configure --prefix=/usr/local/memcached && \
    make && \
    make install && \
    cd .. && rm -rf memcached* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

EXPOSE 11211
CMD    ["/usr/local/memcached/bin/memcached", "-u", "daemon"]
