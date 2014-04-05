# MySQL 5.6
# Somehow based on http://www.peterchen.net/2013/02/20/en-how-to-install-mysql-5-6-on-ubuntu-12-04-precise/

FROM fgrehm/ventriloquist-base

RUN apt-get update && \
    apt-get install libaio-dev -y && \
    wget -q http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.17-debian6.0-x86_64.deb -O /tmp/mysql.deb && \
    dpkg -i /tmp/mysql.deb && \
    rm /tmp/mysql.deb && \
    groupadd mysql && \
    useradd -r -g mysql mysql && \
    mkdir -p /etc/mysql/conf.d && \
    mkdir -p /var/log/mysql && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /opt/mysql/server-5.6 && \
    chown -R mysql:mysql /var/run/mysqld && \
    /opt/mysql/server-5.6/scripts/mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
    rm /opt/mysql/server-5.6/my*.cnf && \
    echo 'export PATH="/opt/mysql/server-5.6/bin:$PATH"' > /etc/profile.d/mysql.sh && \
    rm /opt/mysql/server-5.6/bin/mysqld-debug && \
    rm /opt/mysql/server-5.6/bin/mysqltest_* && \
    rm /opt/mysql/server-5.6/bin/mysql_client_test* && \
    rm /opt/mysql/server-5.6/lib/libmysqld-debug.a && \
    rm -rf /opt/mysql/server-5.6/mysql-test && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

ADD config /

RUN /bin/add-mysql-user

EXPOSE  3306
CMD     ["/opt/mysql/server-5.6/bin/mysqld"]
