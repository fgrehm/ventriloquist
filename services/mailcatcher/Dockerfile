# MailCatcher

FROM fgrehm/ventriloquist-base

RUN apt-get update && \
    apt-get install -y \
      ruby \
      ruby-dev \
      sqlite3 \
      libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

RUN gem install mailcatcher --no-ri --no-rdoc

EXPOSE 1025
EXPOSE 1080
CMD    ["/usr/local/bin/mailcatcher", "-f", "--ip", "0.0.0.0"]
