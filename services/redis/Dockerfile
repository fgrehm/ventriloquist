# Redis Server

FROM fgrehm/ventriloquist-base

# Make sure to update lib/ventriloquist/services/redis.rb if the version gets bumped
RUN wget -q http://download.redis.io/releases/redis-2.8.2.tar.gz -O /tmp/redis.tar.gz && \
    cd /tmp && \
    tar xvfz redis.tar.gz && \
    cd redis-2.8.2 && \
    make redis-server && \
    mv src/redis-server /usr/bin && \
    cd .. && rm -rf redis*

EXPOSE 6379
CMD    ["/usr/bin/redis-server"]
