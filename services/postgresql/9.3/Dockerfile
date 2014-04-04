# PostgreSQL 9.3

FROM fgrehm/ventriloquist-base

RUN apt-get update && \
    apt-get install -y postgresql-9.3 postgresql-contrib-9.3 && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

ADD config /
RUN /bin/prepare-postgres vagrant vagrant

EXPOSE  5432
CMD     ["/bin/start-postgres"]
