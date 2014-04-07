# MySQL 5.5

FROM fgrehm/ventriloquist-base

# prevent apt from starting mysql right after the installation
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -q -y install mysql-server-5.5 && \
    apt-get clean && \
    sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf && \
    apt-get clean && \
    rm /usr/sbin/policy-rc.d # allow autostart again

ADD config /
RUN /bin/add-mysql-user

EXPOSE  3306
CMD     ["/usr/sbin/mysqld"]
