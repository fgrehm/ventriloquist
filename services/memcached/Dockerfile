# Memcached

FROM fgrehm/ventriloquist-base

RUN wget -q http://memcached.googlecode.com/files/memcached-1.4.15.tar.gz -O /tmp/memcached.tar.gz && \
    cd /tmp && \
    tar xvfz memcached.tar.gz && \
    cd memcached-1.4.15 && \
    apt-get install libevent1-dev -y && \
    ./configure --prefix=/usr/local/memcached && \
    make && \
    make install && \
    cd .. && rm -rf memcached*

EXPOSE 11211
CMD    ["/usr/local/memcached/bin/memcached", "-u", "daemon"]
