# Dockerfile for Rethinkdb
# Based on https://github.com/crosbymichael/Dockerfiles/blob/master/rethinkdb/Dockerfile

FROM fgrehm/ventriloquist-base

RUN wget http://blog.anantshri.info/content/uploads/2010/09/add-apt-repository.sh.txt -O /tmp/add-apt-repository.sh.txt && \
    mv /tmp/add-apt-repository.sh.txt /usr/sbin/add-apt-repository && \
    chmod o+x /usr/sbin/add-apt-repository && \
    chown root:root /usr/sbin/add-apt-repository && \
    add-apt-repository ppa:rethinkdb/ppa && \
    apt-get update && \
    apt-get install -y rethinkdb && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

# create the /rethinkdb_data dir structure
RUN /usr/bin/rethinkdb create

# Rethinkdb process, cluster, and webui
EXPOSE 28015 29015 8080

CMD ["/usr/bin/rethinkdb", "--bind", "all"]
