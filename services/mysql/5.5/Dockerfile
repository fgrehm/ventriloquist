# MySQL 5.5

FROM fgrehm/ventriloquist-base

# prevent apt from starting mysql right after the installation
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d && \
    apt-get -q -y install mysql-server-5.5 && \
    apt-get clean && \
    rm /usr/sbin/policy-rc.d # allow autostart again

ADD config /
RUN /bin/add-mysql-user vagrant vagrant

EXPOSE  3306
CMD     ["/usr/sbin/mysqld"]
