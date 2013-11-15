# Dockerfile for Rethinkdb
# Based on https://github.com/crosbymichael/Dockerfiles/blob/master/rethinkdb/Dockerfile

FROM fgrehm/ventriloquist-base

RUN add-apt-repository ppa:rethinkdb/ppa && \
    apt-get update && \
    apt-get install -y rethinkdb

# create the /rethinkdb_data dir structure
RUN /usr/bin/rethinkdb create

# Rethinkdb process, cluster, and webui
EXPOSE 28015 29015 8080

CMD ["/usr/bin/rethinkdb", "--bind", "all"]
