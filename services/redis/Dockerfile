# Redis Server

FROM fgrehm/ventriloquist-base

RUN wget -q http://download.redis.io/releases/redis-2.8.8.tar.gz -O /tmp/redis.tar.gz && \
    cd /tmp && \
    tar xvfz redis.tar.gz && \
    cd redis-2.8.8 && \
    make redis-server && \
    mv src/redis-server /usr/bin && \
    cd .. && rm -rf redis* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

EXPOSE 6379
CMD    ["/usr/bin/redis-server"]
