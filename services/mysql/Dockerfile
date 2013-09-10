# MySQL 5.5
#
# VERSION               0.0.1

FROM fgrehm/ventriloquist-base
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

# prevent apt from starting mysql right after the installation
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get -q -y install mysql-server-5.5 && apt-get clean

# allow autostart again
RUN rm /usr/sbin/policy-rc.d

ADD config /
RUN /bin/add-mysql-user vagrant vagrant

EXPOSE  3306:3306
CMD     ["/usr/sbin/mysqld"]
