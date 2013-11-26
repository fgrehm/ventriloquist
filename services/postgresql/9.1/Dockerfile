# PostgreSQL 9.1

FROM fgrehm/ventriloquist-base

# prevent apt from starting postgres right after the installation
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d && \
    apt-get install -y -q postgresql-9.1 postgresql-contrib-9.1 && \
    apt-get clean && \
    rm /usr/sbin/policy-rc.d # allow autostart again

ADD config /
RUN /bin/prepare-postgres vagrant vagrant

EXPOSE  5432
CMD     ["/bin/start-postgres"]
