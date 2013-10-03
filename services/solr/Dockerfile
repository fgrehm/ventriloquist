# Solr 4.4.0
#
# VERSION               0.0.1

FROM fgrehm/ventriloquist-openjdk7

RUN curl http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/4.4.0/solr-4.4.0.tgz | tar zx -C /opt

EXPOSE 8983:8983
CMD    ["/bin/bash", "-c", "cd /opt/solr-4.4.0/example; java -jar start.jar"]
