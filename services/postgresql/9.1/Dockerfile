# PostgreSQL 9.1

FROM fgrehm/ventriloquist-base

# prevent apt from starting postgres right after the installation
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get install -y -q postgresql-9.1 postgresql-contrib-9.1 && apt-get clean

# allow autostart again
RUN rm /usr/sbin/policy-rc.d

ADD config /
RUN /bin/prepare-postgres vagrant vagrant

EXPOSE  5432
CMD     ["/bin/start-postgres"]
