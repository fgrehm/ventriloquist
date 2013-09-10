# PostgreSQL 9.2
#
# VERSION               0.0.1

FROM fgrehm/ventriloquist-base
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

RUN add-apt-repository ppa:pitti/postgresql && apt-get update
RUN apt-get install -y postgresql-9.2 postgresql-contrib-9.2 && apt-get clean

ADD config /
RUN /bin/prepare-postgres vagrant vagrant

EXPOSE  5432:5432
CMD     ["/bin/start-postgres"]
